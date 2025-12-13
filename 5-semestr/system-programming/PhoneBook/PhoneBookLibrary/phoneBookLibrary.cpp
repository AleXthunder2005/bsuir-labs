#include "pch.h"
#include "phoneBookLibrary.h"
#include <string>
#include <vector>
#include <sstream>
#include <fstream>
#include <codecvt>
#include <cstring>
#include <windows.h>
//#include <AclAPI.h>

static bool Matches(const wchar_t* recordField, const wchar_t* queryField);
static std::vector<PhoneRecord> ParseCSV(const wchar_t* filename);

// Глобальные переменные процесса
static HANDLE hMapFile = NULL;
static void* pSharedMem = NULL;
static PhoneRecord* pRecords = NULL;
static size_t* pRecordCount = NULL;
//static size_t nRecordsCount = 0;

// Имя разделяемой памяти
const wchar_t* MAPPING_NAME = L"Global\\PhoneBookSharedMemory";
#define SHARED_MEM_SIZE (sizeof(size_t) + MAX_PHONE_RECORD_COUNT * sizeof(PhoneRecord))

// ----------------- API -----------------
PHONEBOOK_API bool LoadDatabase(const wchar_t* csvFile) {
    if (pSharedMem) return false; // уже загружено

    bool firstClient = false;

    // Пытаемся открыть уже существующее отображение
    hMapFile = OpenFileMappingW(FILE_MAP_ALL_ACCESS, FALSE, MAPPING_NAME);

    if (!hMapFile) {
        // Если не найдено — создаём новое
        firstClient = true;
        hMapFile = CreateFileMappingW(
            INVALID_HANDLE_VALUE,
            NULL,
            PAGE_READWRITE,
            0,
            SHARED_MEM_SIZE,
            MAPPING_NAME
        );
        if (!hMapFile) return false;
    }

    // Отображаем память в адресное пространство
    pSharedMem = MapViewOfFile(hMapFile, FILE_MAP_ALL_ACCESS, 0, 0, 0);
    if (!pSharedMem) {
        CloseHandle(hMapFile);
        hMapFile = NULL;
        return false;
    }

    // Переменные на участки памяти
    pRecordCount = (size_t*)pSharedMem;
    pRecords = (PhoneRecord*)((char*)pSharedMem + sizeof(size_t));

    // Если первый клиент — загружаем CSV
    if (firstClient && csvFile && wcslen(csvFile) > 0) {
        std::vector<PhoneRecord> data = ParseCSV(csvFile);
        *pRecordCount = min(data.size(), (size_t)MAX_PHONE_RECORD_COUNT);
        memcpy(pRecords, data.data(), *pRecordCount * sizeof(PhoneRecord)); //копируем туда все записи (там где они начинаются)
    }

    return true;
}

PHONEBOOK_API void UnloadDatabase() {
    if (!pSharedMem) return;

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
    if (!pRecords) return 0;

    int count = 0;
    for (size_t i = 0; i <resultPhoneRecordMaxCount; i++) {
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
    HANDLE hMapFile = OpenFileMappingW(FILE_MAP_ALL_ACCESS, FALSE, MAPPING_NAME);
    if (hMapFile) {
        wasCreated = true;
        CloseHandle(hMapFile);
    }
    return wasCreated;
}

// ----------------- Поиск по подстроке -----------------
static bool Matches(const wchar_t* recordField, const wchar_t* queryField) {
    if (!queryField || wcslen(queryField) == 0) return true;
    //if (!recordField) return false;
    return wcsstr(recordField, queryField) != nullptr;
}

// ----------------- CSV парсер -----------------
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

