#include <boost/test/unit_test.hpp>
#include <trompeloeil.hpp>

namespace trompeloeil
{
  template <>
  void reporter<specialized>::send(
                                   severity s,
                                   char const *file,
                                   unsigned long line,
                                   const char* msg)
  {
    std::ostringstream os;
    if (line != 0U) os << file << ':' << line << '\n';
    auto text = os.str() + msg;
    if (s == severity::fatal)
      BOOST_FAIL(text);
    else
      BOOST_ERROR(text);
  }
}
