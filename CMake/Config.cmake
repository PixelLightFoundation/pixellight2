##################################################
## Project configuration
##################################################

# Include the version info header
include(${BASE_PATH}/VERSION)

# Git info
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${BASE_PATH}/CMake/Modules)
include(GetGitRevisionDescription)
get_git_head_revision(PL_PROJECT_GIT_BRANCH PL_PROJECT_GIT_SHA)

# Fix the branch name (we assume gitflow usage)
string(SUBSTRING "${PL_PROJECT_GIT_BRANCH}" 11 -1 PL_PROJECT_GIT_BRANCH) # 11: strlen /refs/heads/

# Timestamp
string(TIMESTAMP PL_BUILD_TIME "%Y-%m-%d %H:%M UTC" UTC)

# Generate the 'rev' version from the git SHA
string(SUBSTRING "${PL_PROJECT_GIT_SHA}" 0 7 PL_PROJECT_VERSION_REV) # 7 characters from the SHA is git's default abbreviated commit desc

# Create PixelLight build info file
configure_file("${BASE_PATH}/CMake/Config/BuildInfo.json.in" "${BIN_PATH}/BuildInfo.json")
