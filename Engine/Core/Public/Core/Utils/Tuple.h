#pragma once


#include <Core/Core.h>

namespace PixelLight
{
    template <int I, typename T>
    struct TupleElement;
    
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
        }
    }
    
    /** Helper to generate index sequence for a tuple */
    template <int End, int Start = 0>
    struct MakeTupleIndices
    {
        typedef typename Internal::MakeTupleIndicesImpl<Start, IndexSequence<>, End>::Type Type;
    }
}