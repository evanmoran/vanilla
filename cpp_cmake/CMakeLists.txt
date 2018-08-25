# Vanilla with Cmake
# =============================================================================

# CMAKE Settings
# -----------------------------------------------------------------------------

cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_COLOR_MAKEFILE ON)
set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_CXX_STANDARD 11)
set(COMPANY "VanillaCompany")
set(COPYRIGHT "Copyright (c) 2018 Vanilla Company. All rights reserved.")
set(IDENTIFIER "com.vanillacompany.VanillaExample")

# Projects
# -----------------------------------------------------------------------------
project(VanillaProject VERSION 1.0.0)

# Catch Settings
# -----------------------------------------------------------------------------
set(MASON_CATCH_DIR externals/Catch2)
set(MASON_CATCH_SINGLE_INCLUDE ${MASON_CATCH_DIR}/single_include)
set(MASON_CATCH_FILE ${MASON_CATCH_SINGLE_INCLUDE}/catch2/catch.hpp)
include (${MASON_CATCH_DIR}/contrib/Catch.cmake) # For catch_discover_tests
add_library(Catch2Library INTERFACE)
target_include_directories(Catch2Library INTERFACE ${MASON_CATCH_SINGLE_INCLUDE})
enable_testing()
include(CTest)

add_subdirectory(vanilla_lib)
add_subdirectory(vanilla_app)
add_subdirectory(vanilla_qt)
add_subdirectory(vanilla_qt_py)
