#include "windowHelpers.h"

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
    HMENU hDrawMenu = CreatePopupMenu();
    HMENU hColorMenu = CreatePopupMenu();

    // Меню File
    AppendMenu(hFileMenu, MF_STRING, IDM_FILE_OPEN, L"&Open");
    AppendMenu(hFileMenu, MF_STRING, IDM_FILE_SAVE, L"&Save");
    AppendMenu(hFileMenu, MF_SEPARATOR, 0, nullptr);
    AppendMenu(hFileMenu, MF_STRING, IDM_FILE_CLEAR, L"&Clear");
    AppendMenu(hFileMenu, MF_STRING, IDM_FILE_PRINT, L"&Print");
    AppendMenu(hFileMenu, MF_SEPARATOR, 0, nullptr);
    AppendMenu(hFileMenu, MF_STRING, IDM_FILE_EXIT, L"E&xit");

    // Меню Draw
    AppendMenu(hDrawMenu, MF_STRING, IDM_DRAW_LINE, L"&Line");
    AppendMenu(hDrawMenu, MF_STRING, IDM_DRAW_RECTANGLE, L"&Rectangle");
    AppendMenu(hDrawMenu, MF_STRING, IDM_DRAW_ELLIPSE, L"&Ellipse");
    AppendMenu(hDrawMenu, MF_STRING, IDM_DRAW_TEXT, L"&Text");
    AppendMenu(hDrawMenu, MF_STRING, IDM_DRAW_NONE, L"&None");

    // Меню Color
    AppendMenu(hColorMenu, MF_STRING, IDM_COLOR_PICKER, L"&Choose Color...");

    // Главное меню
    AppendMenu(hMenu, MF_POPUP, (UINT_PTR)hFileMenu, L"File");
    AppendMenu(hMenu, MF_POPUP, (UINT_PTR)hDrawMenu, L"Draw");
    AppendMenu(hMenu, MF_POPUP, (UINT_PTR)hColorMenu, L"Color");

    return hMenu;
}