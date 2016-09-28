# Build type
if (NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Build type (Debug/Release)")
endif()

# Find VC command line tools
#find_package(VCTools)

# Find sfk
#find_package(SFK)

# Find scp
#find_package(SCP)

# Find diff and patch
#find_package(Diff)

# Enable IDE folder support
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# Config file location
set(PL_CONFIG_FILE_LOCATION "${CMAKE_BINARY_DIR}" CACHE INTERNAL "Location of the PixelLight.h file")