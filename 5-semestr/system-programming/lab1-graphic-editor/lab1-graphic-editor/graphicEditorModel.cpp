#include "graphicEditorModel.h"
#include "constants.h"
#include "resource.h"
#include <commdlg.h>
#include <string>

static std::vector<Shape> shapes;

static bool isDrawing = false;
static Shape currentShape;        
static DrawMode currentDrawMode = DrawMode::NONE;
static COLORREF currentColor = RGB(255, 0, 0);

static bool isSelecting = false;   
static RECT selectionRect = {};    // текущий прямоугольник выделения

static COLORREF colorHistory[16] = {};

static double zoom = 1.0;
static int panX = 0, panY = 0;
static TextDialogResult textDialogResult;

// обработчики сообщений
static HENHMETAFILE g_backgroundEMF = NULL;

// wParam: LOWORD = ID команды (меню/контрола) lParam: HWND источника (если это контрол), иначе 0 (если меню или акселератор)
LRESULT handleCommand(HWND hwnd, WPARAM wParam, LPARAM lParam) { 
    int wmId = LOWORD(wParam);
    switch (wmId) {
        case IDM_DRAW_LINE:
            currentDrawMode = DrawMode::LINE;
            break;
        case IDM_DRAW_RECTANGLE:
            currentDrawMode = DrawMode::RECTANGLE;
            break;
        case IDM_DRAW_ELLIPSE:
            currentDrawMode = DrawMode::ELLIPSE;
            break;
        case IDM_DRAW_TEXT:
            currentDrawMode = DrawMode::TEXT;
            break;
        case IDM_DRAW_NONE:
            currentDrawMode = DrawMode::NONE;
            break;
        case IDM_COLOR_PICKER:
            currentColor = handleChooseColor(hwnd, currentColor, colorHistory);
            break;
        case IDM_FILE_OPEN: {
            OPENFILENAME ofn = {};
            wchar_t filename[MAX_PATH] = {};
            ofn.lStructSize = sizeof(ofn);
            ofn.hwndOwner = hwnd;
            ofn.lpstrFilter = L"Enhanced Metafile (*.emf)\0*.emf\0";
            ofn.lpstrFile = filename;
            ofn.nMaxFile = MAX_PATH;
            ofn.Flags = OFN_FILEMUSTEXIST;

            if (GetOpenFileName(&ofn)) {
                LoadFromEMF(hwnd, filename);
                InvalidateRect(hwnd, nullptr, TRUE);
            }
            break;
        }
        case IDM_FILE_SAVE: {
            OPENFILENAME ofn = {};
            wchar_t filename[MAX_PATH] = {};
            ofn.lStructSize = sizeof(ofn);
            ofn.hwndOwner = hwnd;
            ofn.lpstrFilter = L"Enhanced Metafile (*.emf)\0*.emf\0";
            ofn.lpstrFile = filename;
            ofn.nMaxFile = MAX_PATH;
            ofn.Flags = OFN_OVERWRITEPROMPT;

            if (GetSaveFileName(&ofn)) {
                SaveToEMF(hwnd, filename);
            }
            break;
        }
        case IDM_FILE_CLEAR: {   
            if (g_backgroundEMF) {
                DeleteEnhMetaFile(g_backgroundEMF);
                g_backgroundEMF = NULL;
            }
            shapes.clear();
            currentShape.points.clear();
            isDrawing = false;

            zoom = 1.0;
            panX = panY = 0;

            InvalidateRect(hwnd, nullptr, TRUE);
            break;
        }
        case IDM_FILE_PRINT:
            // Входим в режим выделения прямоугольника мышью
            isSelecting = true;
            selectionRect = { 0,0,0,0 };
            currentDrawMode = DrawMode::NONE;
            MessageBox(hwnd, L"Выделите прямоугольную область для печати.", L"Печать", MB_OK);
            break;
        case IDM_FILE_EXIT:
            PostQuitMessage(0);
            break;
    }
    return 0;
}

