#pragma once


#include <Core/Core.h>
#include "TypeStorage.h"

namespace PixelLight
{    
    /**
     *  Tuple value holder
     */
    template <int I, typename TValue>
    struct TupleLeaf
    {
        typedef TypeStorage<TValue> Storage;
        typedef typename Storage::StorageType StorageType;
        
        TupleLeaf() : _value() {}
        TupleLeaf(const TupleLeaf& other) : _value(other.Get()) {}
        
        template <typename T>
        explicit TupleLeaf(T&& val) : _value(static_cast<T&&>(val)) {}
        
        template <typename T>
        explicit TupleLeaf(const TupleLeaf<I, T>& other) : _value(other.Get()) {}
        
        template <typename T>
        TupleLeaf& operator=(T&& val)
        {
            _value = static_cast<T&&>(val);
            return *this;
        }
        
        /** Access data */
        PL_INLINE StorageType& Get()
        {
            return _value;
        }
        PL_INLINE const StorageType& Get() const
        {
            return _value;
        }
        
    private:
        StorageType _value;
    };
    
    /** Index sequence holder helper */
    template <int... Indices>
    struct IndexSequence {};

	/** Helper to unroll index sequence */
	template <int N, int... I>
	struct MakeIndexSequence : public MakeIndexSequence<N - 1, N - 1, I...> {};

	template <int... I>
	struct MakeIndexSequence<0, I...> : public IndexSequence<I...> {};
    
    namespace Internal
    {
        template <int Start, typename TupleIndices, int End>
        struct MakeTupleIndicesImpl;
        
        template <int Start, int... Indices, int End>
        struct MakeTupleIndicesImpl<Start, IndexSequence<Indices...>, End>
        {
            typedef typename MakeTupleIndicesImpl<Start+ 1, IndexSequence<Indices..., Start>, End>::Type Type;
        };
        
        template <int End, int... Indices>
        struct MakeTupleIndicesImpl<End, IndexSequence<Indices...>, End>
        {
            typedef IndexSequence<Indices...> Type; 
		};
    }
    
    /** Helper to generate index sequence for a tuple */
    template <int End, int Start = 0>
    struct MakeTupleIndices
    {
        typedef typename Internal::MakeTupleIndicesImpl<Start, IndexSequence<>, End>::Type Type;
	};

	namespace Internal
	{
		template <typename TIndices, typename... Types>
		struct TupleImpl;

		template <int... Indices, typename... Types>
		struct TupleImpl<IndexSequence<Indices...>, Types...> : public TupleLeaf<Indices, Types>... {}; 
	}

	/**
	 *	Arbitrary size tuple
	 *	Holds an indexed sequence of values
	 */
	template <typename... Types>
	struct Tuple
	{
		typedef Internal::TupleImpl<typename MakeTupleIndices<sizeof...(Types)>::Type, Types...> ImplType;

		Tuple() {}
		//Tuple(Types... values) {} // [TODO]

		ImplType _impl;
	};

	namespace Internal
	{
		template <int I, typename T>
		struct TupleElement;

		template <int I, typename Head, typename... Tail>
		struct TupleElement<I, Tuple<Head, Tail...>> : TupleElement<I - 1, Tuple<Tail...>> {};

		template <typename Head, typename... Tail>
		struct TupleElement<0, Tuple<Head, Tail...>>
		{
			typedef Head Type;
		};
	}

	/**
	 *	Retrieve value from a tuple by index
	 */
	template <int I, typename... T>
	const typename Internal::TupleElement<I, Tuple<T...>>::Type TupleGet(const Tuple<T...>& tuple)
	{
		typedef typename Internal::TupleElement<I, Tuple<T...>>::Type Type;
		return TypeStorage<Type>::Restore(static_cast<const TupleLeaf<I, Type>&>(tuple._impl).Get());
	}
	template <int I, typename... T>
	typename Internal::TupleElement<I, Tuple<T...>>::Type TupleGet(Tuple<T...>& tuple)
	{
		typedef typename Internal::TupleElement<I, Tuple<T...>>::Type Type;
		return TypeStorage<Type>::Restore(static_cast<TupleLeaf<I, Type>&>(tuple._impl).Get());
	}

	/**
	 *	Store value in a tuple
	 */
	template <int I, typename... T>
	void TupleStore(Tuple<T...>& tuple, typename const Internal::TupleElement<I, Tuple<T...>>::Type& value)
	{
		typedef typename Internal::TupleElement<I, Tuple<T...>>::Type Type;
		static_cast<TupleLeaf<I, Type>&>(tuple._impl).Get() = TypeStorage<Type>::Store(value);
	}
}