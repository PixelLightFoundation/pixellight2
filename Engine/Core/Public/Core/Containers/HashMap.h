#pragma once


#include <Core/Core.h>
#include "Pair.h"
#include "Array.h"

namespace PixelLight
{
	/**
	 *	Hash table implementation
	 */
	template <class TKey, class TValue, typename TIndex = uint32>
	struct HashMap
	{
		HashMap()
		{
			// [TEMP] initial size until rehash is implemented
			_buckets.Resize(64);
		}

		HashMap(TIndex buckets)
		{
			_buckets.Resize(buckets);
		}

		/** Insert element */
		void Insert(const TKey& key, const TValue& val)
		{
			// [TODO] grow if necessary

			uint32 hash = Hash<TKey>::Calculate(key);
			TIndex bucket = hash % _buckets.Size();

			_buckets[bucket].Values.Add(MakePair(key, val));
		}

		/** Find element */
		bool Find(const TKey& key, const TValue** found = nullptr) const
		{
			uint32 hash = Hash<TKey>::Calculate(key);
			TIndex bucket = hash % _buckets.Size();

			// [TODO] implement on Array
			for (const auto& v : _buckets[bucket].Values)
			{
				if (!Hash<TKey>::Compare(key, v.First))
				{
					if (found)
						*found = &v.Second;
					return true;
				}
			}

			return false;
		}

	private:
		struct Bucket
		{
			Array<Pair<TKey, TValue>> Values;
		};

		typedef Array<Bucket, NoSortPolicy, DefaultCtorInitPolicy, FixedGrowPolicy<64>, TIndex> Buckets;
		Buckets _buckets;
	};
}
