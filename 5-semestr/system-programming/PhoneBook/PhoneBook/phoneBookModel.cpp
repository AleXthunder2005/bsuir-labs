#include "phoneBookModel.h"
#include "windowHelpers.h"
#include "phoneBookLibrary.h"

LRESULT handleDestroy(HWND hwnd) {
    PostQuitMessage(0);
    return 0;
}

LRESULT handleCommand(HWND hwnd, WPARAM wParam, LPARAM lParam) {
    int wmId = LOWORD(wParam);
    switch (wmId) {
    case IDM_FILE_LOAD:
        handleLoadDatabase(hwnd);
        break;

    case IDM_FILE_UNLOAD:
        handleUnloadDatabase(hwnd);
        break;

    case IDM_FILE_EXIT:
        handleExit(hwnd);
        DestroyWindow(hwnd);
        break;

    case IDM_BTN_SEARCH:
        handleSearch(hwnd);
        break;
    }
    return 0;
}

std::vector<PhoneRecord> GetAllRecordsVector() {
    size_t count = GetRecordCount();
    if (count > 0) {
        PhoneRecord* pPhoneRecords = GetAllRecords();
        return std::vector<PhoneRecord>(pPhoneRecords, pPhoneRecords + count);
    }
    return {};
}

void handleLoadDatabase(HWND hwnd) {
    bool isSuccess = false;

    if (WasGlobalMappingObjectCreated()) { //если уже есть загруженный клиент
        if (LoadDatabase(NULL)) {
            isSuccess = true;
        }
    }
    else {
        std::wstring path = OpenDatabaseFileDialog(hwnd);
        if (!path.empty()) {
            if (LoadDatabase(path.c_str())) {
                isSuccess = true;
            }
        }
    }
    if (isSuccess) {
        PopulateListView(GetAllRecordsVector());
        MessageBoxW(
            hwnd,
            L"База данных успешно загружена и готова к работе.",
            L"Успешная загрузка",
            MB_OK | MB_ICONINFORMATION 
        );
    }
    else {
        MessageBoxW(
            hwnd,
            L"Не удалось загрузить базу данных.\nПроверьте путь к файлу или права доступа.",
            L"Ошибка загрузки",
            MB_OK | MB_ICONERROR
        );
    }
}
 

void handleUnloadDatabase(HWND hwnd) {
    UnloadDatabase();
    ClearListView();
    MessageBoxW(
        hwnd,
        L"База данных выгружена из памяти.\nДанные больше недоступны.",
        L"База выгружена",
        MB_OK | MB_ICONINFORMATION
    );
}

void handleExit(HWND hwnd) {
    PostQuitMessage(0);
}

void handleSearch(HWND hwnd) {
    PhoneRecord query = BuildFilterByControls();
    std::vector<PhoneRecord> results(GetRecordCount());
    int found = SearchRecords(&query, results.data(), (int)results.size());
    results.resize(found);

    PopulateListView(results);
}

