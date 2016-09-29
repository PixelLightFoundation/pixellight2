#pragma once


#include <Core/Core.h>

namespace PixelLight
{
	/**
	 *	Stopwatch timestamp
	 */
	struct ElapsedTime
	{
		int64 MeasureBegin = 0;
		int64 ElapsedTicks = 0;

		/** Get elapsed time in human-readable units */
		PL_CORE_API int64 GetTime(int32 resolution = 1000);
	};

	namespace Stopwatch
	{
		/**
		*	Start new stopwatch measurement
		*/
		PL_CORE_API ElapsedTime Start();
		PL_CORE_API void Start(ElapsedTime& timestamp);

		/**
		 *	Start new stowatch measurement using an existing time stamp
		 *	This will also populate the 'elapsed' part of the timestamp with current measurement
		 */
		PL_CORE_API void Restart(ElapsedTime& timestamp);

		/**
		 *	Stop given measurement
		 */
		PL_CORE_API void Stop(ElapsedTime& timestamp);

		/**
		 *	Utility for measuring elapsed time in code scopes
		 */
		struct PL_CORE_API Scope
		{
			Scope(ElapsedTime& timestamp);
			~Scope();

		private:
			ElapsedTime* _timestamp;
		};
	}
}
