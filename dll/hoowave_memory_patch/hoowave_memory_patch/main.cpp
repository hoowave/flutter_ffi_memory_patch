#include <windows.h>
#include <tlhelp32.h>
#include <vector>
#include <string>
#include <sstream>
#include <iostream>
#include <tchar.h>
#include <stdio.h>
#include <unordered_set>

extern "C" __declspec(dllexport) HANDLE openProcess(DWORD processID) {
    HANDLE hProcess = OpenProcess(PROCESS_VM_READ | PROCESS_VM_WRITE | PROCESS_VM_OPERATION, FALSE, processID);
    return hProcess;
}

extern "C" __declspec(dllexport) bool readProcessMemory(HANDLE hProcess, LPCVOID address, LPVOID buffer, SIZE_T size) {
    SIZE_T bytesRead;
    return ReadProcessMemory(hProcess, address, buffer, size, &bytesRead);
}

extern "C" __declspec(dllexport) bool writeProcessMemory(HANDLE hProcess, LPVOID address, LPCVOID buffer, SIZE_T size) {
    SIZE_T bytesWritten;
    return WriteProcessMemory(hProcess, address, buffer, size, &bytesWritten);
}

extern "C" __declspec(dllexport) void closeProcess(HANDLE hProcess) {
    CloseHandle(hProcess);
}

extern "C" __declspec(dllexport) void getApplicationList(void* buffer, int bufferSize) {
    std::unordered_set<DWORD> appProcessIds;

    auto EnumWindowsProc = [](HWND hwnd, LPARAM lParam) -> BOOL {
        DWORD processId;
        GetWindowThreadProcessId(hwnd, &processId);

        if (IsWindowVisible(hwnd) && GetWindowTextLength(hwnd) > 0) {
            reinterpret_cast<std::unordered_set<DWORD>*>(lParam)->insert(processId);
        }
        return TRUE;
        };

    EnumWindows(EnumWindowsProc, reinterpret_cast<LPARAM>(&appProcessIds));

    std::ostringstream jsonStream;
    jsonStream << "[";
    HANDLE hSnapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    if (hSnapshot != INVALID_HANDLE_VALUE) {
        PROCESSENTRY32 pe32;
        pe32.dwSize = sizeof(PROCESSENTRY32);
        BOOL bProcessFound = Process32First(hSnapshot, &pe32);
        int index = 0;

        while (bProcessFound) {
            if (appProcessIds.find(pe32.th32ProcessID) != appProcessIds.end()) {
                if (index > 0) jsonStream << ",";
                std::wstring wProcessName(pe32.szExeFile);
                std::string processName(wProcessName.begin(), wProcessName.end());

                jsonStream << "{";
                jsonStream << "\"pid\":" << pe32.th32ProcessID << ",";
                jsonStream << "\"name\":\"" << processName << "\"";
                jsonStream << "}";
                index++;
            }
            bProcessFound = Process32Next(hSnapshot, &pe32);
        }
        CloseHandle(hSnapshot);
    }
    jsonStream << "]";

    std::string jsonString = jsonStream.str();
    if (jsonString.size() < bufferSize) {
        strcpy_s(static_cast<char*>(buffer), bufferSize, jsonString.c_str());
    }
    else {
        std::cerr << "Buffer size is not enough for the process list." << std::endl;
    }
}

extern "C" __declspec(dllexport) void getProcessList(void* buffer, int bufferSize) {
    HANDLE hSnapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);

    if (hSnapshot != INVALID_HANDLE_VALUE) {
        PROCESSENTRY32 pe32;
        pe32.dwSize = sizeof(PROCESSENTRY32);

        std::ostringstream jsonStream;
        jsonStream << "[";

        BOOL bProcessFound = Process32First(hSnapshot, &pe32);
        int index = 0;

        while (bProcessFound) {
            if (index > 0) {
                jsonStream << ",";
            }

            std::wstring wProcessName(pe32.szExeFile);

            std::string processName(wProcessName.begin(), wProcessName.end());

            jsonStream << "{";
            jsonStream << "\"pid\":" << pe32.th32ProcessID << ",";
            jsonStream << "\"name\":\"" << processName << "\"";
            jsonStream << "}";

            index++;
            bProcessFound = Process32Next(hSnapshot, &pe32);
        }

        jsonStream << "]";

        std::string jsonString = jsonStream.str();

        std::cout << "Generated JSON: " << jsonString << std::endl;

        if (jsonString.size() < bufferSize) {
            strcpy_s(static_cast<char*>(buffer), bufferSize, jsonString.c_str());
        }
        else {
            strcpy_s(static_cast<char*>(buffer), bufferSize, jsonString.c_str());
            std::cerr << "Buffer size is not enough for the process list." << std::endl;
        }

        CloseHandle(hSnapshot);
    }
    else {
        std::cerr << "Failed to create snapshot." << std::endl;
    }
}