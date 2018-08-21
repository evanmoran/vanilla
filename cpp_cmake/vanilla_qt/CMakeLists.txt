# VanillaApp
# =============================================================================
set(PROJECT_NAME VanillaQTProject)
project(VanillaQtProject)

# Qt Settings
# -----------------------------------------------------------------------------

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)

if(NOT QT5_DIR)
	set(QT5_DIR "$ENV{QT5_DIR}")
endif(NOT QT5_DIR)

if(NOT QT5_DIR)
	message(WARNING "Environment variable `QT5_DIR` is missing (`export QT5_DIR=~/Qt5.11.1`). Currently it is `$ENV{QT5_DIR}`")
endif(NOT QT5_DIR)

# Make this a GUI application on Windows
if(WIN32)
  set(CMAKE_WIN32_EXECUTABLE ON)
endif()

find_package(Qt5 COMPONENTS Core Widgets REQUIRED)

# QT Application
# -----------------------------------------------------------------------------

# UI
qt5_wrap_ui(UI_HEADERS
	mainwindow.ui
)

# Resources
qt5_add_resources(QRCS
	resources.qrc
)

# Executable
add_executable(VanillaQt
	main.cpp
	mainwindow.cpp
	${UI_HEADERS}
	${QRCS}
)

# Link depending on platform

if(WIN32)
    target_link_libraries(VanillaQt PUBLIC
    	Qt5::Widgets
    	Qt5::WinMain
    	VanillaLibrary
    )
else()
	target_link_libraries(VanillaQt
		Qt5::Widgets
		VanillaLibrary
	)
endif()