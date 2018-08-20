#define CATCH_CONFIG_MAIN
#include <catch2/catch.hpp>
#include "f.hpp"
#include "vanilla_lib/vanilla_lib.hpp"

TEST_CASE( "root vanilla_lib::f exists", "[vanilla_lib]" ) {
    REQUIRE( vanilla_lib::f() == 42 );
}

TEST_CASE( "root f exists", "[vanilla_app]" ) {
    REQUIRE( f() == 24 );
}