COLORREF handleChooseColor(HWND hwnd, COLORREF initialColor, COLORREF colorHistory[16]) {
    CHOOSECOLOR cc = {};
    cc.lStructSize = sizeof(cc);
    cc.hwndOwner = hwnd;
    cc.lpCustColors = colorHistory;
    cc.rgbResult = initialColor;
    cc.Flags = CC_FULLOPEN | CC_RGBINIT;

    if (ChooseColor(&cc)) {
        COLORREF selectedColor = cc.rgbResult;
        updateColorHistory(selectedColor, colorHistory);
        return selectedColor;
    }

    return initialColor;
}

LRESULT handlePaint(HWND hwnd) {
    PAINTSTRUCT ps;
    HDC hdc = BeginPaint(hwnd, &ps);

    // перевод координат фигур из мировых в клиентские
    SetGraphicsMode(hdc, GM_ADVANCED);
    XFORM xf;
    xf.eM11 = zoom; xf.eM12 = 0.0f;
    xf.eM21 = 0.0f; xf.eM22 = zoom;
    xf.eDx = (FLOAT)panX; xf.eDy = (FLOAT)panY;
    SetWorldTransform(hdc, &xf);

    RECT clientRect;
    GetClientRect(hwnd, &clientRect);

    if (g_backgroundEMF) {
        RECT temp;
        if (IntersectRect(&temp, &ps.rcPaint, &clientRect)) {
            PlayEnhMetaFile(hdc, g_backgroundEMF, &clientRect);
        }
    }

    for (auto& s : shapes) {
        // Проверяем пересечение фигуры с областью обновления
        if (s.points.size() >= 2) {
            RECT shapeRect = {
                min(s.points[0].x, s.points[1].x),
                min(s.points[0].y, s.points[1].y),
                max(s.points[0].x, s.points[1].x),
                max(s.points[0].y, s.points[1].y)
            };
            RECT temp;

            RECT clientShapeRect = worldToClientRect(shapeRect);

            if (!IntersectRect(&temp, &clientShapeRect, &ps.rcPaint)) {
                continue; // не пересекается → не рисуем
            }
        }

        HPEN hPen = CreatePen(PS_SOLID, 2, s.color);
        HGDIOBJ oldPen = SelectObject(hdc, hPen);
        HBRUSH hBrush = (HBRUSH)GetStockObject(HOLLOW_BRUSH);
        HGDIOBJ oldBrush = SelectObject(hdc, hBrush);

        switch (s.type) {
        case DrawMode::LINE:
            if (s.points.size() >= 2) {
                MoveToEx(hdc, s.points[0].x, s.points[0].y, nullptr);//nullptr это указатель на структуру для старого положения пера
                LineTo(hdc, s.points[1].x, s.points[1].y);
            }
            break;
        case DrawMode::RECTANGLE:
            if (s.points.size() >= 2) {
                Rectangle(hdc, s.points[0].x, s.points[0].y,
                    s.points[1].x, s.points[1].y);
            }
            break;
        case DrawMode::ELLIPSE:
            if (s.points.size() >= 2) {
                Ellipse(hdc, s.points[0].x, s.points[0].y,
                    s.points[1].x, s.points[1].y);
            }
            break;
        case DrawMode::TEXT:
            if (!s.text.empty() && s.points.size() >= 1) {
                HFONT hFont = CreateFontW(
                    //отрицательный - потому что задана высота СИМВОЛА, а не ячейки под символ
                    //MulDiv(a, b, c) - a / c * b (перевести в размер учетом DPI устройства hdc)
                    //GetDeviceCaps - получить характеристики устройства
                    -MulDiv(s.fontSize, GetDeviceCaps(hdc, LOGPIXELSY), 72),
                    0, 0, 0, FW_NORMAL, FALSE, FALSE, FALSE,
                    DEFAULT_CHARSET, OUT_DEFAULT_PRECIS,
                    CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY,
                    DEFAULT_PITCH | FF_SWISS, L"Segoe UI");
                HGDIOBJ oldFont = SelectObject(hdc, hFont);

                SetTextColor(hdc, s.color);
                SetBkMode(hdc, TRANSPARENT);
                TextOutW(hdc, s.points[0].x, s.points[0].y, s.text.c_str(), (int)s.text.size());

                SelectObject(hdc, oldFont);
                DeleteObject(hFont);
            }
            break;
        }

        SelectObject(hdc, oldPen);
        SelectObject(hdc, oldBrush);
        DeleteObject(hPen);
    }

    // Текущая фигура (во время рисования)
    if (isDrawing && currentShape.points.size() >= 2) {
        RECT shapeRect = worldToClientRect(getShapeBounds(currentShape));
        RECT temp;
        if (IntersectRect(&temp, &shapeRect, &ps.rcPaint)) {
            HPEN hPen = CreatePen(PS_DOT, 1, currentShape.color);
            HGDIOBJ oldPen = SelectObject(hdc, hPen);
            HBRUSH hBrush = (HBRUSH)GetStockObject(HOLLOW_BRUSH);
            HGDIOBJ oldBrush = SelectObject(hdc, hBrush);

            switch (currentShape.type) {
            case DrawMode::LINE:
                MoveToEx(hdc, currentShape.points[0].x, currentShape.points[0].y, nullptr);
                LineTo(hdc, currentShape.points[1].x, currentShape.points[1].y);
                break;
            case DrawMode::RECTANGLE:
                Rectangle(hdc, currentShape.points[0].x, currentShape.points[0].y,
                    currentShape.points[1].x, currentShape.points[1].y);
                break;
            case DrawMode::ELLIPSE:
                Ellipse(hdc, currentShape.points[0].x, currentShape.points[0].y,
                    currentShape.points[1].x, currentShape.points[1].y);
                break;
            default:
                break;
            }

            SelectObject(hdc, oldPen);
            SelectObject(hdc, oldBrush);
            DeleteObject(hPen);
        }
    }

    // Рисуем рамку выделения (selectionRect)
    if (isSelecting && (selectionRect.right != selectionRect.left) && (selectionRect.bottom != selectionRect.top)) {
        RECT norm = selectionRect;
        if (norm.right < norm.left) std::swap(norm.left, norm.right);
        if (norm.bottom < norm.top) std::swap(norm.top, norm.bottom);

        HPEN hPen = CreatePen(PS_DOT, 1, RGB(0, 0, 255));
        HGDIOBJ oldPen = SelectObject(hdc, hPen);
        HBRUSH hBrush = (HBRUSH)GetStockObject(NULL_BRUSH);
        HGDIOBJ oldBrush = SelectObject(hdc, hBrush);

        Rectangle(hdc, norm.left, norm.top, norm.right, norm.bottom);

        SelectObject(hdc, oldPen);
        SelectObject(hdc, oldBrush);
        DeleteObject(hPen);
    }

    EndPaint(hwnd, &ps);
    return 0;
}

