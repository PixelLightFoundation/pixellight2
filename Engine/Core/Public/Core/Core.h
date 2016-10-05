#pragma once


// Windows platform
#ifdef WIN32
#include "+Windows/CoreWindows.h"
#endif

// Linux platform
#ifdef LINUX
#include "+Linux/CoreLinux.h"
#endif


#if defined(PL_CORE_EXPORTS)
// To export classes, methods and variables
#define PL_CORE_API PL_GENERIC_API_EXPORT
#else
// To import classes, methods and variables
#define PL_CORE_API PL_GENERIC_API_IMPORT
#endif


// STD headers
#include <stdio.h>

// Common headers
#include "CoreMacros.h"
#include "System/Exception.h"
#include "System/Assert.h"
#include "System/Memory.h"
#include "String/String.h"
//#include "Log/Trace.h"
