##################################################
## This file is part of the PixelLight project
##################################################


# Set the package name
pl_set_current_package(External)

# Include the required module
include(ExternalProject)

# Include our location dummy
pl_add_subdirectory(.dummy)

# These need to go first
#pl_add_subdirectory(zlib)

# Add the rest automatically
pl_add_subdir_projects()