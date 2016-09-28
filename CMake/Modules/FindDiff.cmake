#*********************************************************#
#*  File: FindDiff.cmake                                 *
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


# Find diff and patch executables
#
# Input variables:
#   SCP_FIND_REQUIRED - set this if configuration should fail without scp
#
# Output variables:
#
#   DIFF_FOUND       - set if diff was found
#   DIFF_EXECUTABLE  - path to diff executable
#   PATCH_FOUND      - set if patch was found
#   PATCH_EXECUTABLE - path to patch executable

# Search for diff
set(DIFF_EXECUTABLE)
find_program(DIFF_EXECUTABLE NAMES diff diff.exe PATHS ${CMAKE_SOURCE_DIR}/cmake/UsedTools/diff)
if(DIFF_EXECUTABLE)
	set(DIFF_FOUND ON)
else()
	set(DIFF_FOUND OFF)
endif()

# Check if diff has been found
message(STATUS "Looking for diff...")
if(DIFF_FOUND)
	message(STATUS "Looking for diff... - found ${DIFF_EXECUTABLE}")
else()
	message(STATUS "Looking for diff... - NOT found")
endif()

# Search for patch
set(PATCH_EXECUTABLE)
find_program(PATCH_EXECUTABLE NAMES patch patch.exe PATHS ${CMAKE_SOURCE_DIR}/cmake/UsedTools/diff)
if(PATCH_EXECUTABLE)
	set(PATCH_FOUND ON)
else()
	set(PATCH_FOUND OFF)
endif()

# Check if patch has been found
message(STATUS "Looking for patch...")
if(PATCH_FOUND)
	message(STATUS "Looking for patch... - found ${PATCH_EXECUTABLE}")
else()
	message(STATUS "Looking for patch... - NOT found")
endif()

# Mark variables as advanced
mark_as_advanced(DIFF_EXECUTABLE DIFF_FOUND PATCH_EXECUTABLE PATCH_FOUND)
