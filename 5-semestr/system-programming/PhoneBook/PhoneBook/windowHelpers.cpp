#include "windowHelpers.h"
#include <CommCtrl.h>
#include "phoneBookModel.h"
#include <sstream>
#include "constants.h"

#pragma comment(lib, "Comctl32.lib")

POINT CalculateWindowPosition(int windowWidth, int windowHeight)
{
    POINT position;
    
    int screenWidth = GetSystemMetrics(SM_CXSCREEN);
    int screenHeight = GetSystemMetrics(SM_CYSCREEN);

    position.x = (screenWidth - windowWidth) / 2;
    position.y = (screenHeight - windowHeight) / 2;

    return position;
}

HMENU CreateGraphicEditorMenu() {
    // Создание меню
    HMENU hMenu = CreateMenu();
    HMENU hFileMenu = CreatePopupMenu();

    // Меню File
    AppendMenu(hFileMenu, MF_STRING, IDM_FILE_LOAD, L"&Load db");
    AppendMenu(hFileMenu, MF_STRING, IDM_FILE_UNLOAD, L"&Unload db");
    AppendMenu(hFileMenu, MF_STRING, IDM_FILE_EXIT, L"E&xit");

    // Главное меню
    AppendMenu(hMenu, MF_POPUP, (UINT_PTR)hFileMenu, L"File");

    return hMenu;
}

// Глобальные хендлы контролов
HWND hEdits[8];
HWND hListView;

// Названия для статиков и колонок
const wchar_t* labels[8] = {
    L"Телефон", L"Фамилия", L"Имя", L"Отчество",
    L"Улица", L"Дом", L"Корпус", L"Квартира"
};

// Инициализация контролов
void InitControls(HWND hwnd) {
    HFONT hFont = (HFONT)GetStockObject(DEFAULT_GUI_FONT);

    int x1 = 20, x2 = 120, y = 20, w1 = 90, w2 = 250, h = 22, dy = 30;
    int x3 = 420; // для правой части (улица, дом...)

    // Первые 4 (слева)
    for (int i = 0; i < 4; i++) {
        CreateWindow(L"STATIC", labels[i], WS_CHILD | WS_VISIBLE,
            x1, y + i * dy, w1, h, hwnd, nullptr, nullptr, nullptr);

        hEdits[i] = CreateWindow(L"EDIT", L"", WS_CHILD | WS_VISIBLE | WS_BORDER | ES_AUTOHSCROLL,
            x2, y + i * dy, w2, h, hwnd, nullptr, nullptr, nullptr);

        SendMessage(hEdits[i], WM_SETFONT, (WPARAM)hFont, TRUE);
    }

    // Следующие 4 (справа)
    for (int i = 4; i < 8; i++) {
        CreateWindow(L"STATIC", labels[i], WS_CHILD | WS_VISIBLE,
            x3, y + (i - 4) * dy, w1, h, hwnd, nullptr, nullptr, nullptr);

        hEdits[i] = CreateWindow(L"EDIT", L"", WS_CHILD | WS_VISIBLE | WS_BORDER | ES_AUTOHSCROLL,
            x3 + w1 + 10, y + (i - 4) * dy, w2, h, hwnd, nullptr, nullptr, nullptr);

        SendMessage(hEdits[i], WM_SETFONT, (WPARAM)hFont, TRUE);
    }

    // Кнопка "Найти"
    HWND hBtn = CreateWindow(L"BUTTON", L"Найти", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON,
        x1, y + 4 * dy + 10, 750, h + 5, hwnd, (HMENU)IDM_BTN_SEARCH, nullptr, nullptr);
    SendMessage(hBtn, WM_SETFONT, (WPARAM)hFont, TRUE);

    // ListView
    INITCOMMONCONTROLSEX icex;
    icex.dwSize = sizeof(icex);
    icex.dwICC = ICC_LISTVIEW_CLASSES;
    InitCommonControlsEx(&icex);

    hListView = CreateWindow(WC_LISTVIEW, L"", WS_CHILD | WS_VISIBLE | LVS_REPORT | LVS_SINGLESEL,
        20, y + 4 * dy + 50, 750, 300, hwnd, (HMENU)200, nullptr, nullptr);

    SendMessage(hListView, WM_SETFONT, (WPARAM)hFont, TRUE);

    // Добавляем колонки
    LVCOLUMN lvc{};
    lvc.mask = LVCF_TEXT | LVCF_WIDTH | LVCF_SUBITEM;
    const wchar_t* colNames[8] = {
        L"Телефон", L"Фамилия", L"Имя", L"Отчество",
        L"Улица", L"Дом", L"Корпус", L"Квартира"
    };
    int colWidths[8] = { 100,100,100,100,150,60,60,80 };

    for (int i = 0; i < 8; i++) {
        lvc.iSubItem = i;
        lvc.cx = colWidths[i];
        lvc.pszText = (LPWSTR)colNames[i];
        ListView_InsertColumn(hListView, i, &lvc);
    }
}

