##################################################
## This file is part of the PixelLight project
##################################################


# This variable will collect all the doxygen-enabled projects
set(PL_DOXYGEN_PATHS CACHE INTERNAL "")


##################################################
## Configure time automation
##################################################

##################################################
## MACRO: pl_add_subdirectory
##
## Helper macro to call CMake's add_subdirectory and also add the directory in question
## to and internal cache to make it possible to manually add some order-bound folders
## and then just call pl_add_subdir_projects to add the rest automatically
##
##   dir Subdir name
##
##################################################
macro(pl_add_subdirectory dir)
	add_subdirectory(${dir})

	set(PL_MANUAL_SUBDIRS ${PL_MANUAL_SUBDIRS} ${dir})
endmacro()

##################################################
## MACRO: pl_add_subdir_projects
##
## Searches recursivelly throught all the subdirectories of the current directory
## and looks for all CMake projects, adding them into the build
##
##################################################
macro(pl_add_subdir_projects)

	# First collect a list of all subdirectories containing the CMake config file
	set(dir_list "")
	file(GLOB_RECURSE new_list CMakeLists.txt)
	foreach(file ${new_list})
		get_filename_component(dir ${file} PATH)

		# Do not add the current directory
		if(NOT ${dir} STREQUAL ${CMAKE_CURRENT_SOURCE_DIR})

			# Also, we don't support sub-projects
			set(add_it ON)
			#foreach(existing_dir ${dir_list})
			#	if(${dir} MATCHES ${existing_dir})
			#		set(add_it OFF)
			#		break()
			#	endif()
			#endforeach()

			# And we also cannot add the same project multiple times
			foreach(existing_dir ${PL_MANUAL_SUBDIRS})
				if(${dir} MATCHES ${existing_dir})
					set(add_it OFF)
					break()
				endif()
			endforeach()

			if(add_it)
				set(dir_list ${dir_list} ${dir})
			endif()
		endif()
	endforeach()
	list(REMOVE_DUPLICATES dir_list)

	# Now add them as usual
	foreach(dir ${dir_list})
		message(STATUS "\n-- Adding directory ${dir}")
		add_subdirectory(${dir})
	endforeach()
endmacro()

##################################################
## MACRO: pl_set_current_package
##
## Set the package name. This will be used for all subsequent project
## definitions until changed
##   name Name of the package
##
##################################################
macro(pl_set_current_package name)
	set(PL_CURRENT_PACKAGE ${name})
	set(PL_CURRENT_PACKAGE_ROOT ${CMAKE_CURRENT_SOURCE_DIR})
endmacro()

##################################################
## MACRO: pl_add_include_paths
##
## Allows to add additional include paths into the current project
## using a list of values
##
##################################################
macro(pl_add_include_paths)
	foreach(path ${ARGN})
		set(PL_CURRENT_INCLUDES ${PL_CURRENT_INCLUDES} ${path})
	endforeach()
endmacro()

##################################################
## MACRO: pl_add_link_libs
##
## Allows to add additional system libraries to link into the current
## project using a list of values
##
##################################################
macro(pl_add_link_libs)
	foreach(path ${ARGN})
		set(PL_CURRENT_LIBS ${PL_CURRENT_LIBS} ${path})
	endforeach()
endmacro()

##################################################
## MACRO: pl_add_compile_defs
##
## Allows to add additional compile definitions into the current
## project using a list of values
##
##################################################
macro(pl_add_compile_defs)
	foreach(path ${ARGN})
		set(PL_CURRENT_COMPILE_DEFS ${PL_CURRENT_COMPILE_DEFS} ${path})
	endforeach()
endmacro()

##################################################
## MACRO: pl_remove_compile_defs
##
## Allows to remove compile definitions from the current
## project using a list of values
##
##################################################
macro(pl_remove_compile_defs)
	foreach(path ${ARGN})
		list(REMOVE_ITEM PL_CURRENT_COMPILE_DEFS ${path})
	endforeach()
endmacro()

##################################################
## MACRO: pl_add_dependencies
##
## Allows to add additional dependencies into the current
## project using a list of values
##
##################################################
macro(pl_add_dependencies)
	foreach(path ${ARGN})
		set(PL_CURRENT_DEPENDENCIES ${PL_CURRENT_DEPENDENCIES} ${path})
	endforeach()
