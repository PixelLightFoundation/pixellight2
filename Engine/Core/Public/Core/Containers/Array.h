#pragma once


#include <Core/Core.h>
#include "ContainerPolicies.h"

namespace PixelLight
{
	/**
	 *	Dynamic array (vector) implementation
	 */
	template <class T, class TSortPolicy = NoSortPolicy, class TInitPolicy = DefaultCtorInitPolicy, class TGrowPolicy = FixedGrowPolicy<16>, typename TIndex = uint32>
	struct Array
	{
		Array() : _data(reinterpret_cast<T*>(&_emptyArray)) {}

		Array(TIndex initialSize) : Array()
		{
			Grow(initialSize);
		}

		~Array()
		{
			TInitPolicy::Destroy(Begin(), Size());
			Mem::Free(_data);
		}

		/** Push new element */
		T& Add(const T& el)
		{
			GrowIfRequired(Size() + 1);
			T* e = new (&Begin()[SizeRef()++]) T(el);
			e = TSortPolicy::SortInLast(Begin(), Size(), e);
			return *e;
		}

		/** Resize the array and initialize empty elements */
		void Resize(TIndex newSize)
		{
			GrowIfRequired(newSize);
			if (newSize > Size())
				TInitPolicy::Initialize(Begin() + Size(), newSize - Size());
			SizeRef() = newSize;
		}
		
		/** Reserve enough memory to hold N elements */
		void Reserve(TIndex newSize)
		{
			GrowIfRequired(newSize);
		}
		
		/** Trim excess capacity */
		void Trim()
		{
			if (Size() != Capacity())
			{
				Grow(Size());
			}
		}
		
		/** Access element by index */
		T& operator[](TIndex i)
		{
			require(i < Size());
			return Begin()[i];
		}
		const T& operator[](TIndex i) const
		{
			require(i < Size());
			return Begin()[i];
		}
		
		/** Begin iterator */
		T* Begin()
		{
			return _data + sizeof(Header);
		}
		const T* Begin() const
		{
			return _data + sizeof(Header);
		}
		
		/** End iterator */
		T* End()
		{
			return Begin() + Size();
		}
		const T* End() const
		{
			return Begin() + Size();
		}
		
		/** Range-based 'for' support */
		T* begin() { return Begin(); }
		const T* begin() const { return Begin(); }
		T* end() { return End(); }
		const T* end() const { return End(); }
		
		/** Number of active elements */
		TIndex Size() const
		{
			return reinterpret_cast<const Header*>(_data)->Size;
		}
		
		/** Max possible number of elements before resize */
		TIndex Capacity() const
		{
			return reinterpret_cast<const Header*>(_data)->Capacity;
		}

	private:
		struct Header
		{
			TIndex Size = 0;
			TIndex Capacity = 0;
			T* BlockStart = nullptr; // [TEST] AM: to allow for transparent realloc() from empty array, might not be worth it
		};
		
		/** Grow array if neccessary */
		void GrowIfRequired(TIndex newSize)
		{
			if (Capacity() <= newSize)
			{
				Grow(TGrowPolicy::Grow(newSize));
			}
		}

		/** Grow the array to accomodate N elements */
		void Grow(TIndex newSize)
		{
			TIndex s = newSize * sizeof(T) + sizeof(Header);
			TIndex s0 = Size(); 
			_data = static_cast<T*>(Mem::ReAlloc(reinterpret_cast<Header*>(_data)->BlockStart, s));
			
			SizeRef() = s0;
			CapRef() = newSize;
			reinterpret_cast<Header*>(_data)->BlockStart = _data;
		}
		
		TIndex& SizeRef()
		{
			return *reinterpret_cast<const Header*>(_data)->Size;
		}
		
		TIndex& CapRef()
		{
			return *reinterpret_cast<const Header*>(_data)->Capacity;
		}

		T* _data = nullptr;
		
		// Dummy to represent an empty array
		static const Header _emptyArray;
	};

	/** Sorted array */
	template <class T>
	using SortedArray = Array<T>;

	/** Unique sorted array (set) */
	template <class T>
	using Set = Array<T>;

	/** Use for POD/primitive data types that do not require construction */
	template <class T, class TGrowPolicy = FixedGrowPolicy<16>, typename TIndex = uint32>
	using PodArray = Array<T, NoSortPolicy, NoInitPolicy, TGrowPolicy, TIndex>;
}
