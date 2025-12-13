#pragma once
#include <Windows.h>
#include <windowsx.h>
#include <vector>
#include <string>
#include "constants.h"

// обработчики команд
void handleLoadDatabase(HWND hwnd);
void handleUnloadDatabase(HWND hwnd);
void handleExit(HWND hwnd);
void handleSearch(HWND hwnd);
void handleRunParallelSearch(HWND hwnd);

std::wstring OpenDatabaseFileDialog(HWND hwnd);
LRESULT handleCommand(HWND hwnd, WPARAM wParam, LPARAM lParam);