endmacro()

##################################################
## MACRO: pl_project
##
## Define new PixelLight project 
##   name Name of the project
##
##################################################
macro(pl_project name)
	
	# Define local project variables
	set(PL_CURRENT_TARGET_NAME ${name})
	set(PL_CURRENT_OUTPUT_NAME "${PL_CURRENT_PACKAGE}.${name}")

	# The path in IDE
	string(REPLACE "${PL_CURRENT_PACKAGE_ROOT}" "" PL_CURRENT_IDE_PATH "${CMAKE_CURRENT_SOURCE_DIR}")
	set(PL_CURRENT_IDE_PATH ${PL_CURRENT_PACKAGE}${PL_CURRENT_IDE_PATH}) # There is now a slash at the beginning of PL_CURRENT_IDE_PATH
	get_filename_component(PL_CURRENT_IDE_PATH ${PL_CURRENT_IDE_PATH} DIRECTORY)

	# Begin project
	project(${PL_CURRENT_TARGET_NAME} C CXX ${PL_RC_COMPILER})

	# Parse special flags
	set(no_reset OFF)
	foreach(flag ${ARGN})
		if("${flag}" STREQUAL "NORESET")	# Don't reset this project's lists
			set(no_reset ON)				# Useful for creating multiple projects from the same source
		endif()
	endforeach()

	# Initialize project lists
	if(NOT no_reset)
		set(PL_CURRENT_SOURCES "")
		set(PL_CURRENT_INCLUDES "")
		set(PL_CURRENT_LIBS "")
		set(PL_CURRENT_COMPILE_DEFS "")
		set(PL_CURRENT_DEPENDENCIES "")

		# Set build directories (external projects use this)
		set(PL_CURRENT_DOWNLOAD_DIR ${CMAKE_CURRENT_BINARY_DIR}/Download)
		set(PL_CURRENT_SRC_DIR ${CMAKE_CURRENT_BINARY_DIR}/Source)
		set(PL_CURRENT_BUILD_DIR ${CMAKE_CURRENT_BINARY_DIR}/Build)
		set(PL_CURRENT_INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}/Install)
		set(PL_CURRENT_TMP_DIR ${CMAKE_CURRENT_BINARY_DIR}/Temp)
		set(PL_CURRENT_STAMP_DIR ${CMAKE_CURRENT_BINARY_DIR}/Stamp)

		# Set default include paths
		pl_add_include_paths(
			${CMAKE_CURRENT_SOURCE_DIR}/Public
			${CMAKE_CURRENT_SOURCE_DIR}/Private
			${PL_CONFIG_FILE_LOCATION})

		# Set default compile defs
		if(WIN32)
			pl_add_compile_defs(${WIN32_COMPILE_DEFS})
		elseif(LINUX)
			pl_add_compile_defs(${LINUX_COMPILE_DEFS})
		endif()

		# Current project's include path
		set(PL_CURRENT_TARGET_INCLUDE_DIRS ${PL_CURRENT_TARGET_NAME}_INCLUDE_DIRS)
		# Default value
		set(${PL_CURRENT_TARGET_INCLUDE_DIRS} ${CMAKE_CURRENT_SOURCE_DIR}/Public CACHE INTERNAL "")

		# Current project's output link libraries
		set(PL_CURRENT_TARGET_LIBRARIES ${PL_CURRENT_TARGET_NAME}_LIBRARIES)
	else()

		# We have to copy setup from the previous project, but update with the new target name
		# Current project's include path
		set(PL_CURRENT_TARGET_INCLUDE_DIRS ${PL_CURRENT_TARGET_NAME}_INCLUDE_DIRS)
		# Default value
		set(${PL_CURRENT_TARGET_INCLUDE_DIRS} ${CMAKE_CURRENT_SOURCE_DIR}/Public CACHE INTERNAL "")

		# Current project's output link libraries
		set(PL_CURRENT_TARGET_LIBRARIES ${PL_CURRENT_TARGET_NAME}_LIBRARIES)
	endif()

endmacro()

