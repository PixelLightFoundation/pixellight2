#*********************************************************#
#*  File: FindSFK.cmake                                  *
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


# Find sfk (file command tools)
#
# Output variables:
#
#   SFK_FOUND      - set if sfk was found
#   SFK_EXECUTABLE - path to sfk executable

# Search for sfk
set(SFK_EXECUTABLE)
find_program(SFK_EXECUTABLE NAMES sfk.exe PATHS ${CMAKE_SOURCE_DIR}/cmake/UsedTools/sfk)
if(SFK_EXECUTABLE)
	set(SFK_FOUND ON)
else()
	set(SFK_FOUND OFF)
endif()

# Check if sfk has been found
message(STATUS "Looking for sfk...")
if(SFK_FOUND)
	message(STATUS "Looking for sfk... - found ${SFK_EXECUTABLE}")
else()
	message(STATUS "Looking for sfk... - NOT found")
endif()

# Mark variables as advanced
mark_as_advanced(SFK_EXECUTABLE SFK_FOUND)
