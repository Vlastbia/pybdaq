#include <cstdio>
#include <cstdint>
#include <iostream>
#include <bdaqctrl.h>

using namespace Automation::BDaq;

int main()
{
    // XXX I can't make either of these work

    /*
    wchar_t string[32] = {};
    ErrorCode result = AdxEnumToString(
        L"ErrorCode",
        //L"SignalCountingType",
        ErrorSignatureNotMatch,
        //DownCount,
        sizeof(string) / sizeof(wchar_t),
        string);

    std::printf("sizeof(wchar_t) = %lu\n", sizeof(wchar_t));
    std::printf("conversion result code: 0x%X\n", result);
    std::wcout << L"conversion result: " << string << L'\n';
    */

    /*
    int32_t enumValue = -1;

    ErrorCode result = AdxStringToEnum(
        L"SignalCountingType",
        L"DownCount",
        &enumValue);

    std::printf("conversion result code: 0x%X\n", result);
    std::printf("enum value: 0x%X\n", enumValue);
    */
}
