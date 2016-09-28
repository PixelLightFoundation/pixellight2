##################################################
## This file is part of the PixelLight project
##################################################


##################################################
## CheckLinuxCompiler
##
## Additional checks for the used compiler (e.g. GCC or Clang) under Linux
##
##
## Variables:
##   CMAKETOOLS_COMPILER_VISIBILITY_FLAG     Set if the compuler has the visibility flag available (http://gcc.gnu.org/wiki/Visibility)
##   CMAKETOOLS_COMPILER_CPP0X_FLAG          Set if the compiler has the experimental support for the upcoming ISO C++ standard C++0x (see http://gcc.gnu.org/gcc-4.6/cxx0x_status.html), now known as C++11
##################################################


##################################################
## Includes
##################################################
include(CheckCXXSourceCompiles)


##################################################
## Macro: Check if GCC visibility flag is available
##################################################
macro(cmaketools_check_cxx_visibility_flag var)
	set(SAFE_CMAKE_REQUIRED_DEFINITIONS "${CMAKE_REQUIRED_DEFINITIONS}")
	set(CMAKE_REQUIRED_DEFINITIONS "-fvisibility=hidden -fvisibility-inlines-hidden")
	set(CODE "__attribute__ ((visibility(\"default\"))) void testfunc(){} int main() {return 0;}")
	check_cxx_source_compiles("${CODE}" ${var})
	set(CMAKE_REQUIRED_DEFINITIONS "${SAFE_CMAKE_REQUIRED_DEFINITIONS}")
endmacro(cmaketools_check_cxx_visibility_flag)


##################################################
## Macro: Check if GCC C++0x flag is available
##################################################
macro(cmaketools_check_cxx_cpp0x_flag var)
	message(STATUS "check compiler has C++0x flag")
	set(SAFE_CMAKE_REQUIRED_DEFINITIONS "${CMAKE_REQUIRED_DEFINITIONS}")
	set(CMAKE_REQUIRED_DEFINITIONS "-std=c++0x")
	set(CODE "void testfunc(void *pointer){} int main() {testfunc(nullptr);return 0;}")
	check_cxx_source_compiles("${CODE}" ${var})
	set(CMAKE_REQUIRED_DEFINITIONS "${SAFE_CMAKE_REQUIRED_DEFINITIONS}")
endmacro(cmaketools_check_cxx_cpp0x_flag)


##################################################
## Check compiler compatibilities
##################################################

# Check compiler visibility and C++0x flag
if(NOT NO_VISIBILITY_CHECK)
	# Check compiler visibility flag
	cmaketools_check_cxx_visibility_flag(CMAKETOOLS_COMPILER_VISIBILITY_FLAG)
	if(CMAKETOOLS_COMPILER_VISIBILITY_FLAG)
		ADD_DEFINITIONS(-fvisibility=hidden -fvisibility-inlines-hidden -DHAVE_VISIBILITY_ATTR)
		message(STATUS "compiler has visibility flag")
	endif()
endif()

# Check compiler C++0x flag
cmaketools_check_cxx_cpp0x_flag(CMAKETOOLS_COMPILER_CPP0X_FLAG)
if(CMAKETOOLS_COMPILER_CPP0X_FLAG)
	ADD_DEFINITIONS(-std=c++0x)
	message(STATUS "compiler has C++0x flag")
endif()
