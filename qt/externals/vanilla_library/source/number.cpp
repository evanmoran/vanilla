#include "vanilla/number.hpp"

#include <random>

namespace vanilla {

// Static Values
// -----------------------------------------------------------
static std::random_device static_random_device;
static std::default_random_engine static_random_engine(static_random_device());
static std::uniform_int_distribution<uint64_t> static_non_zero_uint64_uniform_distribution(1.0, UINT64_MAX);

// Functions
// -----------------------------------------------------------
uint64_t random_non_zero_uint64() {
    return static_non_zero_uint64_uniform_distribution(static_random_engine);
}

} // namespace vanilla
