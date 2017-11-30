// Declarations
%{
#include <iostream>
#include <string>
#include <map>

#include "treenode.hpp"
#include "variabletype.hpp"

extern int yylex();

inline void yyerror(const char *s)
{
	std::cout << s << std::endl;
}

static std::map<std::string, std::string> vars;
static std::map<std::string, VariableType> vars_types;



static TreeNode *root;
%}
 
%union{int i; std::string *s; TreeNode *node;}
 
%token<node> WHILE LPAREN RPAREN LCURLY RCURLY IF ELSE
    REPEAT SEMICOL PAUSE OUTSTRING OUTINT LCLICK
    RCLICK LRELEASE RRELEASE UP DOWN LEFT RIGHT
    PRESSKEY RELEASEKEY EQASS OR AND EQCOMP NE LT
    LE GT GE ADD SUB MUL DIV MOD OPP ININT MOUSEPOSX 
    MOUSEPOSY INSTRING STRING_T INT_T
    
%token<i> INT
%token<s> ID STRING

%type<node> file statement definition 
	    fuint fustring
	    
%type<i> expression conjunction equality relation
	 addition term factor primary reint
	 
%type<s> equop relop addop mulop unaryop type restring assignment
	    
%start file

%%


// Translation rules

file : statement
	{
		root = $1;
	}
     ;

statement : statement statement
	{
		Symbol statement(SymbolID::statement_, SymbolType::non_terminal_);
		
		$$ = new TreeNode(statement);
		
		$$->addNode(*$1);
		$$->addNode(*$2);
	}
	  | LCURLY statement RCURLY
	{
		Symbol statement(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement);
		
		Symbol lcurly(SymbolID::lcurly_, SymbolType::terminal_);
		Symbol rcurly(SymbolID::rcurly_, SymbolType::terminal_);
		
		$1 = new TreeNode(lcurly);
		$3 = new TreeNode(rcurly);
		
		$$->addNode(*$1);
		$$->addNode(*$2);
		$$->addNode(*$3);
	} 
	  | WHILE LPAREN expression RPAREN LCURLY statement RCURLY
	  | IF LPAREN expression RPAREN LCURLY statement RCURLY
	  | IF LPAREN expression RPAREN ELSE LCURLY statement RCURLY
	  | REPEAT LPAREN expression RPAREN LCURLY statement RCURLY
	  | definition SEMICOL
	{
		Symbol statement(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement);
		
		Symbol integ(SymbolID::int_, SymbolType::terminal_, std::to_string($1));
		Symbol semicol(SymbolID::semicol_, SymbolType::terminal_);
		
		TreeNode* node1 = new TreeNode(integ);
		TreeNode* node2 = new TreeNode(semicol);
		
		$$->addNode(*node1);
		$$->addNode(*node2);
	}
	  | expression SEMICOL
	{
		Symbol statement(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement);
		
		Symbol integ(SymbolID::int_, SymbolType::terminal_, std::to_string($1));
		Symbol semicol(SymbolID::semicol_, SymbolType::terminal_);
		
		TreeNode* node1 = new TreeNode(integ);
		TreeNode* node2 = new TreeNode(semicol);
		
		$$->addNode(*node1);
		$$->addNode(*node2);
		
		//std::cout << $1 << std::endl;
	}
	  | assignment SEMICOL { ; }
	  | PAUSE reint SEMICOL
	  | OUTSTRING restring SEMICOL
	  | OUTINT reint SEMICOL
	  | LCLICK SEMICOL
	{
		Symbol statement(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement);
	
		Symbol lclick(SymbolID::lclick_, SymbolType::terminal_);
		Symbol semicol(SymbolID::semicol_, SymbolType::terminal_);
		
		$1 = new TreeNode(lclick);
		$2 = new TreeNode(semicol);
		
		$$->addNode(*$1);
		$$->addNode(*$2);
	}
	  | RCLICK SEMICOL
	  | LRELEASE SEMICOL
	  | RRELEASE SEMICOL
	  | UP reint SEMICOL
	  | DOWN reint SEMICOL
	  | LEFT reint SEMICOL
	  | RIGHT reint SEMICOL
	  | PRESSKEY restring SEMICOL
	  | RELEASEKEY restring SEMICOL
	  ;
	  
definition : type ID
	{
		if (*$1 == "int")
		{
			vars[*$2];
			vars_types[*$2] = VariableType::var_int;
		}
		else if (*$1 == "string")
		{
			vars[*$2];
			vars_types[*$2] = VariableType::var_string;
		}
		
		delete $1;
		delete $2;
	}
	   | type assignment
	{
		if (*$1 == "int") 
		{
			if (vars_types.at(*$1) != VariableType::var_int)
				yyerror("Mismatched variables types.");
		}
		else if (*$1 == "string")
		{
			if (vars_types.at(*$1) != VariableType::var_string)
				yyerror("Mismatched variables types.");
		}
		
		delete $1;
		delete $2;
	}
	   ;