LRESULT handleLButtonDown(HWND hwnd, LPARAM lParam) {
    POINT clientPt = { GET_X_LPARAM(lParam), GET_Y_LPARAM(lParam) };
    POINT worldPt = transformPoint(clientPt); //преоразование в мировые координаты

    if (currentDrawMode == DrawMode::TEXT) {
        textDialogResult = {};
        textDialogResult.color = currentColor;
        textDialogResult.fontSize = 20;
        INT_PTR ret = DialogBox(GetModuleHandle(NULL),
            MAKEINTRESOURCE(IDD_TEXTDLG),
            hwnd,
            TextDialogProc);

        // если текст был введен и нажата кнопка ОК
        if (textDialogResult.confirmed && !textDialogResult.text.empty()) {
            Shape s;
            s.type = DrawMode::TEXT;
            s.color = textDialogResult.color;
            s.points.push_back(worldPt);                  
            s.text = textDialogResult.text;               
            s.fontSize = textDialogResult.fontSize;       
            shapes.push_back(std::move(s));
            InvalidateRect(hwnd, nullptr, TRUE);          
        }
        return 0; // обработка завершена
    }
    
    if (isSelecting) {
        POINT p = { GET_X_LPARAM(lParam), GET_Y_LPARAM(lParam) };
        p = transformPoint(p);

        selectionRect.left = p.x;
        selectionRect.top = p.y;
        selectionRect.right = p.x;
        selectionRect.bottom = p.y;
    }

    // для остальных режимов: линия, прямоугольник, эллипс
    if (currentDrawMode != DrawMode::NONE) {
        isDrawing = true;
        currentShape = {};
        currentShape.type = currentDrawMode;
        currentShape.color = currentColor;

        currentShape.points.push_back(worldPt);
    }

    return 0;
}

