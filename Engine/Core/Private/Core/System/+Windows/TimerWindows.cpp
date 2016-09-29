#include <Core/System/+Windows/TimerWindows.h>

using namespace PixelLight;

namespace
{
	// Helper to query the HW timer frequency
	struct FrequencyQuery
	{
		FrequencyQuery()
		{
			check(QueryPerformanceFrequency(&Frequency));
		}

		LARGE_INTEGER Frequency;
	};

	static FrequencyQuery Counter;
}

//
int64 Timer::QueryTicks()
{
	LARGE_INTEGER ticks;
	check(QueryPerformanceCounter(&ticks));
	
	return ticks.QuadPart;
}

//
int64 Timer::QueryTime(int32 resolution)
{
	int64 ticks = QueryTicks();
	ticks *= resolution;

	return ticks / Counter.Frequency.QuadPart;
}

//
int64 Timer::QueryCounterFrequency()
{
	return Counter.Frequency.QuadPart;
}
