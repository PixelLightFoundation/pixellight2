#pragma once

#include <Core/Core.h>

namespace PixelLight
{
	namespace Internal
	{
		template <class T, class... T>
		struct Binder
		{

		};
	}

	template <class F, class... T>
	Internal::Binder<F, T...> Bind(F&& func, T&&... args)
	{
		return Internal::Binder<F, T...>()
	}
}
