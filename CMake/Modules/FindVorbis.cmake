##################################################
## This file is part of the PixelLight project
##################################################


# - Find Vorbis
# Find the native Vorbis includes and library
#
#  LIBVORBIS_INCLUDE_DIRS - where to find vorbisfile.h, etc.
#  LIBVORBIS_LIBRARIES   - List of libraries when using libvorbis.

include(CheckLibraryExists)

find_path(LIBVORBIS_INCLUDE_DIRS vorbis/vorbisfile.h)
find_library(LIBVORBIS_LIBRARY NAMES vorbis)
find_library(LIBVORBISFILE_LIBRARY NAMES vorbisfile)

set(LIBVORBIS_LIBRARIES ${LIBVORBIS_LIBRARY} ${LIBVORBISFILE_LIBRARY} CACHE INTERNAL "")

# handle the QUIETLY and REQUIRED arguments and set OPENAL_FOUND to TRUE if
# all listed variables are TRUE
include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Vorbis  DEFAULT_MSG  LIBVORBIS_LIBRARIES LIBVORBIS_INCLUDE_DIRS)

mark_as_advanced(LIBVORBIS_LIBRARIES LIBVORBIS_INCLUDE_DIRS)

