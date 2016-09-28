##################################################
## This file is part of the PixelLight project
##################################################


##################################################
## Linux/GCC platform definitions
##
## This file contains compiler and linker settings which are specific to the GCC compiler suit under Linux
##################################################

if(CMAKE_GENERATOR MATCHES "Makefiles")
	message(STATUS "Check for GCC compiler version")
	set(CMAKE_TEST_COMPILER ${CMAKE_C_COMPILER})
	if(NOT CMAKE_C_COMPILER)
		set(CMAKE_TEST_COMPILER ${CMAKE_CXX_COMPILER})
	endif()

	exec_program(${CMAKE_TEST_COMPILER}
		ARGS -dumpversion
		OUTPUT_VARIABLE CMAKE_COMPILER_OUTPUT
		RETURN_VALUE CMAKE_COMPILER_RETURN
		)
	if(NOT CMAKE_COMPILER_RETURN)
		file(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeOutput.log
		"Determining the version of compiler passed with the following output:\n"
		"${CMAKE_COMPILER_OUTPUT}\n\n")
		string(REGEX REPLACE "\n" " " compilerVersion "${CMAKE_COMPILER_OUTPUT}")
		message(STATUS "Check for GCC compiler version - ${compilerVersion}")
		set(GCC44)
		set(GCC45)
		set(GCC46)
		string(REGEX REPLACE "^([0-9]+).([0-9]+).([0-9]+)\$" "\\1"
		compilerVersionMajor "${compilerVersion}")
		string(REGEX REPLACE "^([0-9]+)[.]+([0-9]+)[.]+([0-9]+)\$" "\\2"
		compilerVersionMinor "${compilerVersion}")
		string(REGEX REPLACE "^([0-9]+)[.]+([0-9]+)[.]+([0-9]+)\$" "\\3"
		compilerVersionBuild "${compilerVersion}")
		set(GCC${compilerVersionMajor}${compilerVersionMinor} 1)
		set(GCC${compilerVersionMajor}${compilerVersionMinor}${compilerVersionBuild} 1)
		set(GCC_VERSION "${compilerVersion}")
	else()
		message(STATUS "Check for GCC compiler version - failed")
		file(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log
		"Determining the version of compiler failed with the following output:\n"
		"${CMAKE_COMPILER_OUTPUT}\n\n")
	endif()
endif()


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
set(LINUX_COMPILE_DEFS
	${LINUX_COMPILE_DEFS}
	GCC									# We are using the GCC/g++ compiler
)
if(APPLE)
	# Add a handy APPLE definition (just like WIN32, LINUX and so on)
	set(LINUX_COMPILE_DEFS
		${LINUX_COMPILE_DEFS}
		APPLE							# We are building for an APPLE OS
	)

	# No visibility compiler flags for now or we get issues with several vtables
	set(NO_VISIBILITY_CHECK 1)			# Do not add the visibility related compiler flags within "CheckLinuxCompiler.cmake" below
endif()
if(GCC44 AND GCC_VERSION VERSION_LESS "4.4.6")
	# Add ALWAYS_RTTI_EXPORT define because with this compiler version the RTTI elements must always be exported
	set(LINUX_COMPILE_DEFS
		${LINUX_COMPILE_DEFS}
		ALWAYS_RTTI_EXPORT
	)
endif()

# Check GCC compiler
include(CMake/Modules/CheckLinuxCompiler.cmake)	# Adds e.g. visibility attribute (http://gcc.gnu.org/wiki/Visibility) and checks for c++0x support


##################################################
## Compiler flags
##################################################

set(LINUX_COMPILE_FLAGS
	${LINUX_COMPILE_FLAGS}
	-mtune=generic						# Produce code optimized for the most common IA32/AMD64/EM64T processors
	-msse3								# Use SSE3 instruction set / code might not run on CPUs with no sse3 instruction
	-Wstrict-null-sentinel				# Warn also about the use of an uncasted NULL as sentinel
)

if(NOT CMAKE_BUILD_TYPE MATCHES Debug)
	set(LINUX_COMPILE_FLAGS
		${LINUX_COMPILE_FLAGS}
	#	-O3								# Very aggressive transformations, long compile times, but usally best runtime performance! (but also dramatically increased binary size, e.g. "libPLScene,so" is 4.5 MB when using -O3)
		-O2								# Balance speed and binary size (e.g. "libPLScene,so" is 2.8 MB)
	#	-Os								# Optimize for binary size (e.g. "libPLScene,so" is 2.1 MB when using -Os)
		-funroll-all-loops				# Perform the optimization of loop unrolling
		-fpeel-loops					# Peels the loops for that there is enough information that they do not roll much (from profile feedback)
		-ftree-vectorize				# Enable the vectorizer
		# The following flag usage is basing on information from http://software.intel.com/en-us/forums/showthread.php?t=66902
		--param max-unroll-times=4
		# The following flag usage is basing on information from http://developer.amd.com/documentation/articles/pages/Compiler-FlagDrivenPerformanceGains.aspx
		-fomit-frame-pointer			# Don't keep the frame pointer in a register for functions that don't need one
	)
else()
	##################################################
	## Debug
	##################################################
	set(LINUX_COMPILE_FLAGS
		${LINUX_COMPILE_FLAGS}
		-ggdb							# Use gdb debugger
	)
endif()


##################################################
## Linker flags
##################################################

if(APPLE)
	# X11 libraries not found on Mac OS X 10.6 - add the X11 library directory manually
	set(LINUX_LINKER_FLAGS
		${LINUX_LINKER_FLAGS}
		-L/usr/X11/lib
	)
endif()
