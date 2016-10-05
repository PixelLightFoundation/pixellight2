#pragma once


#include <Core/Core.h>
#include <Core/Utils/Hash.h>

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

		/** String compare */
		PL_CORE_API int Cmp(const char* str1, const char* str2);
		PL_CORE_API int Cmp(const wchar_t* str1, const wchar_t* str2);
	}

	/** String hash */
	template <>
	struct Hash<AsciiString>
	{
		static uint32 Calculate(const char* str)
		{
			uint32 hash = 5381;

			int c;
			while (c = *str++)
			{
				hash = ((hash << 5) + hash) + c;
			}

			return hash;
		}

		static int Compare(const char* str1, const char* str2)
		{
			return Str::Cmp(str1, str2);
		}
	};

	template <>
	struct Hash<WideString>
	{
		static uint32 Calculate(const wchar_t* str)
		{
			uint32 hash = 5381;

			int c;
			while (c = *str++)
			{
				hash = ((hash << 5) + hash) + c;
			}

			return hash;
		}

		static int Compare(const wchar_t* str1, const wchar_t* str2)
		{
			return Str::Cmp(str1, str2);
		}
	};
}
