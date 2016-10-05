#pragma once


#include <Core/Core.h>

namespace PixelLight
{
	/**
	 *	Value pair
	 */
	template <class T, class U>
	struct Pair
	{
		T First;
		U Second;

		Pair() {}
		
		Pair(const T& first, const U& second)
			: First(first), Second(second)
		{}
	};

	/** Create value pair */
	template <class T, class U>
	Pair<T, U> MakePair(const T& t, const U& u)
	{
		return Pair<T, U>(t, u);
	}
}
