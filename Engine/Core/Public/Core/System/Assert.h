#pragma once


#include <Core/Core.h>


#ifndef NDEBUG

/**
 *	PixelLight's equivalent to STL's assert() function.
 *	Used to enforce conditions within the codebase. This is not evaluated in release
 *	builds and therefore shoudn't be used for error handling. Assert condition is considered
 *	fatal and _will_ cause the application to quit!
 *
 *	@param x The expression to check
 */
#define require(x) if (!(x)) { PL_DBG_BREAK; PixelLight::Internal::__Assert(#x); }

/**
 *	Extended require() function with custom message.
 *	@see require
 *
 *	@param x The expression to check
 *	@param m Custom message to show
 */
#define require_msg(x, m, ...) if (!(x)) { PL_DBG_BREAK; PixelLight::Internal::__Assert(m, __VA_ARGS__); }

#else

#define require(x) PL_NOP
#define require_msg(x, m, ...) PL_NOP

#endif


namespace PixelLight
{
	namespace Internal
	{
		/**
		* Internal assertion function
		*/
		void PL_CORE_API __Assert(const char* msg, ...);
	}
}