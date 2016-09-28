/*********************************************************\
 *  PLCore Library                                       *
 *  ----------------------------------------------------
 *  File: PLCoreLinuxWrapper.h
 *      Linux wrapper definitions for PLCore (use them ONLY if REALLY required!)
 *
 *  Copyright (C) 2002-2013 The PixelLight Team (http://www.pixellight.org/)
 *
 *  This file is part of PixelLight.
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy of this software
 *  and associated documentation files (the "Software"), to deal in the Software without
 *  restriction, including without limitation the rights to use, copy, modify, merge, publish,
 *  distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
 *  Software is furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in all copies or
 *  substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
 *  BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 *  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 *  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 *  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
\*********************************************************/


#ifndef __PLCORE_LINUXWRAPPER_H__
#define __PLCORE_LINUXWRAPPER_H__
#pragma once


//[-------------------------------------------------------]
//[ Includes                                              ]
//[-------------------------------------------------------]
#include <stdio.h>
#include <stdarg.h>
#include <stdint.h>
#include "PLCore/PLCore.h"


//[-------------------------------------------------------]
//[ Functions                                             ]
//[-------------------------------------------------------]
PLCORE_API char *_strupr(char *s);
PLCORE_API char *strlwr(char *s);
PLCORE_API int _vscprintf(const char *format, va_list ap);

// wchar functions
PLCORE_API int _vscwprintf(const wchar_t *fmt,va_list ap);
PLCORE_API int _vsnwprintf(wchar_t *buf, size_t cnt, const wchar_t *fmt, va_list args);
PLCORE_API int _wtoi( const wchar_t *str );
PLCORE_API long _wtol( const wchar_t *str );
PLCORE_API float _wtof( const wchar_t *str );
PLCORE_API wchar_t *_wcsupr(wchar_t *s);
PLCORE_API wchar_t *_wcslwr(wchar_t *s);
#if (ANDROID || APPLE)
	// Even if there's a "wchar.h"-header, wchar_t is officially not supported by Android
	// (no problem, wchar_t is for Windows, UTF-8 for Linux and the string class handles both as well as ASCII)
	PLCORE_API int wcscasecmp(const wchar_t *s1, const wchar_t *s2);
	PLCORE_API int wcsncasecmp(const wchar_t *s1, const wchar_t *s2, size_t n);
	PLCORE_API uintmax_t wcstoumax(const wchar_t *nptr, wchar_t **endptr, int base);
#endif


//[-------------------------------------------------------]
//[ Definitions                                           ]
//[-------------------------------------------------------]
#define stricmp(a, b)		strcasecmp(a, b)
#define _stricmp(a, b)		strcasecmp(a, b)
#define _strnicmp(a, b, n)	strncasecmp(a, b, n)
#define strnicmp(a, b, n)	strncasecmp(a, b, n)
#define _strlwr(a)			strlwr(a)
#define _atoi64(a)			atoll(a)
#define _snprintf			snprintf

// wchar functions definitions
#define _wcsicmp(a, b)		wcscasecmp(a, b)
#define _wcsnicmp(a, b, c)	wcsncasecmp(a, b, c)
#undef  vswprintf
#define vswprintf			_vsnwprintf

// system functions
#define _fdopen(a, b)		fdopen(a, b)


#endif // __PLCORE_LINUXWRAPPER_H__
