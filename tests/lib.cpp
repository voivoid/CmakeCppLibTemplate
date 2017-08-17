#define CATCH_CONFIG_MAIN
#include <catch.hpp>
#include <fakeit.hpp>

#include "lib.h"


TEST_CASE("TestAddFunc", "[Lib]") {
    CHECK(CoolLib::add(2, 3) == 5);
}