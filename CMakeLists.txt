##################################################
## CMake
##################################################
cmake_minimum_required(VERSION 2.8.3)

# Suppress warning about the deprecated target property LOCATION
cmake_policy(SET CMP0026 OLD)
# Use new variable expansion policy
cmake_policy(SET CMP0054 NEW)

# Add our tools to CMake module path
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/CMake/Modules)

##################################################
## Project
##################################################
project(PixelLight2)

##################################################
## Includes
##################################################

include(CMake/Utils.cmake)
include(CMake/Platform.cmake)
include(VERSION)

pl_split()
pl_message("PixelLight Engine Build")
pl_newline()
pl_message("Version:\t${PL_PROJECT_NAME} ${PL_PROJECT_VERSION_MAJOR}.${PL_PROJECT_VERSION_MINOR}.${PL_PROJECT_VERSION_PATCH} (${PL_PROJECT_VERSION_RELEASE})")
pl_message("Platform:\t${PL_SUPPORTED_PLATFORMS} ${PL_TARGET_ARCHBITSIZE}")
pl_message("Compiler:\t${CMAKE_CXX_COMPILER_ID}")
pl_newline()
pl_split()

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

if(MSVC)
	set(PL_PLATFORM_OUT_DIR ${PL_DEV_BIN_DIR}/$(Configuration))
	set(PL_PLATFORM_LIB_DIR ${PL_DEV_LIB_DIR}/$(Configuration))
else()
	set(PL_PLATFORM_OUT_DIR ${PL_DEV_BIN_DIR})
	set(PL_PLATFORM_LIB_DIR ${PL_DEV_LIB_DIR})
endif()

pl_newline()
pl_message("Output directories:")
pl_message("- binaries:\t${PL_PLATFORM_OUT_DIR}")
pl_message("- libraries:\t${PL_PLATFORM_LIB_DIR}")
pl_message("- documentation:\t${PL_DEV_DOC_DIR}")

pl_newline()
pl_message("Install directories:")
pl_message("- binaries:\t${PL_BIN_DIR}")
pl_message("- libraries:\t${PL_LIB_DIR}")
pl_message("- documentation:\t${PL_DOC_DIR}")
pl_newline()
pl_split()

# [TODO]: Do we need the developer build?
#set(PL_DEVELOPER_BUILD ON CACHE BOOL "Build a version suitable for developing PixelLight itself")

#if(${PL_DEVELOPER_BUILD})
	set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PL_DEV_LIB_DIR})
	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PL_DEV_LIB_DIR})
	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PL_DEV_BIN_DIR})
#	set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${PL_DEV_LIB_DIR})
#	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${PL_DEV_LIB_DIR})
#	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${PL_DEV_BIN_DIR})
#	set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${PL_DEV_LIB_DIR})
#	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${PL_DEV_LIB_DIR})
#	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${PL_DEV_BIN_DIR})
#else()
#	set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY)
#	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY)
#	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY)
#	set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG)
#	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG)
#	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG)
#	set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE)
#	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE)
#	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE)
#endif()

##################################################
## Includes
##################################################
include(CMake/Build.cmake)
include(CMake/Project.cmake)

##################################################
## Include our projects
##################################################

# The configuration target
add_custom_target(
	CONFIGURE
	COMMAND ${CMAKE_COMMAND} 	-D BASE_PATH=${CMAKE_CURRENT_SOURCE_DIR}
								-D BIN_PATH=${PL_PLATFORM_OUT_DIR}
								-P ${CMAKE_CURRENT_SOURCE_DIR}/CMake/Config.cmake
	ADD_DEPENDENCIES ${CMAKE_CURRENT_SOURCE_DIR}/CMake/Config.cmake)

# We don't use our automation macros here to filter out everything more effectively
# (and to keep the right order)

pl_newline()
pl_message("Collecting projects:")

add_subdirectory(External)
add_subdirectory(Engine)

set(PL_BUILD_PLUGINS OFF CACHE BOOL "Build PixelLight plugins")
if(PL_BUILD_PLUGINS)
	add_subdirectory(Plugins)
endif()

set(PL_BUILD_SAMPLES ON CACHE BOOL "Build sample projects?")
if(PL_BUILD_SAMPLES)
	add_subdirectory(Samples)
endif()

set(PL_BUILD_TESTS OFF CACHE BOOL "Build automated unit tests?")
if(PL_BUILD_TESTS)
	add_subdirectory(Tests)
endif()

add_subdirectory(Tools)

set(PL_BUILD_DOCS OFF CACHE BOOL "Build development documentation?")
if(PL_BUILD_DOCS)
	file(MAKE_DIRECTORY ${PL_DEV_DOC_DIR})
	add_subdirectory(Docs)
endif()

set(PL_BUILD_SDK OFF CACHE BOOL "Build SDK installer?")
if(PL_BUILD_SDK)
	add_subdirectory(Packages)
endif()

pl_newline()
pl_split()

##################################################
## Install
##################################################

# Copyright and notes
install(FILES	${CMAKE_SOURCE_DIR}/AUTHORS
				${CMAKE_SOURCE_DIR}/LICENSE
				${CMAKE_SOURCE_DIR}/README
				${CMAKE_SOURCE_DIR}/ReleaseNotes.txt
	DESTINATION ${CMAKE_INSTALL_PREFIX}				
	COMPONENT SDK
)

# [TODO] Testing

message(STATUS "\n")
