#define BOOST_TEST_MODULE test module name
#include <boost/test/included/unit_test.hpp>
#include <fakeit.hpp>

#include "lib.h"

BOOST_AUTO_TEST_CASE(CoolTest)
{
    BOOST_TEST(CoolLib::add( 2, 3 ) == 5);
}