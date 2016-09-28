##################################################
## This file is part of the PixelLight project
##################################################


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
