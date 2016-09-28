#pragma once

#include "CoreWindowsIncludes.h"

// Backups the current warning state for all warnings
#ifdef __MINGW32__
#define PL_WARNING_PUSH
#else
#define PL_WARNING_PUSH __pragma(warning(push))
#endif

// Restores the last warning state pushed onto the stack
#ifdef __MINGW32__
#define PL_WARNING_POP
#else
#define PL_WARNING_POP __pragma(warning(pop))
#endif

// Disables a warning
#ifdef __MINGW32__
#define PL_WARNING_DISABLE(WarningID)
#else
#define PL_WARNING_DISABLE(WarningID) __pragma(warning(disable: WarningID))
#endif

#ifdef __MINGW32__
#include <_mingw.h>	// For "__int8", "__int16" and so so definitions
// Within "_mingw.h", "__int32" is defined as "long" while PixelLight assumes "int", so, we change the definition
#define __int32 int
#include <stddef.h>	// For "size_t"
#else
	// Within Microsoft Visual Studio, 'wchar_t' can be defined as native type, in this case we don't need a special include
#if !defined(_MSC_VER) || !defined(_WCHAR_T_DEFINED)
#include <wctype.h>
#endif
#endif


// Disable warnings
PL_WARNING_DISABLE(4100) // "'identifier' : unreferenced formal parameter"
PL_WARNING_DISABLE(4201) // "nonstandard extension used : nameless struct/union"
PL_WARNING_DISABLE(4231) // "nonstandard extension used : 'identifier' before template explicit instantiation" -> It's part of C++11 (see e.g. http://www2.research.att.com/~bs/C++0xFAQ.html#extern-templates)
PL_WARNING_DISABLE(4481) // "nonstandard extension used: override specifier 'override'" -> It's part of C++11 (see e.g. http://www2.research.att.com/~bs/C++0xFAQ.html#override)
PL_WARNING_DISABLE(4505) // "unreferenced local function has been removed"
PL_WARNING_DISABLE(4355) // 'this' : used in base member initializer list"
PL_WARNING_DISABLE(4251) // "'identifier' : class X needs to have dll-interface to be used by clients of class Y


// To export classes, methods and variables
#define PL_GENERIC_API_EXPORT	__declspec(dllexport)

// To import classes, methods and variables
#define PL_GENERIC_API_IMPORT	__declspec(dllimport)


// Specifies an empty operation
#define PL_NOP __noop

// Initiates a debug break
#define PL_DBG_BREAK __debugbreak()


namespace PixelLight
{
	// Standard types
	typedef __int8					int8;
	typedef unsigned __int8			uint8;

	typedef __int16					int16;
	typedef unsigned __int16		uint16;

	typedef __int32					int32;
	typedef unsigned __int32		uint32;

	typedef __int64					int64;
	typedef unsigned __int64		uint64;

#if WIN64
	typedef unsigned __int64	intptr;
	typedef unsigned __int64	handle;
#else
	typedef unsigned __int32	intptr;
	typedef unsigned __int32	handle;
#endif


}

// Invalid handle value (for data type pl::handle)
#ifdef WIN64
static const PixelLight::handle NULL_HANDLE = 0x0000000000000000;
static const PixelLight::handle INVALID_HANDLE = 0xffffffffffffffff;
#else
static const PixelLight::handle NULL_HANDLE = 0x00000000;
static const PixelLight::handle INVALID_HANDLE = 0xffffffff;
#endif
