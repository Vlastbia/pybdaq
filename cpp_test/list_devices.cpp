#include <cstdint>
#include <iostream>
#include <bdaqctrl.h>

using namespace Automation::BDaq;

int main()
{
    int32_t deviceNumber;
    wchar_t description[128];
    int32_t subDeviceCount;
    int32_t index = 0;
    ErrorCode error = AdxDeviceGetLinkageInfo(-1, index++, &deviceNumber, description, &subDeviceCount);

    std::cout << error << '\n';
    std::wcout << description << L'\n';
}
