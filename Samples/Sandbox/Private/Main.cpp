/*
 *	PixelLight sample: Sandbox
 *	This is a special developer sandbox, specificaly meant for testing WIP code. Not a "sample"
 *	per itself, more like a convenient entry point anyone can use to test stuff
 */


#include <Core/ExecutableMain.h>
//#include <Core/Runtime/Application.h>


#include <Core/Functional/Function.h>
#include <Core/Functional/Immutable.h>
using namespace PixelLight;

void func(int)
{
}

class A
{
public:
	void F(int) {}
};

int PLMain()
{
	Function<void(int)> f(func);
	Function<void(int)> g([](int) {});

	auto l = [](int) {};
	Function<void(int)> h(l);

	f(0);
	//g(1);
	//h(2);

	for (int i = 0; i < 10000000; ++i)
	{
		f(i);
	}

	for (int i = 0; i < 10000000; ++i)
	{
		func(i);
	}

	//A a;
	//Function<void(int)> i(&A::F);
	//i(3);

	bind(int) a(1);
	int ma = a;
	//a = 2; // <-- WON'T compile

	const int& mar = a;
	//int& mart = a; // <-- WON'T compile

	return 0;
}
