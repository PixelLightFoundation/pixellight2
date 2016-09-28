#*********************************************************#
#*  File: FindPCRE.cmake                                 *
#*
#*  Copyright (C) 2002-2013 The PixelLight Team (http://www.pixellight.org/)
#*
#*  This file is part of PixelLight.
#*
#*  Permission is hereby granted, free of charge, to any person obtaining a copy of this software
#*  and associated documentation files (the "Software"), to deal in the Software without
#*  restriction, including without limitation the rights to use, copy, modify, merge, publish,
#*  distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
#*  Software is furnished to do so, subject to the following conditions:
#*
#*  The above copyright notice and this permission notice shall be included in all copies or
#*  substantial portions of the Software.
#*
#*  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
#*  BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#*  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
#*  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
#*  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#*********************************************************#


# - Find PCRE
# Find the native PCRE includes and library
#
#  PCRE_INCLUDE_DIR - where to find pcre.h, etc.
#  PCRE_LIBRARIES   - List of libraries when using libpcre.
#  PCRE_FOUND       - True if pcre found.

if(PCRE_INCLUDE_DIR)
  # Already in cache, be silent
  set(PCRE_FIND_QUIETLY TRUE)
endif(PCRE_INCLUDE_DIR)

find_path(PCRE_INCLUDE_DIR pcre.h)

if(UNIX)
  set(PCRE_NAMES pcre pcreposix)
else()
  set(PCRE_NAMES pcre libpcre)
endif()
find_library(PCRE_LIBRARY NAMES ${PCRE_NAMES} )

# handle the QUIETLY and REQUIRED arguments and set PCRE_FOUND to TRUE if 
# all listed variables are TRUE
include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(PCRE DEFAULT_MSG PCRE_LIBRARY PCRE_INCLUDE_DIR)

if(PCRE_FOUND)
  set(PCRE_LIBRARIES ${PCRE_LIBRARY} CACHE INTERNAL "")
else(PCRE_FOUND)
  set(PCRE_LIBRARIES CACHE INTERNAL "")
endif(PCRE_FOUND)

mark_as_advanced(PCRE_LIBRARY PCRE_INCLUDE_DIR)
