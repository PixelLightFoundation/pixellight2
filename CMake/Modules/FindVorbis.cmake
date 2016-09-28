#*********************************************************#
#*  File: FindVorbis.cmake                               *
#*
#*  Copyright (C) 2002-2013 The PixelLight Team (http://www.pixellight.org/)
#*
#*  This file is part of PixelLight.
#*
#*  Permission is hereby granted, free of charge, to any person obtaining a copy of this software
#*  and associated documentation files (the "Software"), to deal in the Software without
#*  restriction, including without limitation the rights to use, copy, modify, merge, publish,
#*  distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
#*  Software is furnished to do so, subject to the following conditions:
#*
#*  The above copyright notice and this permission notice shall be included in all copies or
#*  substantial portions of the Software.
#*
#*  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
#*  BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#*  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
#*  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
#*  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#*********************************************************#


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

