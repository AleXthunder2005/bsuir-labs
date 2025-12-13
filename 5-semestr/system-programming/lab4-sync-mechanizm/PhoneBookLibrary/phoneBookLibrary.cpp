#include "pch.h"
#include "phoneBookLibrary.h"
#include "ThreadPool.h"
#include <string>
#include <vector>
#include <sstream>
#include <fstream>
#include <codecvt>
#include <cstring>
#include <windows.h>
#include <algorithm>
#include <mutex>
#include <future>

static bool Matches(const wchar_t* recordField, const wchar_t* queryField);
static std::vector<PhoneRecord> ParseCSV(const wchar_t* filename);

static HANDLE hMapFile = NULL;
static void* pSharedMem = NULL;
static PhoneRecord* pRecords = NULL;
static size_t* pRecordCount = NULL;

static ThreadPool* gThreadPool = nullptr;

const wchar_t* MAPPING_NAME = L"Global\\PhoneBookSharedMemory";
#define SHARED_MEM_SIZE (sizeof(size_t) + MAX_PHONE_RECORD_COUNT * sizeof(PhoneRecord))

// ----------------- API -----------------
PHONEBOOK_API bool LoadDatabase(const wchar_t* csvFile) {
    if (pSharedMem) return false;

    bool firstClient = false;
    hMapFile = OpenFileMappingW(FILE_MAP_ALL_ACCESS, FALSE, MAPPING_NAME);

    if (!hMapFile) {
        firstClient = true;
        hMapFile = CreateFileMappingW(INVALID_HANDLE_VALUE, NULL, PAGE_READWRITE, 0, SHARED_MEM_SIZE, MAPPING_NAME);
        if (!hMapFile) return false;
    }

    pSharedMem = MapViewOfFile(hMapFile, FILE_MAP_ALL_ACCESS, 0, 0, 0);
    if (!pSharedMem) {
        CloseHandle(hMapFile);
        hMapFile = NULL;
        return false;
    }

    pRecordCount = (size_t*)pSharedMem;
    pRecords = (PhoneRecord*)((char*)pSharedMem + sizeof(size_t));

    if (firstClient && csvFile && wcslen(csvFile) > 0) {
        std::vector<PhoneRecord> data = ParseCSV(csvFile);
        *pRecordCount = min(data.size(), (size_t)MAX_PHONE_RECORD_COUNT);
        memcpy(pRecords, data.data(), (*pRecordCount) * sizeof(PhoneRecord));
    }

    if (!gThreadPool) {
        try {
            gThreadPool = new ThreadPool();
        }
        catch (...) {
            UnmapViewOfFile(pSharedMem);
            pSharedMem = NULL;
            pRecords = NULL;
            pRecordCount = NULL;
            CloseHandle(hMapFile);
            hMapFile = NULL;
            return false;
        }
    }

    return true;
}

PHONEBOOK_API void UnloadDatabase() {
    if (!pSharedMem) return;

    if (gThreadPool) {
        gThreadPool->shutdown();
        delete gThreadPool;
        gThreadPool = nullptr;
    }

    UnmapViewOfFile(pSharedMem);
    pSharedMem = NULL;
    pRecords = NULL;
    pRecordCount = NULL;

    if (hMapFile) {
        CloseHandle(hMapFile);
        hMapFile = NULL;
    }
}

PHONEBOOK_API int SearchRecords(const PhoneRecord* query, PhoneRecord* results, int resultPhoneRecordMaxCount) {
    if (!pRecords || !pRecordCount) return 0;

    int count = 0;
    size_t total = *pRecordCount;
    for (size_t i = 0; i < total && count < resultPhoneRecordMaxCount; i++) {
        const PhoneRecord& rec = pRecords[i];

        bool match = true;
        if (!Matches(rec.phone, query->phone)) match = false;
        if (!Matches(rec.lastName, query->lastName)) match = false;
        if (!Matches(rec.firstName, query->firstName)) match = false;
        if (!Matches(rec.middleName, query->middleName)) match = false;
        if (!Matches(rec.street, query->street)) match = false;

        if (query->house > 0 && query->house != rec.house) match = false;
        if (query->building > 0 && query->building != rec.building) match = false;
        if (query->apartment > 0 && query->apartment != rec.apartment) match = false;

        if (match) results[count++] = rec;
    }
    return count;
}

PHONEBOOK_API size_t GetRecordCount() {
    return pRecordCount ? *pRecordCount : 0;
}

PHONEBOOK_API PhoneRecord* GetAllRecords() {
    return pRecords;
}

PHONEBOOK_API bool WasGlobalMappingObjectCreated() {
    bool wasCreated = false;
    HANDLE hMap = OpenFileMappingW(FILE_MAP_ALL_ACCESS, FALSE, MAPPING_NAME);
    if (hMap) {
        wasCreated = true;
        CloseHandle(hMap);
    }
    return wasCreated;
}

// ----------------- Параллельный поиск -----------------
static void SearchRecordsInRange(const PhoneRecord* query, size_t start, size_t end, std::vector<PhoneRecord>& outResults) {
    if (!pRecords || !pRecordCount) return;
    size_t total = *pRecordCount;
    if (start >= total) return;
    if (end > total) end = total;

    for (size_t i = start; i < end; ++i) {
        const PhoneRecord& rec = pRecords[i];

        bool match = true;
        if (!Matches(rec.phone, query->phone)) match = false;
        if (!Matches(rec.lastName, query->lastName)) match = false;
        if (!Matches(rec.firstName, query->firstName)) match = false;
        if (!Matches(rec.middleName, query->middleName)) match = false;
        if (!Matches(rec.street, query->street)) match = false;

        if (query->house > 0 && query->house != rec.house) match = false;
        if (query->building > 0 && query->building != rec.building) match = false;
        if (query->apartment > 0 && query->apartment != rec.apartment) match = false;

        if (match) outResults.push_back(rec);
    }
}

