#pragma once
#include <Windows.h>
#include <string>
#include <vector>
#include "phoneBookLibrary.h"

// функции для UI
POINT CalculateWindowPosition(int windowWidth, int windowHeight);
HMENU CreateGraphicEditorMenu();
void InitControls(HWND hwnd);
void PopulateListView(const std::vector<PhoneRecord>& records);
PhoneRecord BuildFilterByControls();
void PopulateListView(const std::vector<PhoneRecord>& records);
void ClearListView();
