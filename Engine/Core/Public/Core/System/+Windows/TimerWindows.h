#pragma once


#include <Core/Core.h>

namespace PixelLight
{
	/**
	 *	High-resolution timer functionality
	 */
	namespace Timer
	{
		/**
		 *	Query the counter for ticks
		 */
		PL_CORE_API int64 QueryTicks();

		/**
		 *	Query the counter for time using the given resolution
		 *
		 *	@param resolution Resolution of the result, in units per second (miliseconds by default)
		 */
		PL_CORE_API int64 QueryTime(int32 resolution = 1000);

		/**
		 *	Get the frequency on which the HW counter operates, in ticks per second
		 */
		PL_CORE_API int64 QueryCounterFrequency();
	}
}
