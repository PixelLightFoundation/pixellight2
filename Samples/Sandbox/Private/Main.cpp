/*
 *	PixelLight sample: Sandbox
 *	This is a special developer sandbox, specificaly meant for testing WIP code. Not a "sample"
 *	per itself, more like a convenient entry point anyone can use to test stuff
 */


#include <Core/ExecutableMain.h>
//#include <Core/Runtime/Application.h>


#include <Core/Functional/Function.h>
#include <Core/Functional/Immutable.h>
#include <Core/Utils/Stopwatch.h>
#include <Core/Utils/Tuple.h>
#include <Core/String/CString.h>
#include <Core/String/DString.h>
using namespace PixelLight;

#include <functional>

static int64 counter = 0;

void func(int i)
{
	counter += i;
}

void func2(int i, float f)
{
	counter += i;
}

class A
{
public:
	void F(int) {}
};

template <class F, class... T, int... I>
void Invoke(const F& fn, const Tuple<T...>& tuple, IndexSequence<I...>)
{
	fn(TupleGet<I>(tuple)...);
}

int PLMain()
{
	Function<void(int)> f(func);
	Function<void(int)> g([&](int i) { counter += i; });

	auto l = [&](int i) { counter += i; };
	Function<void(int)> h(l);
	
	f(0);
	g(1);
	h(2);

	Tuple<int, float> t;
	TupleStore<0>(t, 2);
	TupleStore<1>(t, 4.0f);
	Invoke(func2, t, MakeIndexSequence<2>());
	
#if 0
	ElapsedTime rawCall;
	{
		Stopwatch::Scope timer(rawCall);
		for (int i = 0; i < 10000000; ++i)
		{
			func(i);
		}
	}

	void(*pfn)(int) = func;
	ElapsedTime pfnCall;
	{
		Stopwatch::Scope timer(pfnCall);
		for (int i = 0; i < 10000000; ++i)
		{
			pfn(i);
		}
	}

	ElapsedTime funCall;
	{
		Stopwatch::Scope timer(funCall);
		for (int i = 0; i < 10000000; ++i)
		{
			f(i);
		}
	}	

	std::function<void(int)> stdf(func);
	ElapsedTime stdCall;
	{
		Stopwatch::Scope timer(stdCall);
		for (int i = 0; i < 10000000; ++i)
		{
			stdf(i);
		}
	}

	ElapsedTime lamCall;
	{
		Stopwatch::Scope timer(lamCall);
		for (int i = 0; i < 10000000; ++i)
		{
			h(i);
		}
	}

	std::function<void(int)> stdlam(l);
	ElapsedTime stdlamCall;
	{
		Stopwatch::Scope timer(stdlamCall);
		for (int i = 0; i < 10000000; ++i)
		{
			stdlam(i);
		}
	}

	printf("Raw call: %I64d\n", rawCall.GetTime());
	printf("Function pointer call: %I64d\n", pfnCall.GetTime());
	printf("PL Function call: %I64d\n", funCall.GetTime());
	printf("std::function call: %I64d\n", stdCall.GetTime());
	printf("PL Function lambda call: %I64d\n", lamCall.GetTime());
	printf("std::function lambda call: %I64d\n", stdlamCall.GetTime());
#endif

	CString str("aaa");

	int dummy = 0;
	scanf("%d", &dummy);

	//A a;
	//Function<void(int)> i(&A::F);
	//i(3);

	//fix(int) a(1);
	//int ma = a;
	//a = 2; // <-- WON'T compile

	//const int& mar = a;
	//int& mart = a; // <-- WON'T compile

	return 0;
}
