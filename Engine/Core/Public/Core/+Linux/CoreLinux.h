/*********************************************************\
 *  File: PLCoreLinux.h                                  *
 *
 *  Copyright (C) 2002-2013 The PixelLight Team (http://www.pixellight.org/)
 *
 *  This file is part of PixelLight.
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy of this software
 *  and associated documentation files (the "Software"), to deal in the Software without
 *  restriction, including without limitation the rights to use, copy, modify, merge, publish,
 *  distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
 *  Software is furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in all copies or
 *  substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
 *  BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 *  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 *  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 *  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
\*********************************************************/


#ifndef __PLCORE_LINUX_H__
#define __PLCORE_LINUX_H__
#pragma once


//[-------------------------------------------------------]
//[ Macros                                                ]
//[-------------------------------------------------------]
/**
*  @brief
*    Backups the current warning state for all warnings
*/
#define PL_WARNING_PUSH

/**
*  @brief
*    Restores the last warning state pushed onto the stack
*/
#define PL_WARNING_POP

/**
*  @brief
*    Disables a warning
*
*  @param[in] WarningID
*    ID of the warning to disable
*/
#define PL_WARNING_DISABLE(WarningID)

/**
*  @brief
*    Prints generic message to the output
*/
#define PL_MESSAGE(x)

/**
*  @brief
*    Specialized todo message
*/
#define PL_TODO(author, msg)


//[-------------------------------------------------------]
//[ Includes                                              ]
//[-------------------------------------------------------]
#include <stddef.h>
#include <stdint.h>


//[-------------------------------------------------------]
//[ C++11 definitions                                     ]
//[-------------------------------------------------------]
// GCC: Have a look at http://gcc.gnu.org/projects/cxx0x.html see which C++11 features are supported

// "nullptr"-definition
#if (__GNUC__ == 4 && __GNUC_MINOR__ == 5 && __GNUC_PATCHLEVEL__ < 3)
	// There's a bug in GCC 4.5.x ... 4.5.2 causing compiler errors when using the nullptr-class solution from below:
	//   "Bug 45383 - [4.5 Regression] Implicit conversion to pointer does no longer automatically generate operator== and operator!=."
	//   (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=45383)
	// ... looked a few minutes for a solution, without success... (just defining it as 0 is no solution and will introduce other compiler errors!)
	#error "Due to a bug in GCC 4.5.x ... 4.5.2 this GCC version is not supported. Please use a newer or older GCC version instead."
#elif ((__GNUC__ < 4 || (__GNUC__ == 4 && __GNUC_MINOR__ < 6)) && !defined(__clang__))
	/**
	*  @brief
	*    nullptr definition for compilers don't supporting this C++11 feature
	*
	*  @note
	*    - The implementation comes from the "A name for the null pointer: nullptr"-document (http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2007/n2431.pdf)
	*/
	const class {
		public:
			template<class T> operator T*() const  { return 0; }
			template<class C, class T> operator T C::*() const  { return 0; }
		private:
			void operator&() const;
	} nullptr = {};
#endif

// "override"-definition, see e.g. http://www2.research.att.com/~bs/C++0xFAQ.html#override (C++11 keyword is introduced in GCC 4.7 or clang 2.9)
#if ((__GNUC__ < 4 || __GNUC_MINOR__ < 7) && !defined(__clang__))
	#define override
#endif


//[-------------------------------------------------------]
//[ Project independent generic export                    ]
//[-------------------------------------------------------]
// To export classes, methods and variables
#if defined(HAVE_VISIBILITY_ATTR)
	#define PL_GENERIC_API_EXPORT __attribute__ ((visibility("default")))
#else
	#define PL_GENERIC_API_EXPORT
#endif

// To export RTTI elements
#define PL_GENERIC_RTTI_EXPORT 1


//[-------------------------------------------------------]
//[ Project independent generic import                    ]
//[-------------------------------------------------------]
// To import classes, methods and variables
#define PL_GENERIC_API_IMPORT

// To import RTTI elements
#if defined(HAVE_VISIBILITY_ATTR) && !defined(ALWAYS_RTTI_EXPORT)
	// To import RTTI elements
	#define PL_GENERIC_RTTI_IMPORT 0
#else
	// When the visibility feature is not used/supported then always "export" RTTI elements
	#define PL_GENERIC_RTTI_IMPORT 1
#endif


//[-------------------------------------------------------]
//[ Import/Export                                         ]
//[-------------------------------------------------------]
#if defined(HAVE_VISIBILITY_ATTR) && !defined(PLCORE_STATIC)
		// To import/export class templates
		#define PLCORE_TMPL __attribute__ ((visibility("default")))

		// To export plugin functions
		#define PLCORE_PLUGIN_API __attribute__ ((visibility("default")))
#else
		// To import/export class templates
		#define PLCORE_TMPL

		// To export plugin functions
		#define PLCORE_PLUGIN_API
#endif


//[-------------------------------------------------------]
//[ Data types                                            ]
//[-------------------------------------------------------]
// Standard types
namespace PLCore {


	typedef char				int8;
	typedef unsigned char		uint8;

	typedef short				int16;
	typedef unsigned short		uint16;

	typedef int					int32;
	typedef unsigned int		uint32;

	typedef int64_t 			int64;
	typedef uint64_t			uint64;

	#if X64_ARCHITECTURE
		typedef uint64_t		uint_ptr;
		typedef uint64_t		handle;
	#else
		typedef unsigned int	uint_ptr;
		typedef unsigned int	handle;
	#endif


}

/**
*  @brief
*    Invalid handle value (for data type PLCore::handle)
*/
static const PLCore::handle NULL_HANDLE    = 0;
static const PLCore::handle INVALID_HANDLE = -1;


#endif // __PLCORE_LINUX_H__