##################################################
## MACRO: pl_collect_source_files
##
## Collect all source files for the project automatically
## You can specify filters for feature specific
## source files in the parameter list
## For example, defining a folder named /+Zip/ with zip-related
## files inside and passing 'Zip' into this function will include
## all files inside that folder into the project
##
##################################################
macro(pl_collect_source_files)

	# First collect all files recursivelly
	file(GLOB_RECURSE all_files *.h *.hpp *.inl *.c *.cpp *.rc)

	# Filter out duplicities
	list(REMOVE_DUPLICATES all_files)

	# Filter out files not belonging to the current feature set
	foreach(file ${all_files})
		if(file MATCHES "/\\+")

			# Feature specific folder
			set(file_in ON)

			# Platforms are identified by a list of unsupported(!) ones
			foreach(platform ${PL_UNSUPPORTED_PLATFORMS})
				if(file MATCHES "/\\+${platform}")
					list(REMOVE_ITEM all_files ${file})
					set(file_in OFF)
					break()
				endif()
			endforeach()

			if(file_in)

				# Remove supported platform filters out of the file name before processing features
				set(file_name ${file})
				foreach(platform ${PL_SUPPORTED_PLATFORMS})
					string(REGEX REPLACE "/\\+${platform}/" "" file_name ${file_name})
				endforeach()

				# If the filename no longer contains any feature identifiers, keep it
				if(file_name MATCHES "/\\+")
					
					# Let's browse through all the features the user wants to enable and look
					# if this file belong to one of them
					set(keep_file OFF)
					foreach(feature ${ARGN})
						if(file_name MATCHES "/\\+${feature}/")
							set(keep_file ON)
							break()
						endif()
					endforeach()

					if(NOT keep_file)
						list(REMOVE_ITEM all_files ${file})
					endif()
				endif()
			endif()
		endif()
	endforeach()

	# Set the list
	set(PL_CURRENT_SOURCES ${all_files})
endmacro()

##################################################
## MACRO: pl_group_sources
##
## Group source files for the current project into IDE folders
##
##################################################
macro(pl_group_sources)
	foreach(file ${PL_CURRENT_SOURCES})

		# Retrieve the file path
		get_filename_component(path ${file} PATH)

		# Helper macro
		macro(group_sources_helper dir_path subdir)
			# Strip the filesystem path and keep just the relative path from the current CMakeLists.txt
			string(REGEX MATCH "${CMAKE_CURRENT_SOURCE_DIR}/${subdir}/" path_match ${dir_path})
			if(path_match)
				string(REPLACE ${path_match} "" out_path ${dir_path})
				
				# Merge platform and feature files with their generic siblings
				#[TODO] This does not work properly with subfolders of feature folders
				string(REGEX REPLACE "/\\+(.+)" "" out_path ${out_path})

				# Group name expects '\' as delimiter
				string(REPLACE "/" "\\" out_path ${out_path})

				source_group(${out_path} FILES ${file})
			endif()
		endmacro()

		# Source files can be in Public or Private subfolders in the current source dir
		group_sources_helper(${path} "Public")
		group_sources_helper(${path} "Private")
	endforeach()
endmacro()

##################################################
## MACRO: pl_create_plugin
##
## Create PL plugin from the current project
##
##################################################
macro(pl_create_plugin)
	
	# Add dependency on PLProject
	pl_add_dependencies(PLPlugin)

	# Invoke PLProject after build
	#set(PL_CURRENT_PLUGIN_PATH ${CMAKE_CURRENT_BINARY_DIR}/Plugins)
	#if(${PL_DEVELOPER_BUILD})
	#	set(PL_CURRENT_PLUGIN_PATH ${PL_DEV_BIN_DIR})
	#endif()

	# Get target library path
	get_property(lib_file TARGET ${PL_CURRENT_TARGET_NAME} PROPERTY LOCATION)
	get_filename_component(lib_path ${lib_file} PATH)

	add_custom_command(
		TARGET ${PL_CURRENT_TARGET_NAME}
		COMMAND PLPlugin --module-path ${lib_file} --output-path ${lib_path}
		WORKING_DIRECTORY ${PL_DEV_BIN_DIR}
	)
