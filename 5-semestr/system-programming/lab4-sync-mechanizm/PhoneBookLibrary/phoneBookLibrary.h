#pragma once
#include <windows.h>

const int MAX_PHONE_RECORD_COUNT = 1000;

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

#ifdef PHONEBOOKLIBRARY_EXPORTS
#define PHONEBOOK_API __declspec(dllexport)
#else
#define PHONEBOOK_API __declspec(dllimport)
#endif

extern "C" {
    PHONEBOOK_API bool LoadDatabase(const wchar_t* csvFile);
    PHONEBOOK_API void UnloadDatabase();
    PHONEBOOK_API int SearchRecords(const PhoneRecord* query, PhoneRecord* results, int maxResults);
    PHONEBOOK_API size_t GetRecordCount();
    PHONEBOOK_API PhoneRecord* GetAllRecords();
    PHONEBOOK_API bool WasGlobalMappingObjectCreated();
    PHONEBOOK_API bool RunParallelSearchFromFile(const wchar_t* queriesFile, const wchar_t* outputFile);
}
