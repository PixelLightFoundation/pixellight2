##################################################
## This file is part of the PixelLight project
##################################################


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
