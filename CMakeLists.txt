##################################################
## This file is part of the PixelLight project
##################################################


##################################################
## CMake
##################################################
cmake_minimum_required(VERSION 2.8.3)

if(CMAKE_MAJOR_VERSION GREATER 2)
	# Suppress warning about the deprecated target property LOCATION
	cmake_policy(SET CMP0026 OLD)
	# Use old behavior when dealing with variable expansion
	cmake_policy(SET CMP0054 OLD)
endif()

##################################################
## Project
##################################################
project(PixelLight2)

##################################################
## Debug
##################################################
set(PL_DEBUG_BUILD_SYSTEM OFF CACHE BOOL "Enable verbose and debug output from the PixelLight build system")
mark_as_advanced(FORCE PL_DEBUG_BUILD_SYSTEM)

##################################################
## Includes
##################################################
include(CMake/Utils.cmake)
include(CMake/Platform.cmake)

##################################################
## Output directories
##################################################

# Install bin
set(PL_BIN_DIR "${CMAKE_INSTALL_PREFIX}/Bin/${PL_TARGET_ARCHBITSIZE}")
# Developer bin
set(PL_DEV_BIN_DIR "${CMAKE_CURRENT_SOURCE_DIR}/_Bin/${PL_TARGET_ARCHBITSIZE}")

# Install lib
set(PL_LIB_DIR "${CMAKE_INSTALL_PREFIX}/Lib/${PL_TARGET_ARCHBITSIZE}")
# Developer lib
set(PL_DEV_LIB_DIR "${CMAKE_CURRENT_SOURCE_DIR}/_Lib/${PL_TARGET_ARCHBITSIZE}")

# Install include
set(PL_INCLUDE_DIR "${CMAKE_INSTALL_PREFIX}/Include")

# Install documentation
set(PL_DOC_DIR "${CMAKE_INSTALL_PREFIX}/Docs")
# Developer documentation
set(PL_DEV_DOC_DIR "${CMAKE_CURRENT_SOURCE_DIR}/_Docs")

##################################################
## Includes
##################################################
include(CMake/Config.cmake)
include(CMake/Build.cmake)
include(CMake/Project.cmake)

##################################################
## Include our projects
##################################################

# We don't use our automation macros here to filter out everything more effectively
# (and to keep the right order)

add_subdirectory(External)
add_subdirectory(Engine)

if(PL_BUILD_PLUGINS)
	add_subdirectory(Plugins)
endif()

if(PL_BUILD_SAMPLES)
	add_subdirectory(Tutorial)
endif()

if(PL_BUILD_TESTS)
	add_subdirectory(Tests)
endif()

add_subdirectory(Tools)

if(PL_BUILD_DOCS)
	file(MAKE_DIRECTORY ${PL_DEV_DOC_DIR})
	add_subdirectory(Docs)
endif()

if(PL_BUILD_SDK)
	add_subdirectory(Packages)
endif()

##################################################
## Install
##################################################

# Copyright and notes
install(FILES
				${CMAKE_SOURCE_DIR}/LICENSE
	DESTINATION ${CMAKE_INSTALL_PREFIX}				
	COMPONENT SDK
)

# [TODO] Testing

# [TODO] Formatted config output
