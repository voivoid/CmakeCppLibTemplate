#define BOOST_TEST_MODULE test module name
#include <boost/test/included/unit_test.hpp>
#include <fakeit.hpp>

#include "CoolLib/lib.h"

BOOST_AUTO_TEST_CASE(CoolTest) {
  CoolLib::Obj obj;
  BOOST_TEST(obj.add(2, 3) == 5);
}

BOOST_AUTO_TEST_CASE(CoolMockTest) {
  fakeit::Mock<CoolLib::Obj> mock;
  fakeit::When(Method(mock, add)).Return(42);

  BOOST_TEST(mock.get().add(2, 3) == 42);
}
