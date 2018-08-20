#define CATCH_CONFIG_MAIN
#include <catch2/catch.hpp>
#include "vanilla_lib/vanilla_lib.hpp"

TEST_CASE( "vanilla_lib general testing", "[vanilla_lib]" ) {
    REQUIRE( vanilla_lib::f() == 42 );
}
