#include <catch2/catch.hpp>
#include "vanilla_lib/vanilla_lib.hpp"

TEST_CASE( "Testing vanilla_lib:f", "[vanilla_lib]" ) {
    REQUIRE( vanilla_lib::f() == 42 );
}
