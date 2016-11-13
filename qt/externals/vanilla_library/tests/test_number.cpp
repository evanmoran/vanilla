// Vanilla Note: Duplicate this file to add more unit test files
// All test files will be built together automatically by cmake

#include "catch.hpp"

#include "vanilla.hpp"

TEST_CASE("vanilla::random_non_zero_uint64")
{
	auto n1 = vanilla::random_non_zero_uint64();
	REQUIRE(n1 != 0);

	auto n2 = vanilla::random_non_zero_uint64();
	REQUIRE(n2 != 0);

	REQUIRE(n1 != n2);
}