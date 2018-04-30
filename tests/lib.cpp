#include <boost/test/unit_test.hpp>

#include "trompeloeil.h"

#include "CoolLib/lib.h"

class MockObj :  public CoolLib::Obj
{
public:
  MAKE_MOCK2(add, int(int,int),override);
};

BOOST_AUTO_TEST_CASE(CoolTest) {
  CoolLib::Obj obj;
  BOOST_TEST(obj.add(2, 3) == 5);
}

BOOST_AUTO_TEST_CASE(CoolMockTest) {
  MockObj obj;

  REQUIRE_CALL(obj, add(2, 3)).RETURN(42);
  BOOST_TEST(obj.add(2, 3) == 42);
}
