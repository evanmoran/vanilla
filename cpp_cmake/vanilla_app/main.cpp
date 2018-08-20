
#include <iostream>

#include "f.hpp"
#include "vanilla_lib/vanilla_lib.hpp"

int main() {
	std::cout << "Starting learn app" << std::endl;
	std::cout << "f() == " << f() << std::endl;
	std::cout << "vanilla_lib::f() == " << vanilla_lib::f() << std::endl;
	return 0;
}