# Projects
# -----------------------------------------------------------------------------
project("test_vanilla_library_project")

# Includes
# -----------------------------------------------------------------------------
include_directories(${test_vanilla_library_project_SOURCE_DIR})

file( GLOB TESTS_SOURCE_FILES  "*.cpp")

add_executable(test_vanilla_library ${TESTS_SOURCE_FILES} )
target_link_libraries(test_vanilla_library catch vanilla_library)

# Tests
# -----------------------------------------------------------------------------
add_test(test_vanilla_library test_vanilla_library)