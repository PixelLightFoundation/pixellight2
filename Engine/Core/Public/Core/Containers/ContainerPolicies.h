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
			return GROW * ((currentSize / GROW) + 1);
		}
	};
	
	/** Container grow policy: tight grow */
	struct TightGrowPolicy
	{
		template <typename TSize>
		static TSize Grow(TSize currentSize)
		{
			return currentSize;
		}
	};

	/** Sorting policy: no sort */
	struct NoSortPolicy
	{
		template <class T, typename TSize>
		static T* SortInLast(T* first, TSize cnt, const T& el) { return first + (cnt - 1); }

		template <class T, typename TSize>
		static void Find(T* first, TSize cnt, const T& search) {}
	};

	/** Sorting policy: simple sort */
	struct SimpleSortPolicy
	{
		template <class T, typename TSize>
		static T* SortInLast(T* first, TSize cnt, const T& el)
		{
			// 'el' is the last element in the array, find its new place
			TSize lo = 0, hi = cnt - 1;
			T* e = first + cnt;
			while (lo <= hi)
			{
				TSize mid = (lo + hi) / 2;
				e = &first[mid];
				
				if (*e < el)
				{
					lo = mid + 1;
				}
				else if (*e == el)
				{
					break;
				}
				else
				{
					hi = mid - 1;
				}
			}

			return e;
		}

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
