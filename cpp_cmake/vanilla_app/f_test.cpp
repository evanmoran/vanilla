#include <catch2/catch.hpp>
#include "f.hpp"

TEST_CASE( "f works", "[vanilla_app]" ) {
    REQUIRE( f() == 24 );
}
