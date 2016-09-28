##################################################
## Debug helpers
##################################################

# Debug system enable flag
set(PL_DEBUG_BUILD_SYSTEM OFF CACHE BOOL "Enable PL build system verbose output")

##################################################
## MACRO: pl_message
##
## Output a build message
##################################################
macro(pl_message msg)
	message(STATUS "* " ${msg})
endmacro()

##################################################
## MACRO: pl_newline
##
## Output a build message newline
##################################################
macro(pl_newline)
	message(STATUS "*")
endmacro()

##################################################
## MACRO: pl_split
##
## Output a build message split
##################################################
macro(pl_split)
	message(STATUS "********************************************************************************")
endmacro()

##################################################
## MACRO: pl_debug_message
##
## Output a debug message (only visible if PL_DEBUG_BUILD_SYSTEM is set) 
##################################################
macro(pl_debug_message msg)
	if(PL_DEBUG_BUILD_SYSTEM)
		pl_message(${msg})
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