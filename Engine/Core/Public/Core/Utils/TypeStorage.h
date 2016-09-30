#pragma once


#include <Core/Core.h>

namespace PixelLight
{
	/**
	 *	Helper to convert values to a type that can be dynamically stored
	 *	Some values, such as references or consts, cannot be stored directly as
	 *	mutable members. This class provides a conversion to a suitable replacement
	 */
	template <typename T>
	struct TypeStorage
	{
		typedef T OriginalType;
		typedef T StorageType;

		static StorageType Store(OriginalType value)
		{
			return value;
		}

		static OriginalType Restore(StorageType value)
		{
			return value;
		}

		static OriginalType& RestoreRef(StorageType& value)
		{
			return value;
		}

		static const OriginalType& RestoreRef(const StorageType& value)
		{
			return value;
		}
	};

	template <typename T>
	struct TypeStorage<T&>
	{
		typedef T& OriginalType;
		typedef typename TypeStorage<T*>::StorageType StorageType;

		static StorageType Store(OriginalType value)
		{
			return TypeStorage<T*>::Store(&value);
		}

		static OriginalType Restore(StorageType value)
		{
			return *TypeStorage<T*>::Restore(value);
		}

		static OriginalType& RestoreRef(StorageType& value)
		{
			return *TypeStorage<T*>::Restore(value);
		}

		static const OriginalType& RestoreRef(const StorageType& value)
		{
			return *TypeStorage<T*>::Restore(value);
		}
	};

	template <typename T>
	struct TypeStorage<const T>
	{
		typedef const T OriginalType;
		typedef T StorageType;

		static StorageType Store(OriginalType value)
		{
			return static_cast<StorageType>(value);
		}

		static OriginalType Restore(StorageType value)
		{
			return value;
		}

		static OriginalType& RestoreRef(StorageType& value)
		{
			return value;
		}

		static const OriginalType& RestoreRef(const StorageType& value)
		{
			return value;
		}
	};
}
