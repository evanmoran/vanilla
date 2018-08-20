# VanillaLib
# =============================================================================
project(VanillaLibProject)

# Libraries
# -----------------------------------------------------------------------------
set(VANILLA_LIBRARY_INCLUDE
	include/vanilla_lib/vanilla_lib.hpp
)
set(VANILLA_LIBRARY_SOURCE
	f.hpp
	f.cpp
)
set(VANILLA_LIBRARY_TESTS
    f_test.cpp
    test.cpp
)

# VanillaLibrary
add_library(VanillaLibrary ${VANILLA_LIBRARY_INCLUDE} ${VANILLA_LIBRARY_SOURCE})
target_include_directories(VanillaLibrary PUBLIC include)

# Tests
# -----------------------------------------------------------------------------

# Library Tests
add_executable(VanillaLibraryTests ${VANILLA_LIBRARY_TESTS})
target_link_libraries(VanillaLibraryTests VanillaLibrary Catch2Library)
catch_discover_tests(VanillaLibraryTests)
