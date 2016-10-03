#pragma once


#include <Core/Core.h>

namespace PixelLight
{
	/**
	 *	Zero-overhead C-style string
	 *	Used to allocate a C-string on the heap
	 */
	template <typename TChar>
	struct CStringT
	{
		CStringT(const TChar* data)
		{
			size l = Str::Len(data) * sizeof(TChar);
			_buffer = static_cast<TChar*>(Mem::Alloc(l + sizeof(TChar)));
			Mem::Cpy(_buffer, data, l);
			_buffer[l] = '\0';
			// [TODO] UTF8!
		}

		~CStringT()
		{
			Mem::Free(_buffer);
		}

		operator const TChar*()
		{
			return _buffer;
		}

		const TChar* Get() const
		{
			return _buffer;
		}

	private:
		TChar* _buffer;
	};

	typedef CStringT<char> CString;
	typedef CStringT<wchar_t> CStringW;
}
