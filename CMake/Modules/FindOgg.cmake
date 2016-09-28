##################################################
## This file is part of the PixelLight project
##################################################


# - Find Ogg
# Find the native Ogg includes and library
#
#  LIBOGG_INCLUDE_DIRS - where to find ogg.h, etc.
#  LIBOGG_LIBRARIES    - List of libraries when using libogg.

include(CheckLibraryExists)

find_path(LIBOGG_INCLUDE_DIRS ogg/ogg.h)

find_library(LIBOGG_LIBRARY NAMES ogg)

set(LIBOGG_LIBRARIES ${LIBOGG_LIBRARY} CACHE INTERNAL "")

# handle the QUIETLY and REQUIRED arguments and set OPENAL_FOUND to TRUE if
# all listed variables are TRUE
include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Ogg  DEFAULT_MSG  LIBOGG_LIBRARY LIBOGG_INCLUDE_DIRS)

mark_as_advanced(LIBOGG_LIBRARY LIBOGG_INCLUDE_DIRS)
