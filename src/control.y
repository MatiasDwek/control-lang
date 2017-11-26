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
    
%type<node> file statement definition equop relop addop mulop unaryop 
	    fuint fustring type restring assignment
	    addition term factor primary reint
	    expression conjunction equality relation
	    
%token<i> INT

%token<s> ID STRING
	    
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
		/*Symbol statement(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement);
		
		Symbol integ(SymbolID::int_, SymbolType::terminal_, std::to_string($1));
		Symbol semicol(SymbolID::semicol_, SymbolType::terminal_);
		
		TreeNode* node1 = new TreeNode(integ);
		TreeNode* node2 = new TreeNode(semicol);
		
		$$->addNode(*node1);
		$$->addNode(*node2);*/
	}
	  | expression SEMICOL
	{
		/*Symbol statement(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement);
		
		Symbol integ(SymbolID::int_, SymbolType::terminal_, std::to_string($1));
		Symbol semicol(SymbolID::semicol_, SymbolType::terminal_);
		
		TreeNode* node1 = new TreeNode(integ);
		TreeNode* node2 = new TreeNode(semicol);
		
		$$->addNode(*node1);
		$$->addNode(*node2);
		
		//std::cout << $1 << std::endl;*/
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

	}
	   | type assignment
	{

	}
	   ;

assignment : ID EQASS reint
	{

	}
	   | ID EQASS fuint
	{
		;
	}
	   | ID EQASS restring
	{

	}
	   | ID EQASS fustring
	{
		;
	}
	   ;
	   
type : INT_T
	{

	}
     | STRING_T
	{

	}
     ;
     
expression : conjunction
	{

	}
	   | expression OR conjunction
	{

	}
	   ;
	   
conjunction : equality 
	{

	}
	    | conjunction AND equality
	{

	}
	    ;
	   
equality : relation
	{

	}
	 | relation equop relation
	{

	}
	 ;
	 
equop : EQCOMP
	{

	}
      | NE
	{

	}
      ;
      
relation : addition
	{

	}
	 | addition relop addition
	{

	}
	 ;
	 
relop : LT
	{

	}
      | LE
	{

	}
      | GT
	{

	}
      | GE
	{

	}
      ;
      
addition : term
	{

	}
	 | addition addop term
	{

	}
	 ;
	 
addop : ADD
	{

	}
      | SUB
	{

	}
      ;
  
term : factor
	{

	}
     | term mulop factor
	{

	}
     ;
      
mulop : MUL
	{

	}
      | DIV
	{

	}
      | MOD
	{

	}
      ;
      
factor : unaryop primary
	{

	}
       | primary
	{

	}
       ;
       
unaryop : SUB
	{

	}
        | OPP
	{

	}
        ;

primary : ID
	{

	}
        | INT
	{

	}
        | LPAREN expression RPAREN
	{

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

	}
       ;
       
restring : STRING
	{
		Symbol restring(SymbolID::restring_, SymbolType::non_terminal_);
		$$ = new TreeNode(restring);
		
		Symbol string_s(SymbolID::string_, SymbolType::non_terminal_, *$1);
		
		TreeNode string_n(string_s);
		
		$$->addNode(string_n);
	}
	 | ID
	{

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
