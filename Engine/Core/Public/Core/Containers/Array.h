#pragma once


#include <Core/Core.h>
#include "ContainerPolicies.h"

namespace PixelLight
{
	/**
	 *	Dynamic array (vector) implementation
	 */
	template <class T, class TSortPolicy = NoSortPolicy, class TInitPolicy = DefaultCtorInitPolicy, class TGrowPolicy = FixedGrowPolicy<16>, typename TIndex = uint16>
	struct Array
	{
		Array() {}

		Array(TIndex initialSize)
		{
			Grow(initialSize);
		}

		~Array()
		{
			TInitPolicy::Destroy(_data, _size);
			Mem::Free(_data);
		}

		/** Push new element */
		T& Add(const T& el)
		{
			GrowIfRequired(_size + 1);
			T* e = new (&_data[_size++]) T(el);
			return *e;
		}

		/** Resize the array and initialize empty elements */
		void Resize(TIndex newSize)
		{
			GrowIfRequired(newSize);
			if (newSize > _size)
				TInitPolicy::Initialize(_data + _size, newSize - _size);
			_size = newSize;
		}

	private:
		/** Grow array if neccessary */
		void GrowIfRequired(TIndex newSize)
		{
			if (_capacity <= newSize)
			{
				Grow(TGrowPolicy::Grow(newSize));
			}
		}

		/** Grow the array to accomodate N elements */
		void Grow(TIndex newSize)
		{
			_data = static_cast<T*>(Mem::ReAlloc(_data, newSize * sizeof(T)));
			_capacity = newSize;
		}

		T* _data = nullptr;
		TIndex _size = 0;
		TIndex _capacity = 0;
	};

	/** Sorted array */
	template <class T>
	using SortedArray = Array<T>;

	/** Unique sorted array (set) */
	template <class T>
	using Set = Array<T>;

	/** Use for POD/primitive data types that do not require construction */
	template <class T, class TGrowPolicy = FixedGrowPolicy<16>, typename TIndex = uint16>
	using PodArray = Array<T, NoSortPolicy, NoInitPolicy, TGrowPolicy, TIndex>;
}
