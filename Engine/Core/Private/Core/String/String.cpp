#include <Core/String/String.h>
#include <tchar.h>

using namespace PixelLight;

//
size Str::Len(const char* str)
{
	return strlen(str);
}

//
size Str::Len(const wchar_t* str)
{
	return wcslen(str);
}