endmacro()

##################################################
## MACRO: pl_build_library
##
## Build the current project as library
##
##   type Type of library to build (SHARED, STATIC or PLUGIN - shared library with a plugin file)
##################################################
macro(pl_build_library type)

	set(lib_type ${type})

	# Default to static library
	if("${lib_type}" STREQUAL "")
		set(lib_type "STATIC")
	endif()

	# Plugin
	set(is_plugin OFF)
	if("${lib_type}" STREQUAL "PLUGIN")
		set(is_plugin ON)

		# Set to shared for the rest of this function
		set(lib_type "SHARED")
	endif()
	
	# Parse options
	set(no_install OFF)
	set(no_docs OFF)
	foreach(option ${ARGN})
		if("${option}" STREQUAL "NOINSTALL")	# Turn off the automated installation
			set(no_install ON)
		elseif("${option}" STREQUAL "NODOC")	# Turn off documentation build for this project
			set(no_docs ON)
		endif()
	endforeach()

	# Set/unset build options for shared libraries (only required for MS Windows, but we
	# set at least the definitions to be able to use those definitions within source
	# codes -> we just use the MS Windows names so that we don't have to invent a
	# new definition for this purpose)
	if("${type}" STREQUAL "SHARED")
		pl_add_compile_defs(_WINDLL _USRDLL)
	else()
		pl_remove_compile_defs(_WINDLL _USRDLL)
	endif()

	# Add the library to build
	add_library(${PL_CURRENT_TARGET_NAME} ${lib_type} ${PL_CURRENT_SOURCES})

	# Generate folder structure in IDE
	pl_group_sources()

	# Includes
	include_directories(${PL_CURRENT_TARGET_NAME} ${PL_CURRENT_INCLUDES})

	# Link libraries
	target_link_libraries(${PL_CURRENT_TARGET_NAME} ${PL_CURRENT_LIBS})

	# Dependencies
	if(NOT "${PL_CURRENT_DEPENDENCIES}" STREQUAL "")
		add_dependencies(${PL_CURRENT_TARGET_NAME} ${PL_CURRENT_DEPENDENCIES})
	endif()

	# Preprocessor definitions
	set_target_properties(
		${PL_CURRENT_TARGET_NAME}
		PROPERTIES COMPILE_DEFINITIONS "${PL_CURRENT_COMPILE_DEFS}")

	# Solution folders
	set_property(
		TARGET ${PL_CURRENT_TARGET_NAME}
		PROPERTY FOLDER "${PL_CURRENT_IDE_PATH}")

	# Output file
	set_property(
		TARGET ${PL_CURRENT_TARGET_NAME}
		PROPERTY OUTPUT_NAME ${PL_CURRENT_OUTPUT_NAME})

	# Input libraries for other projects
	set(${PL_CURRENT_TARGET_NAME}_LIBRARIES ${PL_CURRENT_TARGET_NAME} CACHE INTERNAL "")

	if(WIN32)
		# Handle plugin
		if(${is_plugin})
			pl_create_plugin()
		endif()
	endif()

	# Include documentation?
	if(NOT ${no_docs})
		set(PL_DOXYGEN_PATHS "${PL_DOXYGEN_PATHS} ${${PL_CURRENT_TARGET_INCLUDE_DIRS}}" CACHE INTERNAL "")
	endif()

	# Installation
	if(NOT no_install)
		# Install runtime and link libraries
		install(
			TARGETS ${PL_CURRENT_TARGET_NAME}
			RUNTIME DESTINATION ${PL_BIN_DIR} COMPONENT Runtime
			LIBRARY DESTINATION ${PL_BIN_DIR} COMPONENT Runtime
			ARCHIVE DESTINATION ${PL_LIB_DIR} COMPONENT SDK
		)

		# Install include directory
		install(
			DIRECTORY ${${PL_CURRENT_TARGET_INCLUDE_DIRS}}/${PL_CURRENT_TARGET_NAME}
			DESTINATION ${PL_INCLUDE_DIR}
		)
	endif()

	# Plugin file
	#if(${is_plugin})
	#	install(FILES ${PL_CURRENT_PLUGIN_PATH}/${PL_CURRENT_OUTPUT_NAME}.plugin
	#		DESTINATION ${PL_BIN_DIR} COMPONENT Runtime
	#	)
	#endif()

