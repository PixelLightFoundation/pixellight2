#pragma once

#include <Core/Core.h>

namespace PixelLight
{
	template <class T>
	struct Immutable
	{
		Immutable(const T& val)
		{
			_data = val;
		}

		Immutable(T&& val)
		{
			_data = std::move(val);
		}

		// Prevent mutability through assignment
		Immutable& operator=(const T&);
		Immutable& operator=(T&&);

		// Prevent mutability through access
		PL_INLINE operator const T&()
		{
			return _data;
		}

	private:
		T _data;
	};
}

#define bind(T) PixelLight::Immutable<T>
