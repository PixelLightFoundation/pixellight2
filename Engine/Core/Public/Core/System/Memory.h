#pragma once


#include <Core/Core.h>

namespace PixelLight
{
	/**
	 *	Memory operation wrappers
	 */
	namespace Mem
	{
		/** Heap alloc() */
		PL_CORE_API void* Alloc(size num);

		/** Heap realloc() */
		PL_CORE_API void* ReAlloc(void* mem, size num);

		/** Heap free() */
		PL_CORE_API void Free(void* mem);

		/** memcpy() wrapper */
		PL_CORE_API void Cpy(void* dest, const void* source, size num);

		/** memmove() wrapper */
		PL_CORE_API void Move(void* dest, const void* source, size num);

		/** memset() wrapper */
		PL_CORE_API void Set(void* dest, uint8 value, size num);

		/** Fill destination with '0' */
		PL_CORE_API void Zero(void* dest, size num);
	}
}
