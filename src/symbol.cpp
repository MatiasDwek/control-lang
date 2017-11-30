#include <string>
#include <sstream>

#include "symbol.hpp"

std::string Symbol::getString()
{
	if (this->symbol_type == SymbolType::non_terminal_)
	{
		std::string symbol_string;
		return symbol_string;
	}
	else
	{
		std::string symbol_string;
		std::ostringstream oss;
		switch (this->symbol_ID)
		{
			case SymbolID::while_:
			 	 symbol_string = "while ";
			 	 break; 
			case SymbolID::lparen_:
			 	 symbol_string = "( ";
			 	 break; 
			case SymbolID::rparen_:
			 	 symbol_string = ") ";
			 	 break; 
			case SymbolID::lcurly_:
			 	 symbol_string = "{ ";
			 	 break; 
			case SymbolID::rcurly_:
			 	 symbol_string = "} ";
			 	 break; 
			case SymbolID::if_:
			 	 symbol_string = "if ";
			 	 break; 
			case SymbolID::else_:
			 	 symbol_string = "else ";
			 	 break; 
			case SymbolID::repeat_:
			 	 symbol_string = "for (int repeat = 0; repeat < ";
			 	 break; 
			case SymbolID::semicol_:
			 	 symbol_string = ";\n";
			 	 break; 
			case SymbolID::pause_:
			 	 symbol_string = "usleep( ";
			 	 break; 
			case SymbolID::outstring_:
			 	 symbol_string = "std::cout << "; 
			 	 break; 
			case SymbolID::outint_:
			 	 symbol_string = "std::cout << "; 
			 	 break; 
			case SymbolID::lclick_:
			 	 symbol_string = "system(\"xdotool mousedown 1 \")";
			 	 break; 
			case SymbolID::rclick_:
			 	 symbol_string = "system(\"xdotool mousedown 3 \")";
			 	 break; 
			case SymbolID::lrelease_:
			 	 symbol_string = "system(\"xdotool mousedown 1 \")";
			 	 break; 
			case SymbolID::rrelease_:
			 	 symbol_string = "system(\"xdotool mousedown 3 \")";
			 	 break; 
			case SymbolID::up_:
				symbol_string = "instring = \"xdotool mousemove_relative -- 0 -\" + std::to_string(";
			 	 break; 
			case SymbolID::down_:
				symbol_string = "instring = \"xdotool mousemove_relative -- 0 \" + std::to_string(";
			 	 break; 
			case SymbolID::left_:
			 	 symbol_string = "instring = \"xdotool mousemove_relative -- -\" + std::to_string(";
			 	 break; 
			case SymbolID::right_:
			 	 symbol_string = "instring = \"xdotool mousemove_relative -- \" + std::to_string(";
			 	 break; 
			case SymbolID::presskey_:
				 symbol_string = "instring = \"xdotool keydown \" + ";
			 	 break; 
			case SymbolID::releasekey_:
				 symbol_string = "instring = \"xdotool keyup \" + ";
			 	 break; 
			case SymbolID::id_:
			 	 symbol_string = this->value + " ";
			 	 break; 
			case SymbolID::eqass_:
			 	 symbol_string = "= "; 
			 	 break; 
			case SymbolID::or_:
			 	 symbol_string = "|| "; 
			 	 break; 
			case SymbolID::and_:
			 	 symbol_string = "&& "; 
			 	 break; 
			case SymbolID::eqcomp_:
			 	 symbol_string = "== "; 
			 	 break; 
			case SymbolID::ne_:
			 	 symbol_string = "!= "; 
			 	 break; 
			case SymbolID::lt_:
			 	 symbol_string = "< "; 
			 	 break; 
			case SymbolID::le_:
			 	 symbol_string = "<= "; 
			 	 break; 
			case SymbolID::gt_:
			 	 symbol_string = "> "; 
			 	 break; 
			case SymbolID::ge_:
			 	 symbol_string = ">= "; 
			 	 break; 
			case SymbolID::add_:
			 	 symbol_string = "+ "; 
			 	 break; 
			case SymbolID::sub_:
			 	 symbol_string = "- "; 
			 	 break; 
			case SymbolID::mul_:
			 	 symbol_string = "* "; 
			 	 break; 
			case SymbolID::div_:
			 	 symbol_string = "/ "; 
			 	 break; 
			case SymbolID::mod_:
			 	 symbol_string = "% "; 
			 	 break; 
			case SymbolID::opp_:
			 	 symbol_string = "! "; 
			 	 break; 
			case SymbolID::int_:
			 	 symbol_string = this->value + " ";
			 	 break; 
			case SymbolID::inint_:
			 	 symbol_string = "(std::cin >> inint) ? inint:0";
			 	 break; 
			case SymbolID::mouseposx_: //
			 	 symbol_string = " ";
			 	 break; 
			case SymbolID::mouseposy_: //
			 	 symbol_string = " "; 
			 	 break; 
			case SymbolID::instring_:
			 	 symbol_string = "(std::cin >> instring) ? instring:\"\""; 
			 	 break; 
			case SymbolID::string_:
			 	 symbol_string = this->value + " ";
			 	 break; 
			case SymbolID::string_t_:
			 	 symbol_string = "std::string ";
			 	 break; 
			case SymbolID::int_t_:
			 	 symbol_string = "int ";
			 	 break;
			case SymbolID::post_repeat_:
				symbol_string = "; repeat++) "; 
				break; 
			case SymbolID::post_pause_:
				symbol_string = ") "; 
			 	break; 
			case SymbolID::post_up_:
				symbol_string = "); system(instring.c_str());"; 
			 	break; 
			case SymbolID::post_down_:
				symbol_string = "); system(instring.c_str());"; 
			 	break; 
			case SymbolID::post_left_:
				symbol_string = ") + \" 0\"; system(instring.c_str());"; 
			 	break; 
			case SymbolID::post_right_:
				symbol_string = ") + \" 0\"; system(instring.c_str());"; 
			 	break; 
			case SymbolID::post_presskey_:
				symbol_string = "; system(instring.c_str());"; 
			 	break; 
			case SymbolID::post_releasekey_:
				symbol_string = "; system(instring.c_str());";
			 	break;
			case SymbolID::post_mouseposx_: //
				symbol_string = " 0 \")";
			 	break;
			case SymbolID::post_mouseposy_: //
				symbol_string = " \")";
			 	break;
	
		}
		return symbol_string;

	}
}
