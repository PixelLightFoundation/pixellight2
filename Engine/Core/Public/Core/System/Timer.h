#pragma once


#include <Core/Core.h>

#if WIN32
#include "+Windows/TimerWindows.h"
#else
#warning "Hardware timer functionality not available on this platform"
#define PL_NO_HW_TIMER

namespace PixelLight
{
	// Dummy timer implementation
	namespace Timer
	{
		PL_CORE_API int64 QueryTicks();
		PL_CORE_API int64 QueryTime(int32 resolution);
		PL_CORE_API int64 QueryCounterFrequency();
	}
}
#endif
