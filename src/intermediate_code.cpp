#include <iostream>
#include <string>
#include <cstdlib>

int main() {

int inint; std::string instring;
std::string b = "hola" ;
int a = 3 ;
while ( a > 1 ) { system("sleep 1 ") ;
a = a - 1 ;
} std::cout << "hola" ;
system("xdotool mousemove_relative -- 0 100 " );
system("xdotool mousemove_relative -- 0 --1 " );
system("xdotool mousemove_relative -- -a 0 " );
system("xdotool mousemove_relative -- a 0 " );
system("xdotool mousedown 3 ");
system("xdotool mousedown 3 ");
system("xdotool mousedown 1 ");
system("xdotool mousedown 3 ");
a = (std::cin >> inint) ? inint:0;
std::cout << a ;
b = (std::cin >> instring) ? instring:"";
std::cout << b ;
system("xdotool keydown b ");
system("sleep 3 ") ;
system("xdotool keyup b ");

}
