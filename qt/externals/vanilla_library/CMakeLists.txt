
# Settings
# -----------------------------------------------------------------------------
# Cmake version
cmake_minimum_required(VERSION 3.5)
# C++11
set (CMAKE_CXX_STANDARD 11)
# Color and verbose
set(CMAKE_COLOR_MAKEFILE ON)
set(CMAKE_VERBOSE_MAKEFILE ON)

# Project
# -----------------------------------------------------------------------------
project("vanilla_library_project")

# Externals
# -----------------------------------------------------------------------------
add_subdirectory(externals)

# For Boost Support
# -----------------------------------------------------------------------------
# FIND_PACKAGE(Boost)
# IF (Boost_FOUND)
#     INCLUDE_DIRECTORIES(${Boost_INCLUDE_DIR})
#     ADD_DEFINITIONS( "-DHAS_BOOST" )
# ENDIF()
# add_library(vanilla_library include/vanilla.hpp ${Boost_LIBRARIES} ${FACE_LIBRARY_HEADER_FILES} ${FACE_LIBRARY_SOURCE_FILES} )

# Library
# -----------------------------------------------------------------------------
file( GLOB VANILLA_LIBRARY_SOURCE_FILES "source/*.cpp")
file( GLOB VANILLA_LIBRARY_HEADER_FILES "include/vanilla/*.hpp")

add_library(vanilla_library include/vanilla.hpp ${VANILLA_LIBRARY_HEADER_FILES} ${VANILLA_LIBRARY_SOURCE_FILES} )

# Includes
# -----------------------------------------------------------------------------
target_include_directories(vanilla_library PUBLIC ${vanilla_library_project_SOURCE_DIR}/include)
# include_directories(${vanilla_library_project_SOURCE_DIR}/include)

# Installs
# -----------------------------------------------------------------------------
install(TARGETS vanilla_library DESTINATION lib)
install(FILES include/vanilla.hpp DESTINATION include/vanilla_library)

# Tests
# -----------------------------------------------------------------------------
enable_testing()
add_subdirectory(tests)
