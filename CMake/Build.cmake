##################################################
## This file is part of the PixelLight project
##################################################


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