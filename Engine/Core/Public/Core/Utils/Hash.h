#pragma once


#include <Core/Core.h>

namespace PixelLight
{
	/**
	 *	Type hashing base
	 */
	template <class T>
	struct Hash
	{
		static uint32 Calculate(const T& value)
		{
			// [TODO] ???
			return (uint32)(&value);
		}

		static int Compare(const T& a, const T& b)
		{
			return (a == b) ? 0 : ((a > b) ? 1 : -1);
		}
	};
}