assignment : ID EQASS reint
	{
		static std::map<std::string, std::string>::iterator it_vars;
		
		it_vars = vars.find(*$1);
   		if (it_vars != vars.end())
   			yyerror("Variable already defined.");
   		else
   		{
   			vars[*$1] = std::to_string($3);
   			vars_types[*$1] = VariableType::var_int;
   			
   			$$ = new std::string(*$1);
   			
   			delete $1;
   		}
	}
	   | ID EQASS fuint
	{
		;
	}
	   | ID EQASS restring
	{
		static std::map<std::string, std::string>::iterator it_vars;
		
		it_vars = vars.find(*$1);
   		if (it_vars != vars.end())
   			yyerror("Variable already defined.");
   		else
   		{
   			vars[*$1] = *$3;
   			vars_types[*$1] = VariableType::var_string;
   			
   			$$ = new std::string(*$1);
   			
   			delete $1;
   		}
	}
	   | ID EQASS fustring
	{
		;
	}
	   ;
	   
type : INT_T
	{
		$$ = new std::string("int");
	}
     | STRING_T
	{
		$$ = new std::string("string");
	}
     ;
     
expression : conjunction
	{
		$$ = $1;
	}
	   | expression OR conjunction
	{
		$$ = $1 || $3;
	}
	   ;
	   
conjunction : equality 
	{
		$$ = $1;
	}
	    | conjunction AND equality
	{
		$$ = $1 && $3;
	}
	    ;
	   
equality : relation
	{
		$$ = $1;
	}
	 | relation equop relation
	{
		if (*$2 == "==")
			$$ = $1 == $3;
		else if (*$2 == "!=")
			$$ = $1 != $3;
		delete $2;
	}
	 ;
	 
equop : EQCOMP
	{
		$$ = new std::string("==");
	}
      | NE
	{
		$$ = new std::string("!=");
	}
      ;
      
relation : addition
	{
		$$ = $1;
	}
	 | addition relop addition
	{
		if (*$2 == "<")
			$$ = $1 < $3;
		else if (*$2 == "<=")
			$$ = $1 <= $3;
		else if (*$2 == ">")
			$$ = $1 > $3;
		else if (*$2 == ">=")
			$$ = $1 >= $3;
		delete $2;
	}
	 ;
	 
relop : LT
	{
		$$ = new std::string("<");
	}
      | LE
	{
		$$ = new std::string("<=");
	}
      | GT
	{
		$$ = new std::string(">");
	}
      | GE
	{
		$$ = new std::string(">=");
	}
      ;
      
addition : term
	{
		$$ = $1;
	}
	 | addition addop term
	{
		if (*$2 == "+")
			$$ = $1 + $3;
		else if (*$2 == "-")
			$$ = $1 - $3;
		delete $2;
	}
	 ;
	 
addop : ADD
	{
		$$ = new std::string("+");
	}
      | SUB
	{
		$$ = new std::string("-");
	}
      ;
  
term : factor
	{
		$$ = $1;
	}
     | term mulop factor
	{
		if (*$2 == "*")
			$$ = $1 * $3;
		else if (*$2 == "/")
			$$ = $1 / $3;
		else if (*$2 == "%")
			$$ = $1 % $3;
		delete $2;
	}
     ;
      
mulop : MUL
	{
		$$ = new std::string("*");
	}
      | DIV
	{
		$$ = new std::string("/");
	}
      | MOD
	{
		$$ = new std::string("%");
	}
      ;
      
factor : unaryop primary
	{
		if (*$1 == "-")
			$$ = -$2;
		else if (*$1 == "!")
			$$ = !$2;
		delete $1;
	}
       | primary
	{
		$$ = $1;
	}
       ;
       
unaryop : SUB
	{
		$$ = new std::string("-");
	}
        | OPP
	{
		$$ = new std::string("!");
	}
        ;

primary : ID
	{
		static std::map<std::string, std::string>::iterator it_vars;
		
		it_vars = vars.find(*$1);
   		if (it_vars == vars.end())
   			yyerror("Undefined variable.");
   		else
   		{
   			if (vars_types[*$1] != VariableType::var_int)
				yyerror("Mismatched variables types.");
			else
				$$ = std::stoi((vars[*$1]), NULL, 10);
   		}
   		delete $1;
	}
        | INT
	{
		$$ = $1;
	}
        | LPAREN expression RPAREN
	{
		$$ = $2;
	}
        ;
        
fuint : ININT
	{
		;
	}
      | MOUSEPOSX
	{
		;
	}
      | MOUSEPOSY
	{
		;
	}
      ;
      
fustring : INSTRING
	{
		;
	}
         ;
         
reint : expression
	{
		$$ = $1;
	}
       ;
       
restring : STRING 
	{
		$$ = $1;
	}
	 | ID
	{
		static std::map<std::string, std::string>::iterator it_vars;
		
		it_vars = vars.find(*$1);
   		if (it_vars == vars.end())
   			yyerror("Undefined variable.");
   		else
   		{
   			if (vars_types[*$1] != VariableType::var_string)
				yyerror("Mismatched variables types.");
			else
				$$ = new std::string(vars[*$1]);
   		}
	}
	 ;

%%

// Supporting routines

extern int yylex();
extern int yyparse();

int main()
{
	yyparse();
	
	std::vector<Symbol> terminals_vector;
	terminals_vector = root->DFSPreOrder();
	
	std::cout << "Parsed tree terminals:" << std::endl;
	
  	for (std::vector<Symbol>::iterator it = terminals_vector.begin() ; it != terminals_vector.end(); it++)
    		std::cout << ' ' << (int) it->symbol_ID;
  	std::cout << '\n';
}
