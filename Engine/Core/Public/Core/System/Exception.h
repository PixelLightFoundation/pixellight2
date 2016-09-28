#pragma once


#include <Core/Core.h>

#include <exception>


namespace PixelLight
{
	/**
	 *	Base class for PixelLight exceptions.
	 */
	class Exception /*: protected std::exception*/
	{
	public:
		/**
		 *	Retrieve the message included with the exception.
		 */
		const char* Reason() const { return /*what()*/ nullptr; }
	};
}

/**
 *	Helper to throw an exception. It will also cause the debugger to break
 *	if it is attached.
 *
 *	@param e The exception to throw
 */
#define PL_THROW(e) { PL_DBG_BREAK; throw e; }

/**
 *	Helper to throw an exception on condition.
 *
 *	@param x The expression to check
 *	@param e The exception to throw if x == false
 */
#define PL_THROW_IF(x, e) if ((x)) { PL_DBG_BREAK; throw e; }