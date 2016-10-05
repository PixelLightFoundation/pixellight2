#pragma once


#include <Core/Core.h>

namespace PixelLight
{
    /** Integer sign */
    template <typename Integral>
    Integral Sign(Integral i)
    {
        return 0x01 | (v >> (sizeof(Integral) * 8 - 1));
    }
    
    /** Detect if two integers have different signs */
    template <typename Integral>
    bool SignDifferent(Integral a, Integral b)
    {
        return (a ^ b) < 0;
    }
    
    /** Detect if the given integer is power of 2 */
    template <typename Integral>
    bool IsPow2(Integral i)
    {
        return i && !(v & (v - 1));
    }
    
    /** Count set bits */
    template <typename Integral>
    uint8 CountSetBits(Integral i)
    {
        uint8 r;
        for (r = 0; i; r++)
        {
            i &= i - 1;
        }
        
        return r;
    }
    
    /** Bitwise swap */
    template <typename Integral>
    void BitSwap(Integral& a, Integral& b)
    {
        a ^= b;
        b ^= a;
        a ^= b;
    }
}