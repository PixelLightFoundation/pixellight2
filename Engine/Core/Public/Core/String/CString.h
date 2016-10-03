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
		CStringT() : _buffer(nullptr) {}

		CStringT(const TChar* data)
		{
			Set(data);
		}

		~CStringT()
		{
			Mem::Free(_buffer);
		}

		CStringT& operator=(const TChar* data)
		{
			return Assign(data);
		}

		CStringT& Assign(const TChar* data)
		{
			// [TODO] don't need to free() if data still fits!
			Mem::Free(_buffer);
			Set(data);

			return *this;
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
		void Set(const TChar* data)
		{
			// [TODO] UTF8!
			size l = Str::Len(data) * sizeof(TChar);
			_buffer = static_cast<TChar*>(Mem::Alloc(l + sizeof(TChar)));
			Mem::Cpy(_buffer, data, l);
			_buffer[l] = '\0';
		}

		TChar* _buffer;
	};

	typedef CStringT<char> CString;
	typedef CStringT<wchar_t> CStringW;
}