LRESULT handleMouseMove(HWND hwnd, LPARAM lParam, WPARAM wParam) {
    if (isDrawing) {
        //мировые координаты в клиентские чтобы объединить с текущими клиентскими и перерисовать большой прямоугольник

        RECT oldR = {};
        if (currentShape.points.size() >= 2)
            oldR = worldToClientRect(getShapeBounds(currentShape));

        // обновляем точку
        POINT p = { GET_X_LPARAM(lParam), GET_Y_LPARAM(lParam) };
        p = transformPoint(p);

        if (currentShape.points.size() == 1)
            currentShape.points.push_back(p);
        else
            currentShape.points.back() = p;

        RECT newR = worldToClientRect(getShapeBounds(currentShape));
        RECT dirty;
        UnionRect(&dirty, &oldR, &newR);
        InflateRect(&dirty, 2, 2);

        InvalidateRect(hwnd, &dirty, TRUE);
    }

    if (isSelecting && (wParam & MK_LBUTTON)) {
        RECT oldR = worldToClientRect(selectionRect);

        // обновляем мировые координаты выделения
        POINT p = { GET_X_LPARAM(lParam), GET_Y_LPARAM(lParam) };
        p = transformPoint(p);

        selectionRect.right = p.x;
        selectionRect.bottom = p.y;

        // dirty = объединение старого и нового, но уже в клиентских координатах
        RECT newR = worldToClientRect(selectionRect);
        RECT dirty;
        UnionRect(&dirty, &oldR, &newR);
        InflateRect(&dirty, 4, 4);

        InvalidateRect(hwnd, &dirty, TRUE);
    }

    return 0;
}

LRESULT handleLButtonUp(HWND hwnd, LPARAM lParam) {
    if (isDrawing) {
        isDrawing = false;
        shapes.push_back(currentShape);
        currentShape.points.clear();
        InvalidateRect(hwnd, nullptr, TRUE);
        return 0;
    }

    if (isSelecting) {
        POINT p = { GET_X_LPARAM(lParam), GET_Y_LPARAM(lParam) };
        p = transformPoint(p);


        selectionRect.right = p.x;
        selectionRect.bottom = p.y;
        isSelecting = false;
        InvalidateRect(hwnd, nullptr, TRUE);

        // запускаем печать выбранной области
        PrintSelection(hwnd, selectionRect);
    }

    return 0;
}

// wParam: HIWORD(wParam) - "дельта" прокрутки (обычно ±120)
//     LOWORD(wParam) = состояние клавиш-модификаторов и кнопок мыши (MK_SHIFT, MK_CONTROL, MK_LBUTTON и т.д.)
// lParam: LOWORD(lParam) = X-координата курсора в экранных координатах
//         HIWORD(lParam) = Y-координата курсора в экранных координатах
LRESULT handleMouseWheel(HWND hwnd, WPARAM wParam, LPARAM lParam) {
    int delta = GET_WHEEL_DELTA_WPARAM(wParam);
    bool ctrl = (GetKeyState(VK_CONTROL) & 0x8000);
    bool shift = (GetKeyState(VK_SHIFT) & 0x8000);

    if (ctrl) {
        if (shift) {
            zoom += (delta > 0 ? 0.2 : -0.2);
        }
        else {
            zoom += (delta > 0 ? 0.05 : -0.05);
        }
        if (zoom < 0.1) zoom = 0.1;
    }
    else {
        if (shift) {
            panX += (delta > 0 ? 20 : -20);
        }
        else {
            panY += (delta > 0 ? 20 : -20);
        }
    }
    InvalidateRect(hwnd, nullptr, TRUE);
    return 0;
}