PHONEBOOK_API bool RunParallelSearchFromFile(const wchar_t* queriesFile, const wchar_t* outputFile) {
    if (!pRecords || !pRecordCount || !gThreadPool) return false;
    if (!queriesFile || wcslen(queriesFile) == 0) return false;
    if (!outputFile || wcslen(outputFile) == 0) return false;

    // парсим файл запросов — берем только первую строку как запрос
    std::vector<PhoneRecord> queries = ParseCSV(queriesFile);
    if (queries.empty()) return false;
    PhoneRecord query = queries[0]; // единственный запрос для параллельного поиска

    const size_t totalRecords = *pRecordCount;
    if (totalRecords == 0) return false;

    // число чанков: hardware_concurrency или 1
    unsigned int concurrency = std::thread::hardware_concurrency();
    if (concurrency == 0) concurrency = 1;
    // не создавать больше чанков, чем записей
    size_t chunks = std::min<size_t>(concurrency, totalRecords);

    std::vector<std::future<std::vector<PhoneRecord>>> futures;
    futures.reserve(chunks); //выделяет память под chunks элементов

    size_t baseChunkSize = totalRecords / chunks;
    size_t remainder = totalRecords % chunks;

    size_t offset = 0;
    for (size_t ci = 0; ci < chunks; ++ci) {
        size_t thisChunkSize = baseChunkSize + (ci < remainder ? 1 : 0); //вычисляет размер каждого чанка (распределяет остаток по 1)
        size_t start = offset;
        size_t end = start + thisChunkSize;
        offset = end;

        // Копируем query и границы в таску
        PhoneRecord qcopy = query;
        auto fut = gThreadPool->enqueue([qcopy, start, end]() -> std::vector<PhoneRecord> {
            std::vector<PhoneRecord> found;
            // Поиск только в диапазоне
            SearchRecordsInRange(&qcopy, start, end, found);
            return found;
            });

        futures.emplace_back(std::move(fut));
    }

    // Собираем результаты из всех чанков
    std::vector<PhoneRecord> allResults;
    for (auto& f : futures) {
        try {
            std::vector<PhoneRecord> part = f.get();
            if (!part.empty()) {
                // добавляем результаты (объединяем)
                allResults.insert(allResults.end(), part.begin(), part.end());
            }
        }
        catch (...) {
            
        }
    }

    // Формируем отчет: сначала количество уникальных результатов 
    std::wstringstream ss;
    ss << L"Запрос: ";
    // Печатаем коротко поля запроса
    ss << query.phone << L";" << query.lastName << L";" << query.firstName << L";" << query.middleName << L";" << query.street << L";"
        << query.house << L";" << query.building << L";" << query.apartment << L"\n";
    ss << L"Всего найдено: " << allResults.size() << L"\n\n";

    for (size_t i = 0; i < allResults.size(); ++i) {
        const PhoneRecord& r = allResults[i];
        ss << r.phone << L";"
            << r.lastName << L";"
            << r.firstName << L";"
            << r.middleName << L";"
            << r.street << L";"
            << r.house << L";"
            << r.building << L";"
            << r.apartment << L"\n";
    }

    // Записываем в UTF-8
    try {
        std::wofstream out(outputFile);
        out.imbue(std::locale(out.getloc(), new std::codecvt_utf8<wchar_t>));
        out << ss.str();
        out.close();
    }
    catch (...) {
        return false;
    }

    return true;
}

// ----------------- Вспомогательные -----------------
static bool Matches(const wchar_t* recordField, const wchar_t* queryField) {
    if (!queryField || wcslen(queryField) == 0) return true;
    if (!recordField) return false;
    return wcsstr(recordField, queryField) != nullptr;
}

static std::vector<PhoneRecord> ParseCSV(const wchar_t* filename) {
    std::vector<PhoneRecord> records;
    std::wifstream file(filename);
    file.imbue(std::locale(file.getloc(), new std::codecvt_utf8<wchar_t>));

    std::wstring line;
    while (std::getline(file, line)) {
        std::wstringstream ss(line);
        std::wstring field;
        PhoneRecord rec{};

        std::getline(ss, field, L';'); wcsncpy_s(rec.phone, field.c_str(), _TRUNCATE);
        std::getline(ss, field, L';'); wcsncpy_s(rec.lastName, field.c_str(), _TRUNCATE);
        std::getline(ss, field, L';'); wcsncpy_s(rec.firstName, field.c_str(), _TRUNCATE);
        std::getline(ss, field, L';'); wcsncpy_s(rec.middleName, field.c_str(), _TRUNCATE);
        std::getline(ss, field, L';'); wcsncpy_s(rec.street, field.c_str(), _TRUNCATE);

        std::getline(ss, field, L';'); rec.house = _wtoi(field.c_str());
        std::getline(ss, field, L';'); rec.building = _wtoi(field.c_str());
        std::getline(ss, field, L';'); rec.apartment = _wtoi(field.c_str());

        records.push_back(rec);
    }
    return records;
}
