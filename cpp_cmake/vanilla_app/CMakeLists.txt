# VanillaApp
# =============================================================================
project(VanillaAppProject)

# Applications
# -----------------------------------------------------------------------------
set(VANILLA_APP_MAIN
    main.cpp
)
set(VANILLA_APP_SOURCE
    f.cpp
)

set(VANILLA_APP_TESTS
    f_test.cpp
    test.cpp
)

# VanillaApp
add_executable(VanillaApp ${VANILLA_APP_MAIN} ${VANILLA_APP_SOURCE})
target_include_directories(VanillaApp PRIVATE includes)
set_target_properties(VanillaApp PROPERTIES
    CXX_STANDARD 11
    CXX_STANDARD_REQUIRED ON)
target_link_libraries(VanillaApp VanillaLibrary)

# Tests
# -----------------------------------------------------------------------------

project(Tests)

# App Tests
add_executable(VanillaAppTests ${VANILLA_APP_SOURCE} ${VANILLA_APP_TESTS})
target_include_directories(VanillaAppTests PRIVATE vanilla_app/includes)
target_link_libraries(VanillaAppTests VanillaLibrary Catch2Library)
catch_discover_tests(VanillaAppTests)
