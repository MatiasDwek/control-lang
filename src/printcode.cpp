#include <iostream>
#include <fstream>
#include <vector>
#include <string>

#include "symbol.hpp"
#include "treenode.hpp"
#include "printcode.hpp"


void print_code(std::vector<Symbol>& terminals_vector, std::string filename)
{
	std::ofstream inter_file(filename);
	if (inter_file.is_open())
	{
		inter_file << "#include <iostream>" << std::endl;
		inter_file << "#include <string>" << std::endl;
		inter_file << "#include <cstdlib>" << std::endl;
		inter_file << "#include <unistd.h>" << std::endl;
		
		inter_file << std::endl << "int main() {" << std::endl;
		
		inter_file << std::endl << "int inint; std::string instring;" << std::endl;
		
		
  		for (std::vector<Symbol>::iterator it = terminals_vector.begin() ; it != terminals_vector.end(); it++)
    			inter_file << it->getString();
    		
    		inter_file << std::endl << "}" << std::endl;
    		
		inter_file.close();
	}
	else
		std::cout << "Unable to open file." << std::endl;
}
