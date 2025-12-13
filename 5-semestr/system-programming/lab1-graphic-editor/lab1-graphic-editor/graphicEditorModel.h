#pragma once
#include <Windows.h>
#include <windowsx.h>
#include <vector>
#include <string>
#include "constants.h"

// Типы фигур
enum class DrawMode { NONE, LINE, RECTANGLE, ELLIPSE, TEXT };

// Структура фигуры
struct Shape {
    DrawMode type;
    std::vector<POINT> points;
    COLORREF color;
    std::wstring text;
    int fontSize;
};

// Структура результата ввода текста
struct TextDialogResult {
    bool confirmed;
    std::wstring text;
    int fontSize;
    COLORREF color;
};

// ================= ВСПОМОГАТЕЛЬНЫЕ =================
static POINT transformPoint(POINT p);
static RECT getShapeBounds(const Shape& s);
static RECT worldToClientRect(const RECT& wr);
void updateColorHistory(COLORREF selectedColor, COLORREF colorHistory[16]);
INT_PTR CALLBACK TextDialogProc(HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam);

// ================= ОБРАБОТЧИКИ =================
COLORREF handleChooseColor(HWND hwnd, COLORREF initialColor, COLORREF colorHistory[16]);
LRESULT handleCommand(HWND hwnd, WPARAM wParam, LPARAM lParam);
LRESULT handlePaint(HWND hwnd);
LRESULT handleLButtonDown(HWND hwnd, LPARAM lParam);
LRESULT handleMouseMove(HWND hwnd, LPARAM lParam, WPARAM wParam);
LRESULT handleLButtonUp(HWND hwnd, LPARAM lParam);
LRESULT handleMouseWheel(HWND hwnd, WPARAM wParam, LPARAM lParam);
LRESULT handleDestroy(HWND hwnd);

// ================= Сохранение / Загрузка EMF =================
void SaveToEMF(HWND hwnd, LPCWSTR filename);
void LoadFromEMF(HWND hwnd, LPCWSTR filename);

// ================= Печать =================
void PrintSelection(HWND hwnd, RECT selRect);