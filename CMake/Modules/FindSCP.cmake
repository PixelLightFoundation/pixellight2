#*********************************************************#
#*  File: FindSCP.cmake                                  *
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


# Find the OpenSSH scp ("secure copy") or PuTTY pscp command.
#
# Input variables:
#   SCP_FIND_REQUIRED - set this if configuration should fail without scp
#
# Output variables:
#
#   SCP_FOUND      - set if scp was found
#   SCP_EXECUTABLE - path to scp or pscp executable
#   SCP_BATCH_FLAG - how to put scp/pscp into batch mode

# Search for scp
set(SCP_EXECUTABLE)
find_program(SCP_EXECUTABLE NAMES scp scp.exe pscp pscp.exe)
if(SCP_EXECUTABLE)
	set(SCP_FOUND ON)
else()
	set(SCP_FOUND OFF)
endif()

# Determine version and set command line parameters accordingly
if(SCP_FOUND)
	get_filename_component(_scp_name ${SCP_EXECUTABLE} NAME_WE)
	if(_scp_name STREQUAL scp)
		set(SCP_BATCH_FLAG -B)
	else()
		set(SCP_BATCH_FLAG -batch)
	endif()
endif()

# Check if scp has been found
message(STATUS "Looking for scp...")
if(SFK_FOUND)
	message(STATUS "Looking for scp... - found ${SCP_EXECUTABLE}")
else()
	message(STATUS "Looking for scp... - NOT found")
endif()

# Mark variables as advanced
mark_as_advanced(SCP_EXECUTABLE SCP_FOUND SCP_BATCH_FLAG)
