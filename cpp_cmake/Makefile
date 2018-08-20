# Meta CMake Makefile
# =============================================================================
# Setup cmake with a makefile

# Project Constants
# -----------------------------------------------------------------------------
PROJECT_NAME=VanillaProject
ROOT_DIR=./

UNIX_BUILD_DIR=./build_unix
UNIX_APP=VanillaApp
UNIX_APP_PATH=$(UNIX_BUILD_DIR)/qt/$(UNIX_APP)

XCODE_BUILD_DIR=./build_xcode

VSTUDIO_BUILD_DIR=./build_vs

# Configuration
# -----------------------------------------------------------------------------

RM_RF=rm -rf
MKDIR_P = mkdir -p

# Rules
# -----------------------------------------------------------------------------

default: unix

unix: clean_unix setup_unix make_unix test_unix

mac: clean setup_unix setup_xcode

pc: clean setup_visual_studio

clean: cleanall

xcode: clean_xcode setup_xcode open_xcode

cleanall: clean_unix clean_xcode clean_visual_studio

# Unix
# -----------------------------------------------------------------------------
setup_unix:
	$(MKDIR_P) $(UNIX_BUILD_DIR)
	cmake -G "Unix Makefiles" $(UNIX_BUILD_DIR) -B$(UNIX_BUILD_DIR) -H$(ROOT_DIR)

clean_unix:
	$(RM_RF) $(UNIX_BUILD_DIR)

make_unix:
	$(MAKE) -C $(UNIX_BUILD_DIR)

test_unix:
	cd $(UNIX_BUILD_DIR); ctest

run_unix:
	$(UNIX_APP_PATH)

# XCode
# -----------------------------------------------------------------------------
setup_xcode:
	$(MKDIR_P) $(XCODE_BUILD_DIR)
	cmake -G "Xcode" $(XCODE_BUILD_DIR) -B$(XCODE_BUILD_DIR) -H$(ROOT_DIR)

clean_xcode:
	$(RM_RF) $(XCODE_BUILD_DIR)

open_xcode:
	open $(XCODE_BUILD_DIR)/$(PROJECT_NAME).xcodeproj

# Visual Studio
# -----------------------------------------------------------------------------
setup_visual_studio:
	$(MKDIR_P) $(VSTUDIO_BUILD_DIR)
	cmake -G "Visual Studio 10" $(VSTUDIO_BUILD_DIR) -B$(VSTUDIO_BUILD_DIR) -H$(ROOT_DIR)

clean_visual_studio:
	$(RM_RF) $(VSTUDIO_BUILD_DIR)

open_visual_studio:
	start $(VSTUDIO_BUILD_DIR)/$(VSTUDIO_BUILD_DIR).sln
