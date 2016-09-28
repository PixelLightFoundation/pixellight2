##################################################
## This file is part of the PixelLight project
##################################################


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
