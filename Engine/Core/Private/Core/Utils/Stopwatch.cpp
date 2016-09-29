#include <Core/Utils/Stopwatch.h>
#include <Core/System/Timer.h>

using namespace PixelLight;

//
int64 ElapsedTime::GetTime(int32 resolution)
{
	int64 ticks = ElapsedTicks * resolution;
	return ticks / Timer::QueryCounterFrequency();
}

//
ElapsedTime Stopwatch::Start()
{
	ElapsedTime el;
	el.MeasureBegin = Timer::QueryTicks();

	return el;
}

//
void Stopwatch::Start(ElapsedTime& timestamp)
{
	timestamp.MeasureBegin = Timer::QueryTicks();
	timestamp.ElapsedTicks = 0;
}

//
void Stopwatch::Restart(ElapsedTime& timestamp)
{
	int64 ticks = Timer::QueryTicks();
	timestamp.ElapsedTicks = ticks - timestamp.MeasureBegin;
	timestamp.MeasureBegin = ticks;
}

//
void Stopwatch::Stop(ElapsedTime& timestamp)
{
	int64 ticks = Timer::QueryTicks();
	timestamp.ElapsedTicks = ticks - timestamp.MeasureBegin;
}

//
Stopwatch::Scope::Scope(ElapsedTime& timestamp)
	: _timestamp(&timestamp)
{
	Stopwatch::Start(*_timestamp);
}

Stopwatch::Scope::~Scope()
{
	Stopwatch::Stop(*_timestamp);
}
