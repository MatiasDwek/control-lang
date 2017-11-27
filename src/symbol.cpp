#include <string>

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
			 	 symbol_string = "repeat ";
			 	 break; 
			case SymbolID::semicol_:
			 	 symbol_string = "; ";
			 	 break; 
			case SymbolID::pause_:
			 	 symbol_string = "system(\"sleep\") ";
			 	 break; 
			case SymbolID::outstring_:
			 	 symbol_string = "outstring_ "; 
			 	 break; 
			case SymbolID::outint_:
			 	 symbol_string = "outint_ "; 
			 	 break; 
			case SymbolID::lclick_:
			 	 symbol_string = "lclick_ "; 
			 	 break; 
			case SymbolID::rclick_:
			 	 symbol_string = "rclick_ "; 
			 	 break; 
			case SymbolID::lrelease_:
			 	 symbol_string = "lrelease_ "; 
			 	 break; 
			case SymbolID::rrelease_:
			 	 symbol_string = "rrelease_ "; 
			 	 break; 
			case SymbolID::up_:
			 	 symbol_string = "up_ "; 
			 	 break; 
			case SymbolID::down_:
			 	 symbol_string = "down_ "; 
			 	 break; 
			case SymbolID::left_:
			 	 symbol_string = "left_ "; 
			 	 break; 
			case SymbolID::right_:
			 	 symbol_string = "right_ "; 
			 	 break; 
			case SymbolID::presskey_:
			 	 symbol_string = "presskey_ "; 
			 	 break; 
			case SymbolID::releasekey_:
			 	 symbol_string = "releasekey_ "; 
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
			 	 symbol_string = "inint_ "; 
			 	 break; 
			case SymbolID::mouseposx_:
			 	 symbol_string = "mouseposx_ "; 
			 	 break; 
			case SymbolID::mouseposy_:
			 	 symbol_string = "mouseposy_ "; 
			 	 break; 
			case SymbolID::instring_:
			 	 symbol_string = "instring "; 
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
	
		}
		return symbol_string;

	}
}
