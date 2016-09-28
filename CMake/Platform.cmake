##################################################
## Architecture
##################################################

# Check the architecture of the host system
# There is currently a bug in CMake that makes it report 32 bit architecture even on 64 bit system. This is why we don't use the
# CMAKE_SYSTEM_PROCESSOR value. We prefer the native bitsize for the system, however, for MS Visual Studio, we always pick the
# bitsize specified by the generator (as it won't compile otherwise!)
if(CMAKE_GENERATOR MATCHES "Visual Studio*")
	if (CMAKE_GENERATOR MATCHES "Win64")
		set(X86_64 1)
	else()
		set(X86 1)
	endif()
elseif(CMAKE_SIZEOF_VOID_P MATCHES 8)
	set(X86_64 1)
else()
	set(X86 1)
endif()

# Target architecture (x86, arm...)
if(PL_TARGET_ARCH)
	set(PL_TARGET_ARCH ${PL_TARGET_ARCH} CACHE ADVANCED "Target architecture")
else()
	set(PL_TARGET_ARCH "x86" CACHE ADVANCED "Target architecture")
endif()

# Set default bit size depending on the host system architecture (currently set 64bit only for x86_64 hosts)
if(X86_64 AND PL_TARGET_ARCH MATCHES "x86")
	# Target bitsize (32/64)
	set(PL_TARGET_BITSIZE "64" CACHE ADVANCED "Target bitsize")

	# Target architecture & bitsize (x86, x64 - yes, there are many names for the 64 bit version, but e.g. "x64" is just more handy as the technically "x86_64")
	set(PL_TARGET_ARCHBITSIZE "x64" CACHE ADVANCED "Target architecture & bitsize")
else()
	# Target bitsize (32/64)
	set(PL_TARGET_BITSIZE "32" CACHE ADVANCED "Target bitsize")

	# Target architecture & bitsize (x86, x64 - yes, there are many names for the 64 bit version, but e.g. "x64" is just more handy as the technically "x86_32")
	set(PL_TARGET_ARCHBITSIZE ${PL_TARGET_ARCH} CACHE ADVANCED "Target architecture & bitsize")
endif()


##################################################
## Platform-specific folders
##################################################

# This list will initially contain all the supported platform. Each platform-specific
# include can remove from this to enable the source files relevant for the platform
set(PL_UNSUPPORTED_PLATFORMS Windows Linux MaxOSX Android)

# This is the exact opposite of the above variable
set(PL_SUPPORTED_PLATFORMS "")

##################################################
## Platform-specific includes
##################################################

if(UNIX)
  set(LINUX TRUE)
endif()

if(WIN32)
	pl_debug_message("Detected Windows platform")
	include(CMake/Platforms/WinMSVC.cmake)
elseif(LINUX)

	# Common settings
	pl_debug_message("Detected *NIX platform")
	include(CMake/Platforms/LinuxCommon.cmake)

	# Android NDK ("CMAKE_CXX_COMPILER_ID" matches also "GNU", so this test must come first)
	#if(ANDROID)
	#	include(CMake/Platforms/LinuxNDK.cmake)

	# NaCL ("CMAKE_CXX_COMPILER_ID" matches also "GNU", so this test must come first)
	#elseif(NACL)
	#	include(CMake/Platforms/LinuxNaCL.cmake)

	# GCC
	if("${CMAKE_CXX_COMPILER_ID}" MATCHES "GNU")
		pl_debug_message("	- GCC based")
		include(CMake/Platforms/LinuxGCC.cmake)
	#endif()

	# Clang
	elseif("${CMAKE_CXX_COMPILER_ID}" MATCHES "Clang")
		pl_debug_message("	- Clang based")
		include(CMake/Platforms/LinuxClang.cmake)
	#endif()

	# ?
	else()
		message(FATAL_ERROR "Unsupported compiler, use GNU, Clang or NDK")
	endif()
endif()