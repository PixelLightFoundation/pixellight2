##################################################
## This file is part of the PixelLight project
##################################################


##################################################
## Linux/Clang platform definitions
##
## This file contains compiler and linker settings which are specific to the Clang compiler suit under Linux
##################################################


##################################################
## Libraries
##################################################

# X11 libraries
set(LINUX_X11_LIBS
	X11									# X-Lib
	Xext								# X extentions library
	Xcursor								# X cursor library
)
set(LINUX_X11_LIB		X11)			# X-Lib
set(LINUX_XEXT_LIB		Xext)			# X extentions library
set(LINUX_XCURSOR_LIB	Xcursor)		# X cursor library


##################################################
## Preprocessor definitions
##################################################

# Preprocessor definitions
if(APPLE)
	# Add a handy APPLE definition (just like WIN32, LINUX and so on)
	set(LINUX_COMPILE_DEFS
		${LINUX_COMPILE_DEFS}
		APPLE							# We are building for an APPLE OS
	)

	# No visibility compiler flags for now or we get issues with several vtables
	set(NO_VISIBILITY_CHECK 1)			# Do not add the visibility related compiler flags within "CheckLinuxCompiler.cmake" below
endif()


##################################################
## Version checks
##################################################
# Do only this check when using the Makefiles CMake generator
if(CMAKE_GENERATOR MATCHES "Makefiles")
	message(STATUS "Check for Clang compiler version")
	set(CMAKE_TEST_COMPILER ${CMAKE_C_COMPILER})
	if(NOT CMAKE_C_COMPILER)
		set(CMAKE_TEST_COMPILER ${CMAKE_CXX_COMPILER})
	endif(NOT CMAKE_C_COMPILER)

	exec_program(${CMAKE_TEST_COMPILER}
		ARGS --version
		OUTPUT_VARIABLE CMAKE_COMPILER_OUTPUT
		RETURN_VALUE CMAKE_COMPILER_RETURN
	)
	if(NOT CMAKE_COMPILER_RETURN)
		file(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeOutput.log
			"Determining the version of compiler passed with the following output:\n"
			"${CMAKE_COMPILER_OUTPUT}\n\n")
		string(REGEX REPLACE "\n" " " compilerVersion "${CMAKE_COMPILER_OUTPUT}")
		message(STATUS "Check for Clang compiler version - ${compilerVersion}")
		set(Cang3)
		string(REGEX REPLACE "^.*[ ]([0-9]+)\\.[0-9].*$" "\\1" CLANG_MAJOR "${compilerVersion}")
		string(REGEX REPLACE "^.*[ ][0-9]+\\.([0-9]).*$" "\\1" CLANG_MINOR "${compilerVersion}")
		set(Clang${CLANG_MAJOR} 1)
		set(Clang_VERSION "${CLANG_MAJOR}.${CLANG_MINOR}")
	else(NOT CMAKE_COMPILER_RETURN)
		message(STATUS "Check for Clang compiler version - failed")
		file(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log
			"Determining the version of compiler failed with the following output:\n"
			"${CMAKE_COMPILER_OUTPUT}\n\n")
	endif(NOT CMAKE_COMPILER_RETURN)

	set(MIN_CLANG_VERSION "3.0")
	if(Clang_VERSION VERSION_LESS MIN_CLANG_VERSION)
		message(FATAL_ERROR "Clang version \"${Clang_VERSION}\" not supported at least Clang version ${MIN_CLANG_VERSION} is needed")
	endif()
endif(CMAKE_GENERATOR MATCHES "Makefiles")

# Check compiler features
# currently Clang < 3.2 has problems with visibility and template instances which gets exported in a library (see http://llvm.org/bugs/show_bug.cgi?id=10113)
# and it adds references to methods to the export table which shouldn't be there (e.g. PLMesh: PLCore::ElementManager<PLRenderer::Animation>::GetByIndex(unsigned int) const) see http://llvm.org/bugs/show_bug.cgi?id=12714
if(Clang_VERSION VERSION_LESS "3.2")
	set(NO_VISIBILITY_CHECK 1)
endif()
include(${CMAKETOOLS_DIR}/Modules/CheckLinuxCompiler.cmake)	# Adds e.g. visibility attribute (http://gcc.gnu.org/wiki/Visibility)


##################################################
## Compiler flags
##################################################

set(LINUX_COMPILE_FLAGS
	${LINUX_COMPILE_FLAGS}
	-msse3								# Use SSE3 instruction set / code might not run on CPUs with no sse3 instruction
)
if(NOT CMAKE_BUILD_TYPE MATCHES Debug)
	set(LINUX_COMPILE_FLAGS
		${LINUX_COMPILE_FLAGS}
		-O2								# Balance speed and binary size
		# The following flag usage is basing on information from http://developer.amd.com/documentation/articles/pages/Compiler-FlagDrivenPerformanceGains.aspx
		-fomit-frame-pointer			# Don't keep the frame pointer in a register for functions that don't need one
	)
endif()
