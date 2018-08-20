# Vanilla with Cmake
# =============================================================================

# CMAKE Settings
# -----------------------------------------------------------------------------

cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_COLOR_MAKEFILE ON)
set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_CXX_STANDARD 11)

# Projects
# -----------------------------------------------------------------------------
project(VanillaProject)

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

# # Libraries
# # -----------------------------------------------------------------------------
# set(VANILLA_LIBRARY_INCLUDE
# 	vanilla_lib/include/vanilla_lib/vanilla_lib.hpp
# )
# set(VANILLA_LIBRARY_SOURCE
# 	vanilla_lib/f.hpp
# 	vanilla_lib/f.cpp
# )
# set(VANILLA_LIBRARY_TESTS
#     vanilla_lib/f_test.cpp
#     vanilla_lib/test.cpp
# )

# # VanillaLibrary
# add_library(VanillaLibrary ${VANILLA_LIBRARY_INCLUDE} ${VANILLA_LIBRARY_SOURCE})
# target_include_directories(VanillaLibrary PUBLIC vanilla_lib/include PRIVATE vanilla_lib)

# # Applications
# # -----------------------------------------------------------------------------
# set(VANILLA_APP_MAIN
#     vanilla_app/main.cpp
# )
# set(VANILLA_APP_SOURCE
#     vanilla_app/f.cpp
# )

# set(VANILLA_APP_TESTS
# 	vanilla_app/f_test.cpp
# 	vanilla_app/test.cpp
# )

# # VanillaApp
# add_executable(VanillaApp ${VANILLA_APP_MAIN} ${VANILLA_APP_SOURCE})
# target_include_directories(VanillaApp PRIVATE vanilla_app/includes)
# set_target_properties(VanillaApp PROPERTIES
#     CXX_STANDARD 11
#     CXX_STANDARD_REQUIRED ON)
# target_link_libraries(VanillaApp VanillaLibrary)

# # Tests
# # -----------------------------------------------------------------------------

# # Library Tests
# add_executable(VanillaLibraryTests ${VANILLA_LIBRARY_TESTS})
# target_link_libraries(VanillaLibraryTests VanillaLibrary Catch2Library)
# catch_discover_tests(VanillaLibraryTests)

# # App Tests
# add_executable(VanillaAppTests ${VANILLA_APP_SOURCE} ${VANILLA_APP_TESTS})
# target_include_directories(VanillaAppTests PRIVATE vanilla_app/includes)
# target_link_libraries(VanillaAppTests VanillaLibrary Catch2Library)
# catch_discover_tests(VanillaAppTests)
