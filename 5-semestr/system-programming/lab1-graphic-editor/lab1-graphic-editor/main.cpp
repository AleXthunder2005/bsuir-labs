#include <Windows.h>
#include "windowHelpers.h"
#include "graphicEditorModel.h"
#include "constants.h"

LRESULT CALLBACK WndProc(HWND, UINT, WPARAM, LPARAM);

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE, PSTR, int nCmdShow) {

    // Регистрация класса окна
    WNDCLASS wc = {};
    wc.lpfnWndProc = WndProc;
    wc.hInstance = hInstance;
    wc.lpszClassName = L"Graphic editor";
    wc.hCursor = LoadCursor(nullptr, IDC_ARROW);
    wc.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);

    RegisterClass(&wc);

    POINT windowPosition = CalculateWindowPosition(WS_WINDOW_WIDTH, WS_WINDOW_HEIGHT);
    HMENU hMenu = CreateGraphicEditorMenu();
    HWND hwnd = CreateWindow(wc.lpszClassName, L"Graphic editor",
        WS_OVERLAPPEDWINDOW, windowPosition.x, windowPosition.y,
        WS_WINDOW_WIDTH, WS_WINDOW_HEIGHT, nullptr, hMenu, hInstance, nullptr);

    ShowWindow(hwnd, nCmdShow);
    UpdateWindow(hwnd);

    // Цикл сообщений
    MSG msg = {};
    while (GetMessage(&msg, nullptr, 0, 0))
    {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }

    return 0;
}

LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
    switch (msg) {
    case WM_COMMAND:
        return handleCommand(hwnd, wParam, lParam);
    case WM_PAINT:
        return handlePaint(hwnd);
    case WM_LBUTTONDOWN:
        return handleLButtonDown(hwnd, lParam);
    case WM_MOUSEMOVE:
        return handleMouseMove(hwnd, lParam, wParam);
    case WM_LBUTTONUP:
        return handleLButtonUp(hwnd, lParam);
    case WM_MOUSEWHEEL:
        return handleMouseWheel(hwnd, wParam, lParam);
    case WM_DESTROY:
        return handleDestroy(hwnd);
    } 
    return DefWindowProc(hwnd, msg, wParam, lParam);
}