endmacro()

##################################################
## MACRO: pl_build_executable
##
## Build the current project as executable
##
##   subsystem Subsystem for which to build (CONSOLE or WIN32) - ignored on Linux
##################################################
macro(pl_build_executable subsystem)

	# Check subsystem type on Windows
	# [TODO] Support windowed applications
	if(WIN32)
		# Set subsystem type
		if("${subsystem}" STREQUAL "WIN32")
			set(subsys "WIN32")
		else()
			set(subsys "")
		endif()

		# Add build options for subsystem
		if("${subsys}" STREQUAL "WIN32")
			# Windows application
			pl_remove_compile_defs(_CONSOLE)
			#remove_linker_flags(/SUBSYSTEM:CONSOLE)
			pl_add_compile_defs(_WINDOWS)
			#add_linker_flags(/SUBSYSTEM:WINDOWS)
		else()
			# Console application
			pl_remove_compile_defs(_WINDOWS)
			#remove_linker_flags(/SUBSYSTEM:WINDOWS)
			pl_add_compile_defs(_CONSOLE)
			#add_linker_flags   (/SUBSYSTEM:CONSOLE)
		endif()
	endif()

	# Parse options
	set(no_install OFF)
	foreach(option ${ARGN})
		if("${option}" STREQUAL "NOINSTALL") # Turn off the automated installation
			set(no_install ON)
		endif()
	endforeach()

	# Add the library to build
	add_executable(${PL_CURRENT_TARGET_NAME} ${subsys} ${PL_CURRENT_SOURCES})

	# Generate folder structure in IDE
	pl_group_sources()

	# Includes
	include_directories(${PL_CURRENT_TARGET_NAME} ${PL_CURRENT_INCLUDES})

	# Link libraries
	target_link_libraries(${PL_CURRENT_TARGET_NAME} ${PL_CURRENT_LIBS})

	# Dependencies
	if(NOT "${PL_CURRENT_DEPENDENCIES}" STREQUAL "")
		add_dependencies(${PL_CURRENT_TARGET_NAME} ${PL_CURRENT_DEPENDENCIES})
	endif()

	# Preprocessor definitions
	set_target_properties(
		${PL_CURRENT_TARGET_NAME}
		PROPERTIES COMPILE_DEFINITIONS "${PL_CURRENT_COMPILE_DEFS}")

	# Solution folders
	set_property(
		TARGET ${PL_CURRENT_TARGET_NAME}
		PROPERTY FOLDER "${PL_CURRENT_IDE_PATH}")

	# Output file
	set_property(
		TARGET ${PL_CURRENT_TARGET_NAME}
		PROPERTY OUTPUT_NAME ${PL_CURRENT_OUTPUT_NAME})

	# Install
	if(NOT no_install)
		# Install runtime
		install(
			TARGETS ${PL_CURRENT_TARGET_NAME}
			RUNTIME DESTINATION ${PL_BIN_DIR} COMPONENT SDK
		)
	endif()

endmacro()

##################################################
## MACRO: pl_build_external
##
## Helper to finalize the build of an external dependency project
##
##################################################
macro(pl_build_external)

	# Solution folders
	set_property(
		TARGET ${PL_CURRENT_TARGET_NAME}
		PROPERTY FOLDER "${PL_CURRENT_PACKAGE}")

	# Dependencies
	if(NOT "${PL_CURRENT_DEPENDENCIES}" STREQUAL "")
		add_dependencies(${PL_CURRENT_TARGET_NAME} ${PL_CURRENT_DEPENDENCIES})
	endif()

endmacro()

##################################################
## MACRO: pl_add_dependency
##
## Add new knows dependency to the currently built module
##
##   module Name of the module to add
##################################################
macro(pl_add_dependency module)
	
	# Add include paths to the module
	pl_add_include_paths(${${module}_INCLUDE_DIRS})

	# Add link libraries
	pl_add_link_libs(${${module}_LIBRARIES})

	# Add the dependency
	pl_add_dependencies(${module})
endmacro()