#pragma once


#include <Core/Core.h>

namespace PixelLight
{
	/** Element initialization policy: no initialization */
	struct NoInitPolicy
	{
		template <class T, typename TSize>
		static void Initialize(T* first, TSize cnt) {}

		template <class T, typename TSize>
		static void Destroy(T* first, TSize cnt) {}
	};

	/** Element initialization policy: default ctor */
	struct DefaultCtorInitPolicy
	{
		template <class T, typename TSize>
		static void Initialize(T* first, TSize cnt)
		{
			for (T* el = first; el < first + cnt; ++el)
			{
				new (el) T();
			}
		}

		template <class T, typename TSize>
		static void Destroy(T* first, TSize cnt)
		{
			for (T* el = first; el < first + cnt; ++el)
			{
				el->~T();
			}
		}
	};

	/** Container grow policy: fixed grow */
	template <size GROW>
	struct FixedGrowPolicy
	{
		template <typename TSize>
		static TSize Grow(TSize currentSize)
		{
			return currentSize + GROW;
		}
	};

	/** Sorting policy: no sort */
	struct NoSortPolicy
	{
		template <class T, typename TSize>
		static void SortIn(T* first, TSize cnt) {}

		template <class T, typename TSize>
		static void Find(T* first, TSize cnt, const T& search) {}
	};

	/** Sorting policy: simple sort */
	struct SimpleSortPolicy
	{
		template <class T, typename TSize>
		static void SortIn(T* first, TSize cnt) {}

		template <class T, typename TSize>
		static void Find(T* first, TSize cnt, const T& search) {}
	};

	/** Sorting policy: unique sort */
	struct UniqueSortPolicy
	{
		template <class T, typename TSize>
		static void SortIn(T* first, TSize cnt) {}

		template <class T, typename TSize>
		static void Find(T* first, TSize cnt, const T& search) {}
	};
}
