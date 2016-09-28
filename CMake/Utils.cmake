##################################################
## This file is part of the PixelLight project
##################################################


##################################################
## Debug helpers
##################################################

##################################################
## MACRO: pl_debug_message
##
## Output a debug message (only visible if PL_DEBUG_BUILD_SYSTEM is set) 
##
##################################################
macro(pl_debug_message msg)
	if(PL_DEBUG_BUILD_SYSTEM)
		message(STATUS ${msg})
	endif()
endmacro()

##################################################
## MACRO: pl_debug_variable
##
## Output the content of a variable as a debug message (only visible if PL_DEBUG_BUILD_SYSTEM is set) 
##################################################
macro(pl_debug_variable var)
	pl_debug_message("${var} = ${${var}}")
endmacro()