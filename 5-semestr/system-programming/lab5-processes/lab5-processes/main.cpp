#include <windows.h>
#include <tlhelp32.h>
#include <iostream>
#include <string>
#include <fcntl.h>
#include <io.h>

// Проверяет, запущен ли процесс с указанным именем и возвращает его PID
bool IsProcessRunning(const std::wstring& processName, DWORD& outPid) {
    HANDLE snap = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    if (snap == INVALID_HANDLE_VALUE) return false;

    PROCESSENTRY32W pe;
    pe.dwSize = sizeof(pe);
    bool found = false;

    if (Process32FirstW(snap, &pe)) {
        do {
            if (_wcsicmp(pe.szExeFile, processName.c_str()) == 0) {
                found = true;
                outPid = pe.th32ProcessID;
                break;
            }
        } while (Process32NextW(snap, &pe));
    }

    CloseHandle(snap);
    return found;
}

int main() {
    SetConsoleOutputCP(CP_UTF8);
    SetConsoleCP(CP_UTF8);
    _setmode(_fileno(stdout), _O_U8TEXT);
    _setmode(_fileno(stdin), _O_U8TEXT);

    std::wstring watchedProc;
    std::wstring procToLaunch;

    std::wcout << L"Введите имя отслеживаемого процесса X (например notepad.exe): ";
    std::getline(std::wcin, watchedProc);

    std::wcout << L"Введите путь к процессу Y, который запустить при появлении первого: ";
    std::getline(std::wcin, procToLaunch);

    bool wasRunning = false;
    PROCESS_INFORMATION piY = { 0 };
    DWORD watchedPid = 0;

    std::wcout << L"\nСледим за процессом X: " << watchedProc
        << L"\nПри запуске X — запустим Y: " << procToLaunch << L"\n\n";

    while (true) {
        DWORD currentPid = 0;
        bool isRunning = IsProcessRunning(watchedProc, currentPid);

        //если процесс запустился сейчас и не был запущен
        if (isRunning && !wasRunning) {
            watchedPid = currentPid;
            std::wcout << L"Процесс " << watchedProc
                << L" найден (PID=" << watchedPid << L"). "
                << L"Запускаем " << procToLaunch << L"\n";

            STARTUPINFOW si = { sizeof(si) };
            if (CreateProcessW(nullptr, (LPWSTR)procToLaunch.c_str(),
                nullptr, nullptr, FALSE, 0, nullptr, nullptr, &si, &piY))
            {
                std::wcout << L"Процесс Y запущен (PID=" << piY.dwProcessId << L")\n";
            }
            else {
                std::wcerr << L"Ошибка запуска: " << GetLastError() << L"\n";
            }

            wasRunning = true;
        }

        //если процесс был запущен а сейчас не запущен
        if (!isRunning && wasRunning) {
            std::wcout << L"Процесс " << watchedProc
                << L" (PID=" << watchedPid << L") завершён. "
                << L"Завершаем " << procToLaunch << L"\n";

            if (piY.hProcess) {
                TerminateProcess(piY.hProcess, 0);
                CloseHandle(piY.hProcess);
                CloseHandle(piY.hThread);
                piY = { 0 };
            }

            watchedPid = 0; 
            wasRunning = false;
        }

        Sleep(1000);
    }
}
