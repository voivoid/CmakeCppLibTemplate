#include <iostream>
#include "CoolLib/lib.h"

int main() {
  int a = 0;
  int b = 0;
  std::cin >> a >> b;

  CoolLib::Obj o;
  std::cout << o.add(a, b) << std::endl;

  return 0;
}
