# Settings
# -----------------------------------------------------------------------------
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)
# C++11
set (CMAKE_CXX_STANDARD 11)
# Color and verbose
set(CMAKE_COLOR_MAKEFILE ON)
set(CMAKE_VERBOSE_MAKEFILE ON)
# QT path
set(CMAKE_PREFIX_PATH $ENV{HOME}/Qt5.7.0/5.7/clang_64/)

# Projects
# -----------------------------------------------------------------------------
project("vanilla_project")

# Externals
# -----------------------------------------------------------------------------
add_subdirectory(externals)

# Build
# -----------------------------------------------------------------------------
# Find includes in corresponding build directories
set(CMAKE_INCLUDE_CURRENT_DIR ON)

# Instruct CMake to run moc automatically when needed.
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)

file( GLOB VANILLA_SOURCE_FILES "source/*.*")

# Find the QtWidgets library
find_package(Qt5Widgets)
find_package(vanilla_library)

# Tell CMake to create the executable
add_executable(Vanilla ${VANILLA_SOURCE_FILES})

# Target the libs needed to build
target_link_libraries(Vanilla vanilla_library Qt5::Widgets)
