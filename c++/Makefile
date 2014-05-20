# Vanilla C++ Makefile
# =============================================================================

# Project configuration
# -----------------------------------------------------------------------------

TARGET=vanilla

SOURCES=main.cpp
OBJECTS=$(subst .cpp,.o,$(SOURCES))

TEST_SOURCES=test.cpp
TEST_OBJECTS=$(subst .cpp,.o,$(TEST_SOURCES))

# External libraries referenced with pkg-config
# -----------------------------------------------------------------------------
INCLUDES = tclap external/catch.pc

# Compiler configuration
# -----------------------------------------------------------------------------

CC=gcc
CXX=g++
RM=rm -f
CXXFLAGS = $(shell pkg-config --cflags $(INCLUDES))
LIBS     = $(shell pkg-config --libs $(INCLUDES))

# Makefile rules
# -----------------------------------------------------------------------------

all: vanilla test

build_test: $(TEST_OBJECTS)
	$(CXX) $(CXXFLAGS) -Wall $(LDFLAGS) -o test $(TEST_OBJECTS) $(LDLIBS)

test: build_test
	./test

build_vanilla: $(OBJECTS)
	$(CXX) $(CXXFLAGS) -Wall $(LDFLAGS) -o $(TARGET) $(OBJECTS) $(LDLIBS)

env:
	echo "" > .env
	echo TARGET: $(TARGET) >> .env
	echo SOURCES: $(SOURCES) >> .env
	echo OBJECTS: $(OBJECTS) >> .env
	echo INCLUDES: $(INCLUDES) >> .env
	echo CC: $(CC) >> .env
	echo CXX: $(CXX) >> .env
	echo CPPFLAGS: $(CPPFLAGS) >> .env
	echo CFLAGS: $(CFLAGS) >> .env
	echo LDFLAGS: $(LDFLAGS) >> .env
	echo LDLIBS: $(LDLIBS) >> .env
	cat .env

clean:
	$(RM) $(OBJECTS) $(TEST_OBJECTS) .env

cleanall: dist-clean

dist-clean: clean
	$(RM) $(TARGET) test

depend: .depend

.depend: $(SOURCES)
	rm -f ./.depend
	$(CXX) $(CPPFLAGS) -MM $^>>./.depend;

include .depend

# Include paths for external C++ libraries
# CXXFLAGS=-I/external/tclap/include -I/external/catch/include


# Flags to pass to the compiler
# FLAGS=-Wall

# Compile objects with compiler


# NOTE: These variables are used by the built-in implicit makefile rules
#     CC -- the c compiler to use
#     CXX -- the c++ compiler to use
#     LD -- the linker to use
#     CFLAGS -- compilation flag for c source files
#     CXXFLAGS -- compilation flags for c++ source files
#     CPPFLAGS -- flags for the c-preprocessor (typically include file paths and symbols defined on the command line), used by c and c++
#     LDFLAGS -- linker flags
#     LDLIBS -- libraries to link

# NOTE: C++ Object files are built with this implicit makefile rule
#   %.o: %.cpp
#      $(CXX) -c $(CPPFLAGS) $(CFLAGS)
