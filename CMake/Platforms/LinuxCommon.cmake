##################################################
## Linux/Common platform definitions
##
## This file contains variables and macros that can be used when you build
## your project for Linux (either with GCC or Clang)
## It contains e.g. default compiler and linker settings (common to GCC and Clang)
## and provides variables for important libraries a.s.o.
##################################################

# Support Linux
list(REMOVE_ITEM PL_UNSUPPORTED_PLATFORMS Linux)
set(PL_SUPPORTED_PLATFORMS Linux)

##################################################
## Preprocessor definitions
##################################################

# Preprocessor definitions
set(LINUX_COMPILE_DEFS
	LINUX													# Linux system
	PIC														# Position-independent code
	_REENTRANT												# Reentrant code
	ARCHITECTURE_STRING="${CMAKETOOLS_TARGET_ARCHBITSIZE}"	# Set target architecture so e.g. "PLCore::System::GetPlatformArchitecture()" is able to return the exact architecture it was compiled for (for instance 'x86', 'x64', 'armeabi', 'armeabi-v7a' and so on)
)

if((NOT CMAKETOOLS_TARGET_BITSIZE MATCHES 32) AND (CMAKE_SIZEOF_VOID_P MATCHES 8))
	set(LINUX_COMPILE_DEFS
		${LINUX_COMPILE_DEFS}
		X64_ARCHITECTURE									# We are building for a 64Bit architecture
	)
endif()

if(CMAKE_BUILD_TYPE MATCHES Debug)
	##################################################
	## Debug
	##################################################
	set(LINUX_COMPILE_DEFS
		${LINUX_COMPILE_DEFS}
		_DEBUG												# Debug build
	)
else()
	##################################################
	## Release
	##################################################
	set(LINUX_COMPILE_DEFS
		${LINUX_COMPILE_DEFS}
		NDEBUG												# Release build
	)
endif()


##################################################
## Compiler flags
##################################################

# Check if an 32Bit build should be made on an 64Bit host (CMAKE_SIZEOF_VOID_P has the value 8 on 64Bit Systems at least on x86 systems)
if((CMAKETOOLS_TARGET_BITSIZE MATCHES 32) AND (CMAKE_SIZEOF_VOID_P MATCHES 8))
	message(STATUS "Add compiler flags for 32Bit on 64Bit host")
	set(LINUX_COMPILE_FLAGS
		${LINUX_COMPILE_FLAGS}
		-m32
	)
endif()

# Compiler flags
set(LINUX_COMPILE_FLAGS
	${LINUX_COMPILE_FLAGS}
	-pthread												# Use pthreads
	-ffor-scope												# If -ffor-scope is specified, the scope of variables declared in a for-init-statement is limited to the `for' loop itself, as specified by the C++ standard
	-fno-rtti												# No C++ RTTI
	-fno-exceptions											# No C++ exception handling
	-pipe													# Use Pipes
	-ffunction-sections										# For slightly reduced binary size (http://gcc.gnu.org/onlinedocs/gcc-4.0.4/gcc/Optimize-Options.html)
	-fdata-sections											# For slightly reduced binary size (http://gcc.gnu.org/onlinedocs/gcc-4.0.4/gcc/Optimize-Options.html)
	# The following flag usage is basing on information from http://developer.amd.com/documentation/articles/pages/Compiler-FlagDrivenPerformanceGains.aspx
	-ffast-math												# Perform floating point transformations that may break IEEE/ISO rules regarding floating point arithmetic
	# Some dialect-options of gcc: http://gcc.gnu.org/onlinedocs/gcc/C_002b_002b-Dialect-Options.html
	-Wnon-virtual-dtor										# Warn when a class has virtual functions and accessible non-virtual destructor, in which case it would be possible but unsafe to delete an instance of a derived class through a pointer to the base class. This warning is also enabled if -Weffc++ is specified.
	-Wreorder												# Warn when the order of member initializers given in the code does not match the order in which they must be executed
	-Wsign-promo											# Warn when overload resolution chooses a promotion from unsigned or enumerated type to a signed type, over a conversion to an unsigned type of the same size
#	-Wold-style-cast										# Warn if an old-style (C-style) cast is used - just set it to look for c-style casts because some used libs produce c-style warnings and we can't change that
)

if(CMAKE_BUILD_TYPE MATCHES Debug)
	##################################################
	## Debug 
	##################################################
	set(LINUX_COMPILE_FLAGS
		${LINUX_COMPILE_FLAGS}
		-g3													# Debug level 3
	)
endif()


##################################################
## Linker flags
##################################################

# Check if an 32Bit build should be made on an 64Bit host (CMAKE_SIZEOF_VOID_P has the value 8 on 64Bit Systems at least on x86 systems)
if((CMAKETOOLS_TARGET_BITSIZE MATCHES 32) AND (CMAKE_SIZEOF_VOID_P MATCHES 8))
	message(STATUS "Add linker flags for 32Bit on 64Bit host")
	set(LINUX_LINKER_FLAGS
		${LINUX_LINKER_FLAGS}
		-m32
	)
endif()

# Linker flags - the Apple standard linker doesn't know them
if(NOT APPLE)
	set(LINUX_LINKER_FLAGS
		${LINUX_LINKER_FLAGS}
		-Wl,--as-needed										# Quote from http://www.gentoo.org/proj/en/qa/asneeded.xml : "The flag tells the linker to link in the produced binary only the libraries containing symbols actually used by the binary itself"
		-Wl,--gc-sections									# For slightly reduced binary size
		-Wl,--no-undefined									# Show undefined symbols as linker errors, else we only notice undefined symbols when using the shared library at runtime
	)
	if(NOT CMAKE_BUILD_TYPE MATCHES Debug)
		##################################################
		## Release
		##################################################
		set(LINUX_LINKER_FLAGS
			${LINUX_LINKER_FLAGS}
			-Wl,--strip-all									# For reduced binary size: Throw away as much as possible
		)
	endif()
endif()
