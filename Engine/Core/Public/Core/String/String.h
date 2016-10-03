#pragma once


#include <Core/Core.h>

namespace PixelLight
{
	/**
	 *	Plain ASCII string
	 */
	typedef const char* AsciiString;

	/**
	 *	Wide string
	 */
	typedef const wchar_t* WideString;

	/**
	 *	Environment default string
	 *	Will be unicode or ASCII depending on build settings
	 */
#ifdef UNICODE
	typedef WideString String;
#else
	typedef AsciiString String;
#endif

	/**
	*	String function wrappers
	*/
	namespace Str
	{
		/** String length */
		PL_CORE_API size Len(const char* str);
		PL_CORE_API size Len(const wchar_t* str);
	}
}
