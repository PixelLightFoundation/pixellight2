##################################################
## Project
##################################################
pl_project(Core)


##################################################
## Source files
##################################################

pl_collect_source_files()


##################################################
## Dependencies
##################################################

#pl_add_dependency(zlib)
#pl_add_dependency(pcre)
#pl_add_dependency(rapidjson)


##################################################
## Additional libraries
##################################################

if(WIN32)
	pl_add_link_libs(${WIN32_STANDARD_LIBS} ${WIN32_WSOCK32_LIB} ${WIN32_USER32_LIB})
elseif(LINUX)
	pl_add_link_libs(dl)

	# There's no native curses library on Android, and compiling one
	# just for this usually never used function would be overkill
	# (used within "PixelLight::ConsoleLinux::GetCursorPosition()" & "PixelLight::ConsoleLinux::SetCursorPosition()")
	# No need to link "pthread", it's already within Androids c library
	if(ANDROID)
		pl_add_link_libs(log android)
	else()
		pl_add_link_libs(pthread ncurses)
	endif()
endif()


##################################################
## Preprocessor definitions
##################################################
pl_add_compile_defs(PL_CORE_EXPORTS)

if(WIN32)
	pl_add_compile_defs(PCRE_STATIC)
endif()


##################################################
## Finalize
##################################################
pl_build_library(SHARED)