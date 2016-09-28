##################################################
## This file is part of the PixelLight project
##################################################


# We want to use the rc.exe resource compiler on Windows under MSVC
set(PL_RC_COMPILER "RC")

# Support Windows
list(REMOVE_ITEM PL_UNSUPPORTED_PLATFORMS Windows)
set(PL_SUPPORTED_PLATFORMS Windows)


##################################################
## Libraries
##################################################

# Standard libraries
set(WIN32_STANDARD_LIBS
	advapi32.lib						# Advanced Win32 API
	shell32.lib							# Shell API
	user32.lib							# User API
	Userenv.lib							# User environment and profiles API
)
set(WIN32_ADVAPI32_LIB	advapi32.lib)	# Advanced Win32 API
set(WIN32_SHELL32_LIB	shell32.lib)	# Shell API
set(WIN32_USER32_LIB	user32.lib)		# User API
set(WIN32_USERENV_LIB	userenv.lib)	# User environment and profiles API
set(WIN32_WINMM_LIB		winmm.lib)		# Windows multimedia API
set(WIN32_VFW32_LIB		vfw32.lib)		# Video for Windows API
set(WIN32_SETUPAPI_LIB	setupapi.lib)	# Setup API

# GDI libraries
set(WIN32_GDI_LIBS
	gdi32.lib							# GDI library
	gdiplus.lib							# GDI+ library
	msimg32.lib							# GDI img32 library
)
set(WIN32_GDI32_LIB		gdi32.lib)		# GDI library
set(WIN32_GDIPLUS_LIB	gdiplus.lib)	# GDI+ library
set(WIN32_MSIMG32_LIB	msimg32.lib)	# GDI img32 library

# Common controls
set(WIN32_COMCTL32_LIB	comctl32.lib)	# Common controls
set(WIN32_COMDLG32_LIB	comdlg32.lib)	# Common dialogs

# Network libraries
set(WIN32_WSOCK32_LIB	wsock32.lib)	# Winsock library
set(WIN32_WS2_32_LIB	ws2_32.lib)		# Winsock2 library

# OpenGL
set(WIN32_OPENGL32_LIB	opengl32.lib)	# OpenGL library
set(WIN32_GLU32_LIB		glu32.lib)		# GLU library


##################################################
## Preprocessor definitions
##################################################
set(WIN32_COMPILE_DEFS
	WIN32								# Windows system
	UNICODE								# Use unicode
	_UNICODE							# Use unicode
	_CRT_SECURE_NO_DEPRECATE			# Disable CRT deprecation warnings
)

if((NOT PL_TARGET_BITSIZE MATCHES 32) AND (CMAKE_SIZEOF_VOID_P MATCHES 8))
	message(STATUS "Setting x64 build preprocessor definitions")
	set(WIN32_COMPILE_DEFS
		${WIN32_COMPILE_DEFS}
		WIN64							# We are building for a 64Bit architecture
		X64_ARCHITECTURE				# We are building for a 64Bit architecture
	)
endif()


##################################################
## Compiler flags
##################################################
set(CMAKE_CXX_FLAGS "/nologo /Zc:wchar_t /Zc:forScope /GR- /Zi /MP /fp:precise /EHs-c- /Gm- /Gy- /fp:fast /fp:except- /Gd")

# Debug
set(CMAKE_CXX_FLAGS_DEBUG "/W4 /MDd /Od /Ob0 /RTC1")

# Release
set(CMAKE_CXX_FLAGS_RELEASE "/W3 /MD /Ox /Ob2 /Oi /Ot /Oy /GL /GF /GS- /arch:SSE2")


##################################################
## Linker flags
##################################################
set(CMAKE_EXE_LINKER_FLAGS
	"/NOLOGO /INCREMENTAL:NO /MANIFEST /NXCOMPAT /DYNAMICBASE:NO"
)

# Debug
set(CMAKE_EXE_LINKER_FLAGS_DEBUG
	"/DEBUG"
)

# Release
set(CMAKE_EXE_LINKER_FLAGS_RELEASE
	"/OPT:REF /OPT:ICF /LTCG /DELAY:UNLOAD")

set(CMAKE_SHARED_LINKER_FLAGS ${CMAKE_EXE_LINKER_FLAGS})
set(CMAKE_MODULE_LINKER_FLAGS ${CMAKE_EXE_LINKER_FLAGS})
set(CMAKE_SHARED_LINKER_FLAGS_DEBUG ${CMAKE_EXE_LINKER_FLAGS_DEBUG})
set(CMAKE_MODULE_LINKER_FLAGS_DEBUG ${CMAKE_EXE_LINKER_FLAGS_DEBUG})
set(CMAKE_SHARED_LINKER_FLAGS_RELEASE ${CMAKE_EXE_LINKER_FLAGS_RELEASE})
set(CMAKE_MODULE_LINKER_FLAGS_RELEASE ${CMAKE_EXE_LINKER_FLAGS_RELEASE})