LRESULT handleDestroy(HWND hwnd) {
    PostQuitMessage(0);
    return 0;
}

// ======================================================
// Сохранение / Загрузка EMF
// ======================================================

void SaveToEMF(HWND hwnd, LPCWSTR filename) {
    HDC hdcRef = GetDC(hwnd);
    RECT clientRect;
    GetClientRect(hwnd, &clientRect);

    HDC hdcEMF = CreateEnhMetaFileW(hdcRef, filename, nullptr, L"Graphic Editor");
    if (!hdcEMF) { // если создание EMF-DC провалилось — освобождаем референс и выходим
        ReleaseDC(hwnd, hdcRef);
        MessageBoxW(hwnd, L"Не удалось создать EMF HDC (CreateEnhMetaFile failed).", L"Error", MB_ICONERROR);
        return;
    }
    SetGraphicsMode(hdcEMF, GM_ADVANCED);
    XFORM xf;
    xf.eM11 = zoom; xf.eM12 = 0.0f; 
    xf.eM21 = 0.0f; xf.eM22 = zoom; 
    xf.eDx = panX; xf.eDy = panY;
    SetWorldTransform(hdcEMF, &xf);

    HBRUSH hbrBackground = CreateSolidBrush(RGB(255, 255, 255));
    FillRect(hdcEMF, &clientRect, hbrBackground);
    DeleteObject(hbrBackground); 

    if (g_backgroundEMF) {
        PlayEnhMetaFile(hdcEMF, g_backgroundEMF, &clientRect);
    }

    for (const auto& s : shapes) {
        HPEN hPen = CreatePen(PS_SOLID, 2, s.color);
        HGDIOBJ oldPen = SelectObject(hdcEMF, hPen);

        HBRUSH hBrush = (HBRUSH)GetStockObject(HOLLOW_BRUSH);
        HGDIOBJ oldBrush = SelectObject(hdcEMF, hBrush);

        switch (s.type) {
        case DrawMode::LINE:
            if (s.points.size() >= 2) {
                MoveToEx(hdcEMF, s.points[0].x, s.points[0].y, nullptr);
                LineTo(hdcEMF, s.points[1].x, s.points[1].y);
            }
            break;

        case DrawMode::RECTANGLE:
            if (s.points.size() >= 2) {
                Rectangle(hdcEMF, s.points[0].x, s.points[0].y, s.points[1].x, s.points[1].y);
            }
            break;

        case DrawMode::ELLIPSE:
            if (s.points.size() >= 2) {
                Ellipse(hdcEMF, s.points[0].x, s.points[0].y, s.points[1].x, s.points[1].y);
            }
            break;

        case DrawMode::TEXT:
            if (!s.text.empty() && s.points.size() >= 1) {
                HFONT hFont = CreateFontW(
                    -MulDiv(s.fontSize, GetDeviceCaps(hdcEMF, LOGPIXELSY), 72), 
                    0, 0, 0, FW_NORMAL, FALSE, FALSE, FALSE,
                    DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY,
                    DEFAULT_PITCH | FF_SWISS, L"Segoe UI"); 
                HGDIOBJ oldFont = SelectObject(hdcEMF, hFont);
                SetTextColor(hdcEMF, s.color);
                SetBkMode(hdcEMF, TRANSPARENT);

                TextOutW(hdcEMF, s.points[0].x, s.points[0].y, s.text.c_str(), (int)s.text.size());

                SelectObject(hdcEMF, oldFont);
                DeleteObject(hFont);
            }
            break;
        default:
            break;
        }

        SelectObject(hdcEMF, oldPen);
        SelectObject(hdcEMF, oldBrush);

        DeleteObject(hPen);
    } 

    HENHMETAFILE hemf = CloseEnhMetaFile(hdcEMF); //возвращает экземпляр (снимок) метафайла. завершает режим записи
    DeleteEnhMetaFile(hemf); //удаляет дескриптор из памяти процесса, чтобы файл не был занят процессом
    ReleaseDC(hwnd, hdcRef);

    if (!hemf) {
        MessageBoxW(hwnd, L"Не удалось завершить запись EMF (CloseEnhMetaFile returned NULL).", L"Error", MB_ICONERROR);
        return;
    }
}

