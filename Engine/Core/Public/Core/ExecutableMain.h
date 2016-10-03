#pragma once


#include <Core/Core.h>

// This must NOT be included from a dynamic library!
// (On e.g. Linux those definitions are set by our build system -> we just use the MS Windows
//  names so that we don't have to invent a new definition for this purpose)
#if defined(_WINDLL) || defined(_USRDLL)
#error Must not include ExecutableMain.h from a DLL!
#endif

// This wraps the main function
int PLMain();

// Windows implementation
#ifdef WIN32
#ifdef _CONSOLE
#ifdef UNICODE
int wmain(int argc, wchar_t** argv)
#else
int main(int argc, char** argv)
#endif
{
	PL_UNUSED(argc);
	PL_UNUSED(argv);
	//pl::CommandLine::Get().FromArgv(argc, argv);
	return PLMain();
}
#else
#ifdef UNICODE
int WINAPI wWinMain(HINSTANCE hInst, HINSTANCE hPrevInst, LPWSTR pszCmdLine, int nShow)
#else
int WINAPI WinMain(HINSTANCE hInst, HINSTANCE hPrevInst, LPSTR pszCmdLine, int nShow)
#endif
{
	//pl::CommandLine::Get().FromArgv(argc, argv);
	return PLMain();
}
#endif

// Linux implementation
#elif LINUX
int main(int argc, char** argv)
{
	//pl::CommandLine::Get().FromArgv(argc, argv);
	return PLMain();
}
#endif
