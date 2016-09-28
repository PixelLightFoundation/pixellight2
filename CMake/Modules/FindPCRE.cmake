##################################################
## This file is part of the PixelLight project
##################################################


# - Find PCRE
# Find the native PCRE includes and library
#
#  PCRE_INCLUDE_DIR - where to find pcre.h, etc.
#  PCRE_LIBRARIES   - List of libraries when using libpcre.
#  PCRE_FOUND       - True if pcre found.

if(PCRE_INCLUDE_DIR)
  # Already in cache, be silent
  set(PCRE_FIND_QUIETLY TRUE)
endif(PCRE_INCLUDE_DIR)

find_path(PCRE_INCLUDE_DIR pcre.h)

if(UNIX)
  set(PCRE_NAMES pcre pcreposix)
else()
  set(PCRE_NAMES pcre libpcre)
endif()
find_library(PCRE_LIBRARY NAMES ${PCRE_NAMES} )

# handle the QUIETLY and REQUIRED arguments and set PCRE_FOUND to TRUE if 
# all listed variables are TRUE
include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(PCRE DEFAULT_MSG PCRE_LIBRARY PCRE_INCLUDE_DIR)

if(PCRE_FOUND)
  set(PCRE_LIBRARIES ${PCRE_LIBRARY} CACHE INTERNAL "")
else(PCRE_FOUND)
  set(PCRE_LIBRARIES CACHE INTERNAL "")
endif(PCRE_FOUND)

mark_as_advanced(PCRE_LIBRARY PCRE_INCLUDE_DIR)