void LoadFromEMF(HWND hwnd, LPCWSTR filename) {
    HENHMETAFILE hemfFile = GetEnhMetaFile(filename);
    if (!hemfFile) {
        MessageBox(hwnd, L"Ошибка загрузки EMF.", L"Ошибка", MB_ICONERROR);
        return;
    }
    HENHMETAFILE hemfCopy = CopyEnhMetaFileW(hemfFile, NULL);
    DeleteEnhMetaFile(hemfFile);

    if (!hemfCopy) {
        MessageBox(hwnd, L"Не удалось скопировать EMF в память.", L"Ошибка", MB_ICONERROR);
        return;
    }

    // сбрасываем трансформацию
    zoom = 1.0;
    panX = 0;
    panY = 0;

    // удаляем предыдущий фон, если был
    if (g_backgroundEMF) DeleteEnhMetaFile(g_backgroundEMF);
    g_backgroundEMF = hemfCopy;
    shapes.clear(); // очищаем текущие фигуры

    InvalidateRect(hwnd, nullptr, TRUE);
}


void PrintSelection(HWND hwnd, RECT selRect) {
    // нормализация координат, чтобы правильно работало выделение из любого угла
    if (selRect.right < selRect.left) std::swap(selRect.left, selRect.right);
    if (selRect.bottom < selRect.top) std::swap(selRect.top, selRect.bottom);

    int width = selRect.right - selRect.left;
    int height = selRect.bottom - selRect.top;
    if (width <= 0 || height <= 0) {
        MessageBox(hwnd, L"Выделена пустая область.", L"Печать", MB_ICONERROR);
        return;
    }

    // диалог выбора принтера и получение контекста его устройства
    PRINTDLG pd = {};
    pd.lStructSize = sizeof(pd);
    pd.hwndOwner = hwnd;
    pd.Flags = PD_RETURNDC;
    if (!PrintDlg(&pd)) return;

    HDC hdcPrinter = pd.hDC;
    if (!hdcPrinter) return;

    // настройка документа
    DOCINFO di = {};
    di.cbSize = sizeof(di);
    di.lpszDocName = L"Graphic Editor Print";

    if (StartDoc(hdcPrinter, &di) > 0) {
        if (StartPage(hdcPrinter) > 0) {
            HDC hdcWin = GetDC(hwnd);

            // Захватываем выделенную область в memory DC
            HDC hdcMem = CreateCompatibleDC(hdcWin);
            HBITMAP hbm = CreateCompatibleBitmap(hdcWin, width, height);
            HBITMAP oldBmp = (HBITMAP)SelectObject(hdcMem, hbm);

            BitBlt(hdcMem, 0, 0, width, height,
                   hdcWin, selRect.left, selRect.top, SRCCOPY);

            // учет DPI
            int dpiScreenX = GetDeviceCaps(hdcWin, LOGPIXELSX);
            int dpiScreenY = GetDeviceCaps(hdcWin, LOGPIXELSY);
            int dpiPrinterX = GetDeviceCaps(hdcPrinter, LOGPIXELSX);
            int dpiPrinterY = GetDeviceCaps(hdcPrinter, LOGPIXELSY);

            // размер выделения в дюймах
            double inchWidth = (double)(width) / dpiScreenX;
            double inchHeight = (double)(height) / dpiScreenY;

            // переводим дюймы в пиксели принтера
            int targetWidth = (int)(inchWidth * dpiPrinterX + 0.5);   //+0.5 чтобы округлять вверх
            int targetHeight = (int)(inchHeight * dpiPrinterY + 0.5);

            // Печатаем в (0,0) на листе, но с правильными физическими размерами
            StretchBlt(hdcPrinter,
                0, 0, targetWidth, targetHeight,
                hdcMem,
                0, 0, width, height,
                SRCCOPY);

            // Очистка
            SelectObject(hdcMem, oldBmp);
            DeleteObject(hbm);
            DeleteDC(hdcMem);
            ReleaseDC(hwnd, hdcWin);

            EndPage(hdcPrinter);
        }
        EndDoc(hdcPrinter);
    }

    DeleteDC(hdcPrinter);
}


