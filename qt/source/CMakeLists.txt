cmake_minimum_required(VERSION 3.0.2)

# Find includes in corresponding build directories
set(CMAKE_INCLUDE_CURRENT_DIR ON)

# Instruct CMake to run moc automatically when needed.
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)

# Find the QtWidgets library
find_package(Qt5Widgets)

# Tell CMake to create the helloworld executable
add_executable(Vanilla mainwindow.ui main.cpp mainwindow.cpp)

# Use the Widgets module from Qt 5.
target_link_libraries(Vanilla vanilla_library Qt5::Widgets)
