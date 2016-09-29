#include <Core/System/Timer.h>

#ifdef PL_NO_HW_TIMER

using namespace PixelLight;

//
int64 Timer::QueryTicks()
{
	return 0;
}

//
int64 Timer::QueryTime(int32 resolution)
{
	return 0;
}

//
int64 Timer::QueryCounterFrequency()
{
	return 1;
}

#endif
