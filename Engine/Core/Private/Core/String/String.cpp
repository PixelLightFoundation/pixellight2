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

//
int Str::Cmp(const char* str1, const char* str2)
{
	return strcmp(str1, str2);
}

//
int Str::Cmp(const wchar_t* str1, const wchar_t* str2)
{
	return wcscmp(str1, str2);
}
