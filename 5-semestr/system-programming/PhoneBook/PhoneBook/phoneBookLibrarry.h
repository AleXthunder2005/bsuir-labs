#pragma once
#include <windows.h>

struct PhoneRecord {
    wchar_t phone[32];
    wchar_t lastName[64];
    wchar_t firstName[64];
    wchar_t middleName[64];
    wchar_t street[128];
    int house;
    int building;
    int apartment;
};

#ifdef PHONEBOOKDLL_EXPORTS
#define PHONEBOOK_API extern "C" __declspec(dllexport)
#else
#define PHONEBOOK_API extern "C" __declspec(dllimport)
#endif

// API DLL
PHONEBOOK_API bool LoadDatabase(const wchar_t* csvFile);
PHONEBOOK_API void UnloadDatabase();
PHONEBOOK_API int SearchRecords(const PhoneRecord* query, PhoneRecord* results, int maxResults);