// Добавление записи в ListView
void AddRecordToListView(const PhoneRecord& rec) {
    LVITEM lvi{};
    lvi.mask = LVIF_TEXT;
    lvi.iItem = ListView_GetItemCount(hListView);
    lvi.iSubItem = 0;
    lvi.pszText = (LPWSTR)rec.phone;
    int index = ListView_InsertItem(hListView, &lvi);

    ListView_SetItemText(hListView, index, 1, (LPWSTR)rec.lastName);
    ListView_SetItemText(hListView, index, 2, (LPWSTR)rec.firstName);
    ListView_SetItemText(hListView, index, 3, (LPWSTR)rec.middleName);
    ListView_SetItemText(hListView, index, 4, (LPWSTR)rec.street);

    wchar_t buf[32];
    swprintf(buf, 32, L"%d", rec.house);
    ListView_SetItemText(hListView, index, 5, buf);

    swprintf(buf, 32, L"%d", rec.building);
    ListView_SetItemText(hListView, index, 6, buf);

    swprintf(buf, 32, L"%d", rec.apartment);
    ListView_SetItemText(hListView, index, 7, buf);
}

// Вывод сразу нескольких записей
void PopulateListView(const std::vector<PhoneRecord>& records) {
    ListView_DeleteAllItems(hListView);
    for (const auto& rec : records) {
        AddRecordToListView(rec);
    }
}



void ClearListView() {
    ListView_DeleteAllItems(hListView);
}

void ShowRecordInMessageBox(const PhoneRecord& rec) {
    std::wstringstream ss;
    ss << L"Телефон: " << rec.phone << L"\n"
        << L"Фамилия: " << rec.lastName << L"\n"
        << L"Имя: " << rec.firstName << L"\n"
        << L"Отчество: " << rec.middleName << L"\n"
        << L"Улица: " << rec.street << L"\n"
        << L"Дом: " << rec.house << L"\n"
        << L"Корпус: " << rec.building << L"\n"
        << L"Квартира: " << rec.apartment;

    MessageBox(NULL, ss.str().c_str(), L"Содержимое записи", MB_OK);
}

PhoneRecord BuildFilterByControls() {
    PhoneRecord filter;
    // Заполним нулями / дефолтными значениями
    ZeroMemory(&filter, sizeof(filter));
    filter.house = filter.building = filter.apartment = -1;

    wchar_t buf[256];

    // Phone
    GetWindowTextW(hEdits[0], buf, _countof(buf));
    wcsncpy_s(filter.phone, buf, _TRUNCATE);

    // LastName
    GetWindowTextW(hEdits[1], buf, _countof(buf));
    wcsncpy_s(filter.lastName, buf, _TRUNCATE);

    // FirstName
    GetWindowTextW(hEdits[2], buf, _countof(buf));
    wcsncpy_s(filter.firstName, buf, _TRUNCATE);

    // MiddleName
    GetWindowTextW(hEdits[3], buf, _countof(buf));
    wcsncpy_s(filter.middleName, buf, _TRUNCATE);

    // Street
    GetWindowTextW(hEdits[4], buf, _countof(buf));
    wcsncpy_s(filter.street, buf, _TRUNCATE);

    // House
    GetWindowTextW(hEdits[5], buf, _countof(buf));
    if (wcslen(buf) > 0) filter.house = _wtoi(buf); else filter.house = -1;

    // Building
    GetWindowTextW(hEdits[6], buf, _countof(buf));
    if (wcslen(buf) > 0) filter.building = _wtoi(buf); else filter.building = -1;

    // Apartment
    GetWindowTextW(hEdits[7], buf, _countof(buf));
    if (wcslen(buf) > 0) filter.apartment = _wtoi(buf); else filter.apartment = -1;

    //ShowRecordInMessageBox(filter);

    return filter;
}

std::wstring OpenDatabaseFileDialog(HWND hwnd) {
    wchar_t filename[MAX_PATH] = L"";

    OPENFILENAME ofn{};
    ofn.lStructSize = sizeof(ofn);
    ofn.hwndOwner = hwnd;
    ofn.lpstrFilter = L"CSV Files (*.csv)\0*.csv\0All Files\0*.*\0";
    ofn.lpstrFile = filename;
    ofn.nMaxFile = MAX_PATH;
    ofn.Flags = OFN_FILEMUSTEXIST | OFN_PATHMUSTEXIST;
    ofn.lpstrDefExt = L"csv";

    if (GetOpenFileNameW(&ofn)) {
        return std::wstring(filename);
    }
    return L""; // отмена
}