#pragma once


// This must NOT be included from a dynamic library!
// (On e.g. Linux those definitions are set by our build system -> we just use the MS Windows
//  names so that we don't have to invent a new definition for this purpose)
#if defined(_WINDLL) || defined(_USRDLL)
#error Must not include ExecutableMain.h from a DLL!
#endif

//#include "pl/System/System.h"
//#include "pl/Tools/CommandLine.h"

//#include "Runtime/Application.h"


/**
*
*  @section intro_main 'main()' in PixelLight
*
*  [TODO]
*/

// This wraps the main function
int PLMain();

// Windows implementation
#ifdef WIN32
#ifdef _CONSOLE
#ifdef UNICODE
int wmain(int argc, wchar_t **argv)
#else
int main(int argc, char **argv)
#endif
{
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
int main(int argc, char **argv)
{
	//pl::CommandLine::Get().FromArgv(argc, argv);
	return PLMain();
}
#endif

// This macro is used to implement the application itself inside the
// executable's "main" .cpp file
#define PL_IMPLEMENT_APP(appClass) \
	int PLMain() \
	{ \
		appClass app; \
		return app.Run(); \
	}

// This is a slight variation of the above macro allowing the user
// to pass custom parameters into the class' ctor
#define PL_IMPLEMENT_APP_PARAMS(appClass, ...) \
	int PLMain() \
	{ \
		appClass app(__VA_ARGS__); \
		return app.Run(); \
	}
