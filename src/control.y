// Declarations
%{
#include <iostream>
#include <string>
#include <map>

#include "treenode.hpp"

extern int yylex();
static std::map<std::string, int> vars;

inline void yyerror(const char *s)
{
	std::cout << s << std::endl;
}

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
%token<node> STRING
%token<node> ID

%type<node> file statement definition assignment 
	    fuint fustring reint restring
	    
%type<i> expression conjunction equality relation
	 addition term factor primary
	 
%type<s> equop relop addop mulop unaryop type
	    
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
		
		std::cout << $1 << std::endl;
	}
	  | assignment SEMICOL
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
		;
	}
	   | type assignment
	{
		;
	}
	   ;

assignment : ID EQASS reint
	{
		;
	}
	   | ID EQASS fuint
	{
		;
	}
	   | ID EQASS restring
	{
		;
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
		//$$ = vars[*$1];
		;
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
        
fuint : INSTRING
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
		;
	}
       | ID
	{
		;
	}
	//{
	//	$$ = vars[*$1];      delete $1;
	//}
       | INT
	{
		;
	}
       ;
       
restring : STRING 
	{
		;
	}
	 | ID
	{
		;
	}
	 ;

 /*
list: stmt
    | list stmt
    ;
 
stmt: expr ','
    | expr ':'          { std::cout << $1 << std::endl; }
    ;
 
expr: INT               { $$ = $1; }
    | VAR               { $$ = vars[*$1];      delete $1; }
    | VAR '=' expr      { $$ = vars[*$1] = $3; delete $1; }
    | expr '+' expr     { $$ = $1 + $3; }
    | expr '-' expr     { $$ = $1 - $3; }
    | expr '*' expr     { $$ = $1 * $3; }
    | expr '/' expr     { $$ = $1 / $3; }
    | expr '%' expr     { $$ = $1 % $3; }
    | '+' expr  %prec BATATA    { $$ =  $2; }
    | '-' expr  %prec BATATA    { $$ = -$2; }
    | '(' expr ')'              { $$ =  $2; }
    ;
 */
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
