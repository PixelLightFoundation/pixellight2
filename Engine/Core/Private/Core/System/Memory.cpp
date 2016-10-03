#include <Core/System/Memory.h>
#include <memory>

using namespace PixelLight;

//
void* Mem::Alloc(size num)
{
	return malloc(num);
}

//
void* Mem::ReAlloc(void* mem, size num)
{
	return realloc(mem, num);
}

//
void Mem::Free(void* mem)
{
	free(mem);
}

//
void Mem::Cpy(void* dest, const void* source, size num)
{
	memcpy(dest, source, num);
}

//
void Mem::Move(void* dest, const void* source, size num)
{
	memmove(dest, source, num);
}

//
void Mem::Set(void* dest, uint8 value, size num)
{
	memset(dest, value, num);
}

//
void Mem::Zero(void* dest, size num)
{
	memset(dest, 0, num);
}
