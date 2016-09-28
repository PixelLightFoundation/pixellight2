#*********************************************************#
#*  File: FindVCTools.cmake                              *
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


# Find VC command line tools
#
# Output variables:
#
#   NMAKE_FOUND        - set if nmake was found
#   NMAKE_EXECUTABLE   - path to nmake executable
#   VCBUILD_FOUND      - set if vcbuild was found
#   VCBUILD_EXECUTABLE - path to vcbuild executable
#   USE_RC_COMPILER    - name of resource compiler
#   MIDL_COMPILER      - name of MILD compiler


# Search for nmake
set(NMAKE_EXECUTABLE)
find_program(NMAKE_EXECUTABLE NAMES nmake.exe)
if(NMAKE_EXECUTABLE)
	set(NMAKE_FOUND ON)
else()
	set(NMAKE_FOUND OFF)
endif()

# Check if nmake has been found
message(STATUS "Looking for nmake...")
if(NMAKE_FOUND)
	message(STATUS "Looking for nmake... - found ${NMAKE_EXECUTABLE}")
else()
	message(STATUS "Looking for nmake... - NOT found")
endif()

# Search for vcbuild
set(VCBUILD_EXECUTABLE)
find_program(VCBUILD_EXECUTABLE NAMES vcbuild.exe)
if(VCBUILD_EXECUTABLE)
	set(VCBUILD_FOUND ON)
else()
	set(VCBUILD_FOUND OFF)
endif()

# Check if vcbuild has been found
message(STATUS "Looking for vcbuild...")
if(VCBUILD_FOUND)
	message(STATUS "Looking for vcbuild... - found ${VCBUILD_EXECUTABLE}")
else()
	message(STATUS "Looking for vcbuild... - NOT found")
endif()

# Check for RC-Compiler
if(WIN32)
	set(USE_RC_COMPILER "RC")
else()
	set(USE_RC_COMPILER "")
endif()

# Check for MIDL compiler
if(WIN32)
	set(MIDL_COMPILER "midl")
endif(WIN32)

# Mark variables as advanced
mark_as_advanced(NMAKE_EXECUTABLE NMAKE_FOUND VCBUILD_EXECUTABLE VCBUILD_FOUND)