// вспомогательные функции

//из клиентских в мировые координаты
static POINT transformPoint(POINT p) {
    p.x = (p.x - panX) / zoom;
    p.y = (p.y - panY) / zoom;
    return p;
}

//получить прямоугольник охватывающий фигуру в мировых координатах
static RECT getShapeBounds(const Shape& s) {
    RECT r = { 0,0,0,0 };
    if (s.points.empty()) return r;

    int left = s.points[0].x;
    int top = s.points[0].y;
    int right = left;
    int bottom = top;

    for (auto& p : s.points) {
        if (p.x < left) left = p.x;
        if (p.y < top) top = p.y;
        if (p.x > right) right = p.x;
        if (p.y > bottom) bottom = p.y;
    }

    // небольшой запас, чтобы захватить толщину пера
    InflateRect(&r, 3, 3);
    r.left = left; r.top = top;
    r.right = right; r.bottom = bottom;
    return r;
}

static RECT worldToClientRect(const RECT& wr) {
    RECT cr;
    cr.left = (LONG)(wr.left * zoom + panX);
    cr.top = (LONG)(wr.top * zoom + panY);
    cr.right = (LONG)(wr.right * zoom + panX);
    cr.bottom = (LONG)(wr.bottom * zoom + panY);
    return cr;
}

INT_PTR CALLBACK TextDialogProc(HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam) {
    switch (message) {
    case WM_INITDIALOG:
        SetDlgItemInt(hDlg, IDC_EDIT_SIZE, 20, FALSE);
        textDialogResult.color = currentColor;
        return (INT_PTR)TRUE;

        //wParam - ID кнопки
    case WM_COMMAND:
        if (LOWORD(wParam) == IDC_BUTTON_COLOR) {
            textDialogResult.color = handleChooseColor(hDlg, textDialogResult.color, colorHistory);
            return (INT_PTR)TRUE;
        }

        if (LOWORD(wParam) == IDOK) {
            wchar_t buf[256];
            GetDlgItemText(hDlg, IDC_EDIT_TEXT, buf, 256);
            textDialogResult.text = buf;

            UINT size = GetDlgItemInt(hDlg, IDC_EDIT_SIZE, NULL, FALSE);
            if (size < TDLG_MIN_FONT_SIZE || size > TDLG_MAX_FONT_SIZE) {
                MessageBox(hDlg,
                    L"Размер шрифта должен быть в пределах от 5 до 200.",
                    L"Ошибка ввода",
                    MB_ICONERROR | MB_OK);
                return (INT_PTR)TRUE;
            }

            textDialogResult.fontSize = size;
            textDialogResult.confirmed = true;
            EndDialog(hDlg, IDOK);
            return (INT_PTR)TRUE;
        }

        if (LOWORD(wParam) == IDCANCEL) {
            textDialogResult.confirmed = false;
            EndDialog(hDlg, IDCANCEL);
            return (INT_PTR)TRUE;
        }
        break;
    }

    return (INT_PTR)FALSE;
}

void updateColorHistory(COLORREF selectedColor, COLORREF colorHistory[16]) {
    if (colorHistory && colorHistory[0] != selectedColor) {
        int existingIndex = -1;                       // Ищем цвет в истории (чтобы избежать дубликатов)
        for (int i = 0; i < 16; i++) {
            if (colorHistory[i] == selectedColor) {
                existingIndex = i;
                break;
            }
        }
        if (existingIndex != -1) {
            COLORREF temp = colorHistory[existingIndex];    // Цвет уже есть в истории - перемещаем его на первое место
            for (int i = existingIndex; i > 0; i--) {
                colorHistory[i] = colorHistory[i - 1];
            }
            colorHistory[0] = temp;
        }
        else {
            for (int i = 15; i > 0; i--) {
                colorHistory[i] = colorHistory[i - 1];       // Новый цвет - сдвигаем историю
            }
            colorHistory[0] = selectedColor;
        }
    }
}
