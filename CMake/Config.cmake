##################################################
## This file is part of the PixelLight project
##################################################


##################################################
## Project configuration
##################################################

set(PL_PROJECT_NAME "PixelLight")

set(PL_PROJECT_VERSION_MAJOR    2)
set(PL_PROJECT_VERSION_MINOR    0)
set(PL_PROJECT_VERSION_PATCH    0)
set(PL_PROJECT_VERSION_RELEASE "Spark")

# Create PixelLight header file
configure_file("CMake/Config/PixelLight.h.in" "${CMAKE_BINARY_DIR}/PixelLight.h")
set(PL_CONFIG_FILE_LOCATION "${CMAKE_BINARY_DIR}" CACHE INTERNAL "Location of the PixelLight.h file")


##################################################
## Developer build
##################################################

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
## Build configuration
##################################################

# Enable IDE folder support
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

set(PL_BUILD_SAMPLES OFF CACHE BOOL "Build sample projects?")
set(PL_BUILD_PLUGINS OFF CACHE BOOL "Build PixelLight plugins")
set(PL_BUILD_DOCS OFF CACHE BOOL "Build development documentation?")
set(PL_BUILD_SDK OFF CACHE BOOL "Build SDK installer?")
set(PL_BUILD_TESTS OFF CACHE BOOL "Build automated unit tests?")

# Build without zip support
#set(PL_NO_ZIP_SUPPORT OFF CACHE BOOL "Disable zip filesysytem support (not recommended)")

# Build without jpeg support
#set(PL_NO_JPG_SUPPORT OFF CACHE BOOL "Disable JPEG image loading support")

# Build without png support
#set(PL_NO_PNG_SUPPORT OFF CACHE BOOL "Disable PNG image loading support")

# Add our tools to CMake module path
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/CMake/Modules)