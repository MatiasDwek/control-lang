// Declarations
%{
#include <iostream>
#include <string>
#include <map>
#include <cstdlib>

#include "treenode.hpp"
#include "variabletype.hpp"
#include "printcode.hpp"

extern int yylex();
extern FILE *yyin;

static TreeNode *root;

inline void yyerror(const char *s)
{
	std::cout << s << std::endl;
	
	delete root;
	
	exit(0);
}

static std::map<std::string, std::string> vars;
static std::map<std::string, VariableType> vars_types;




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
		
		delete $1, $2;
	}
	  | LCURLY statement RCURLY
	{
		Symbol statement(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement);
		
		Symbol lcurly_s(SymbolID::lcurly_, SymbolType::terminal_);
		Symbol rcurly_s(SymbolID::rcurly_, SymbolType::terminal_);
		
		TreeNode lcurly_n(lcurly_s);
		TreeNode rcurly_n(rcurly_s);
		
		$$->addNode(lcurly_n);
		$$->addNode(*$2);
		$$->addNode(rcurly_n);
		
		delete $2;
	} 
	  | WHILE LPAREN expression RPAREN LCURLY statement RCURLY
	{
	  	Symbol statement_s(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement_s);
		
		Symbol while_s(SymbolID::while_, SymbolType::terminal_);
		TreeNode while_n(while_s);
		
		Symbol lparen_s(SymbolID::lparen_, SymbolType::terminal_);
		TreeNode lparen_n(lparen_s);
		
		Symbol rparen_s(SymbolID::rparen_, SymbolType::terminal_);
		TreeNode rparen_n(rparen_s);
		
		Symbol lcurly_s(SymbolID::lcurly_, SymbolType::terminal_);
		TreeNode lcurly_n(lcurly_s);
		
		Symbol rcurly_s(SymbolID::rcurly_, SymbolType::terminal_);
		TreeNode rcurly_n(rcurly_s);
		
		$$->addNode(while_n);
		$$->addNode(lparen_n);
		$$->addNode(*$3);
		$$->addNode(rparen_n);
		$$->addNode(lcurly_n);
		$$->addNode(*$6);
		$$->addNode(rcurly_n);
		
		delete $3, $6;
	}
	  | IF LPAREN expression RPAREN LCURLY statement RCURLY
	{
	  	Symbol statement_s(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement_s);
		
		Symbol if_s(SymbolID::if_, SymbolType::terminal_);
		TreeNode if_n(if_s);
		
		Symbol lparen_s(SymbolID::lparen_, SymbolType::terminal_);
		TreeNode lparen_n(lparen_s);
		
		Symbol rparen_s(SymbolID::rparen_, SymbolType::terminal_);
		TreeNode rparen_n(rparen_s);
		
		Symbol lcurly_s(SymbolID::lcurly_, SymbolType::terminal_);
		TreeNode lcurly_n(lcurly_s);
		
		Symbol rcurly_s(SymbolID::rcurly_, SymbolType::terminal_);
		TreeNode rcurly_n(rcurly_s);
		
		$$->addNode(if_n);
		$$->addNode(lparen_n);
		$$->addNode(*$3);
		$$->addNode(rparen_n);
		$$->addNode(lcurly_n);
		$$->addNode(*$6);
		$$->addNode(rcurly_n);
		
		delete $3, $6;
	}
	  | IF LPAREN expression RPAREN LCURLY statement RCURLY ELSE LCURLY statement RCURLY
	{
	  	Symbol statement_s(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement_s);
		
		Symbol if_s(SymbolID::if_, SymbolType::terminal_);
		TreeNode if_n(if_s);
		
		Symbol lparen_s(SymbolID::lparen_, SymbolType::terminal_);
		TreeNode lparen_n(lparen_s);
		
		Symbol rparen_s(SymbolID::rparen_, SymbolType::terminal_);
		TreeNode rparen_n(rparen_s);
		
		Symbol else_s(SymbolID::else_, SymbolType::terminal_);
		TreeNode else_n(else_s);
		
		Symbol lcurly_s(SymbolID::lcurly_, SymbolType::terminal_);
		TreeNode lcurly_n(lcurly_s);
		
		Symbol rcurly_s(SymbolID::rcurly_, SymbolType::terminal_);
		TreeNode rcurly_n(rcurly_s);
		
		$$->addNode(if_n);
		$$->addNode(lparen_n);
		$$->addNode(*$3);
		$$->addNode(rparen_n);
		$$->addNode(lcurly_n);
		$$->addNode(*$6);
		$$->addNode(rcurly_n);
		$$->addNode(else_n);
		$$->addNode(lcurly_n);
		$$->addNode(*$10);
		$$->addNode(rcurly_n);
		
		delete $3, $6, $10;
	}
	  | REPEAT LPAREN expression RPAREN LCURLY statement RCURLY
	{
	  	Symbol statement_s(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement_s);
		
		Symbol repeat_s(SymbolID::repeat_, SymbolType::terminal_);
		TreeNode repeat_n(repeat_s);
		
		//Symbol lparen_s(SymbolID::lparen_, SymbolType::terminal_);
		//TreeNode lparen_n(lparen_s);
		
		//To be able to translate correctly
		Symbol post_repeat_s(SymbolID::post_repeat_, SymbolType::terminal_);
		TreeNode post_repeat_n(post_repeat_s);
		
		//Symbol rparen_s(SymbolID::rparen_, SymbolType::terminal_);
		//TreeNode rparen_n(rparen_s);
		
		Symbol lcurly_s(SymbolID::lcurly_, SymbolType::terminal_);
		TreeNode lcurly_n(lcurly_s);
		
		Symbol rcurly_s(SymbolID::rcurly_, SymbolType::terminal_);
		TreeNode rcurly_n(rcurly_s);
		
		$$->addNode(repeat_n);
		//$$->addNode(lparen_n);
		$$->addNode(*$3);
		$$->addNode(post_repeat_n);
		//$$->addNode(rparen_n);
		$$->addNode(lcurly_n);
		$$->addNode(*$6);
		$$->addNode(rcurly_n);
		
		delete $3, $6;
	}
	  | definition SEMICOL
	{
	  	Symbol statement_s(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement_s);
		
		Symbol semicol_s(SymbolID::semicol_, SymbolType::terminal_);		
		TreeNode semicol_n(semicol_s);

		$$->addNode(*$1);
		$$->addNode(semicol_n);
		
		delete $1;
	}
	  | expression SEMICOL
	{
	  	Symbol statement_s(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement_s);
		
		Symbol semicol_s(SymbolID::semicol_, SymbolType::terminal_);		
		TreeNode semicol_n(semicol_s);

		$$->addNode(*$1);
		$$->addNode(semicol_n);
		
		delete $1;
	}
	  | assignment SEMICOL
	{
	  	Symbol statement_s(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement_s);
		
		Symbol semicol_s(SymbolID::semicol_, SymbolType::terminal_);		
		TreeNode semicol_n(semicol_s);

		$$->addNode(*$1);
		$$->addNode(semicol_n);
		
		delete $1;
	}
	  | PAUSE reint SEMICOL
	{
	  	Symbol statement_s(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement_s);
		
		Symbol pause_s(SymbolID::pause_, SymbolType::terminal_);
		TreeNode pause_n(pause_s);
		
		//To be able to translate correctly
		Symbol post_pause_s(SymbolID::post_pause_, SymbolType::terminal_);
		TreeNode post_pause_n(post_pause_s);
		
		Symbol semicol_s(SymbolID::semicol_, SymbolType::terminal_);		
		TreeNode semicol_n(semicol_s);
		
		$$->addNode(pause_n);
		$$->addNode(*$2);
		$$->addNode(post_pause_n);
		$$->addNode(semicol_n);
		
		delete $2;
	}
	  | OUTSTRING restring SEMICOL
	{
	  	Symbol statement_s(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement_s);
		
		Symbol outstring_s(SymbolID::outstring_, SymbolType::terminal_);
		TreeNode outstring_n(outstring_s);
		
		Symbol semicol_s(SymbolID::semicol_, SymbolType::terminal_);		
		TreeNode semicol_n(semicol_s);
		
		$$->addNode(outstring_n);
		$$->addNode(*$2);
		$$->addNode(semicol_n);
		
		delete $2;
	}
	  | OUTINT reint SEMICOL
	{
	  	Symbol statement_s(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement_s);
		
		Symbol outint_s(SymbolID::outint_, SymbolType::terminal_);
		TreeNode outint_n(outint_s);
		
		Symbol semicol_s(SymbolID::semicol_, SymbolType::terminal_);		
		TreeNode semicol_n(semicol_s);
		
		$$->addNode(outint_n);
		$$->addNode(*$2);
		$$->addNode(semicol_n);
		
		delete $2;
	}
	  | LCLICK SEMICOL
	{
		Symbol statement(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement);
	
		Symbol lclick_s(SymbolID::lclick_, SymbolType::terminal_);
		Symbol semicol_s(SymbolID::semicol_, SymbolType::terminal_);
		
		TreeNode lclick_n = TreeNode(lclick_s);
		TreeNode semicol_n = TreeNode(semicol_s);
		
		$$->addNode(lclick_n);
		$$->addNode(semicol_n);
	}
	  | RCLICK SEMICOL
	{
	  	Symbol statement_s(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement_s);
		
		Symbol rclick_s(SymbolID::rclick_, SymbolType::terminal_);
		TreeNode rclick_n(rclick_s);
		
		Symbol semicol_s(SymbolID::semicol_, SymbolType::terminal_);		
		TreeNode semicol_n(semicol_s);
		
		$$->addNode(rclick_n);
		$$->addNode(semicol_n);
	}
	  | LRELEASE SEMICOL
	{
	  	Symbol statement_s(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement_s);
		
		Symbol lrelease_s(SymbolID::lrelease_, SymbolType::terminal_);
		TreeNode lrelease_n(lrelease_s);
		
		Symbol semicol_s(SymbolID::semicol_, SymbolType::terminal_);		
		TreeNode semicol_n(semicol_s);
		
		$$->addNode(lrelease_n);
		$$->addNode(semicol_n);
	}
	  | RRELEASE SEMICOL
	{
	  	Symbol statement_s(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement_s);
		
		Symbol rrelease_s(SymbolID::rrelease_, SymbolType::terminal_);
		TreeNode rrelease_n(rrelease_s);
		
		Symbol semicol_s(SymbolID::semicol_, SymbolType::terminal_);		
		TreeNode semicol_n(semicol_s);
		
		$$->addNode(rrelease_n);
		$$->addNode(semicol_n);
	}
	  | UP reint SEMICOL
	{
	  	Symbol statement_s(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement_s);
		
		Symbol up_s(SymbolID::up_, SymbolType::terminal_);
		TreeNode up_n(up_s);
		
		//To be able to translate correctly
		Symbol post_up_s(SymbolID::post_up_, SymbolType::terminal_);
		TreeNode post_up_n(post_up_s);
		
		Symbol semicol_s(SymbolID::semicol_, SymbolType::terminal_);		
		TreeNode semicol_n(semicol_s);
		
		$$->addNode(up_n);
		$$->addNode(*$2);
		$$->addNode(post_up_n);
		$$->addNode(semicol_n);
		
		delete $2;
	}
	  | DOWN reint SEMICOL
	{
	  	Symbol statement_s(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement_s);
		
		Symbol down_s(SymbolID::down_, SymbolType::terminal_);
		TreeNode down_n(down_s);
		
		//To be able to translate correctly
		Symbol post_down_s(SymbolID::post_down_, SymbolType::terminal_);
		TreeNode post_down_n(post_down_s);
		
		Symbol semicol_s(SymbolID::semicol_, SymbolType::terminal_);		
		TreeNode semicol_n(semicol_s);
		
		$$->addNode(down_n);
		$$->addNode(*$2);
		$$->addNode(post_down_n);
		$$->addNode(semicol_n);
		
		delete $2;
	}
	  | LEFT reint SEMICOL
	{
	  	Symbol statement_s(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement_s);
		
		Symbol left_s(SymbolID::left_, SymbolType::terminal_);
		TreeNode left_n(left_s);
		
		//To be able to translate correctly
		Symbol post_left_s(SymbolID::post_left_, SymbolType::terminal_);
		TreeNode post_left_n(post_left_s);
		
		Symbol semicol_s(SymbolID::semicol_, SymbolType::terminal_);		
		TreeNode semicol_n(semicol_s);
		
		$$->addNode(left_n);
		$$->addNode(*$2);
		$$->addNode(post_left_n);
		$$->addNode(semicol_n);
		
		delete $2;
	}
	  | RIGHT reint SEMICOL
	{
	  	Symbol statement_s(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement_s);
		
		Symbol right_s(SymbolID::right_, SymbolType::terminal_);
		TreeNode right_n(right_s);
		
		//To be able to translate correctly
		Symbol post_right_s(SymbolID::post_right_, SymbolType::terminal_);
		TreeNode post_right_n(post_right_s);
		
		Symbol semicol_s(SymbolID::semicol_, SymbolType::terminal_);		
		TreeNode semicol_n(semicol_s);
		
		$$->addNode(right_n);
		$$->addNode(*$2);
		$$->addNode(post_right_n);
		$$->addNode(semicol_n);
		
		delete $2;
	}
	  | PRESSKEY restring SEMICOL
	{
	  	Symbol statement_s(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement_s);
		
		Symbol presskey_s(SymbolID::presskey_, SymbolType::terminal_);
		TreeNode presskey_n(presskey_s);
		
		//To be able to translate correctly
		Symbol post_presskey_s(SymbolID::post_presskey_, SymbolType::terminal_);
		TreeNode post_presskey_n(post_presskey_s);
		
		Symbol semicol_s(SymbolID::semicol_, SymbolType::terminal_);		
		TreeNode semicol_n(semicol_s);
		
		$$->addNode(presskey_n);
		$$->addNode(*$2);
		$$->addNode(post_presskey_n);
		$$->addNode(semicol_n);
		
		delete $2;
	}
	  | RELEASEKEY restring SEMICOL
	{
	  	Symbol statement_s(SymbolID::statement_, SymbolType::non_terminal_);
		$$ = new TreeNode(statement_s);
		
		Symbol releasekey_s(SymbolID::releasekey_, SymbolType::terminal_);
		TreeNode releasekey_n(releasekey_s);
		
		//To be able to translate correctly
		Symbol post_releasekey_s(SymbolID::post_releasekey_, SymbolType::terminal_);
		TreeNode post_releasekey_n(post_releasekey_s);
		
		Symbol semicol_s(SymbolID::semicol_, SymbolType::terminal_);		
		TreeNode semicol_n(semicol_s);
		
		$$->addNode(releasekey_n);
		$$->addNode(*$2);
		$$->addNode(post_releasekey_n);
		$$->addNode(semicol_n);
		
		delete $2;
	}
	  
	  ;
	  
definition : type ID
	{
		Symbol definition_s(SymbolID::definition_, SymbolType::non_terminal_);
		$$ = new TreeNode(definition_s);
		
		Symbol id_s(SymbolID::id_, SymbolType::terminal_, *$2);
		TreeNode id_n(id_s);
		
		$$->addNode(*$1);
		$$->addNode(id_n);
		
		delete $1, $2;
	}
	   | type assignment
	{
		Symbol definition_s(SymbolID::definition_, SymbolType::non_terminal_);
		$$ = new TreeNode(definition_s);
		
		$$->addNode(*$1);
		$$->addNode(*$2);
		
		delete $1, $2;
	}
	   ;

assignment : ID EQASS reint
	{
		Symbol assignment_s(SymbolID::assignment_, SymbolType::non_terminal_);
		$$ = new TreeNode(assignment_s);
		
		Symbol id_s(SymbolID::id_, SymbolType::terminal_, *$1);
		TreeNode id_n(id_s);
		
		Symbol eqass_s(SymbolID::eqass_, SymbolType::terminal_);
		TreeNode eqass_n(eqass_s);
		
		$$->addNode(id_n);
		$$->addNode(eqass_n);
		$$->addNode(*$3);
		
		delete $1, $3;
	}
	   | ID EQASS fuint
	{
		Symbol assignment_s(SymbolID::assignment_, SymbolType::non_terminal_);
		$$ = new TreeNode(assignment_s);
		
		Symbol id_s(SymbolID::id_, SymbolType::terminal_, *$1);
		TreeNode id_n(id_s);
		
		Symbol eqass_s(SymbolID::eqass_, SymbolType::terminal_);
		TreeNode eqass_n(eqass_s);
		
		$$->addNode(id_n);
		$$->addNode(eqass_n);
		$$->addNode(*$3);
		
		delete $1, $3;
	}
	   | ID EQASS restring
	{
		Symbol assignment_s(SymbolID::assignment_, SymbolType::non_terminal_);
		$$ = new TreeNode(assignment_s);
		
		Symbol id_s(SymbolID::id_, SymbolType::terminal_, *$1);
		TreeNode id_n(id_s);
		
		Symbol eqass_s(SymbolID::eqass_, SymbolType::terminal_);
		TreeNode eqass_n(eqass_s);
		
		$$->addNode(id_n);
		$$->addNode(eqass_n);
		$$->addNode(*$3);
		
		delete $1, $3;
	}
	   | ID EQASS fustring
	{
		Symbol assignment_s(SymbolID::assignment_, SymbolType::non_terminal_);
		$$ = new TreeNode(assignment_s);
		
		Symbol id_s(SymbolID::id_, SymbolType::terminal_, *$1);
		TreeNode id_n(id_s);
		
		Symbol eqass_s(SymbolID::eqass_, SymbolType::terminal_);
		TreeNode eqass_n(eqass_s);
		
		$$->addNode(id_n);
		$$->addNode(eqass_n);
		$$->addNode(*$3);
		
		delete $1, $3;
	}
	   ;
	   
type : INT_T
	{
		Symbol type_s(SymbolID::type_, SymbolType::non_terminal_);
		$$ = new TreeNode(type_s);
		
		Symbol int_t_s(SymbolID::int_t_, SymbolType::terminal_);
		TreeNode int_t_n(int_t_s);
		
		$$->addNode(int_t_n);
	}
     | STRING_T
	{
		Symbol type_s(SymbolID::type_, SymbolType::non_terminal_);
		$$ = new TreeNode(type_s);
		
		Symbol string_t_s(SymbolID::string_t_, SymbolType::terminal_);
		TreeNode string_t_n(string_t_s);
		
		$$->addNode(string_t_n);
	}
     ;
     
expression : conjunction
	{
		Symbol expression_s(SymbolID::expression_, SymbolType::non_terminal_);
		$$ = new TreeNode(expression_s);
		
		$$->addNode(*$1);
		
		delete $1;
	}
	   | expression OR conjunction
	{
		Symbol expression_s(SymbolID::expression_, SymbolType::non_terminal_);
		$$ = new TreeNode(expression_s);
		
		Symbol or_s(SymbolID::or_, SymbolType::terminal_);
		TreeNode or_n(or_s);
		
		$$->addNode(*$1);
		$$->addNode(or_n);
		$$->addNode(*$3);
		
		delete $1, $3;
	}
	   ;
	   
conjunction : equality 
	{
		Symbol conjunction_s(SymbolID::conjunction_, SymbolType::non_terminal_);
		$$ = new TreeNode(conjunction_s);
		
		$$->addNode(*$1);
		
		delete $1;
	}
	    | conjunction AND equality
	{
		Symbol conjunction_s(SymbolID::conjunction_, SymbolType::non_terminal_);
		$$ = new TreeNode(conjunction_s);
		
		Symbol and_s(SymbolID::and_, SymbolType::terminal_);
		TreeNode and_n(and_s);
		
		$$->addNode(*$1);
		$$->addNode(and_n);
		$$->addNode(*$3);
		
		delete $1, $3;
	}
	    ;
	   
equality : relation
	{
		Symbol equality_s(SymbolID::equality_, SymbolType::non_terminal_);
		$$ = new TreeNode(equality_s);
		
		$$->addNode(*$1);
		
		delete $1;
	}
	 | relation equop relation
	{
		Symbol equality_s(SymbolID::equality_, SymbolType::non_terminal_);
		$$ = new TreeNode(equality_s);
		
		$$->addNode(*$1);
		$$->addNode(*$2);
		$$->addNode(*$3);
		
		delete $1, $2, $3;
	}
	 ;
	 
equop : EQCOMP
	{
		Symbol equop_s(SymbolID::equop_, SymbolType::non_terminal_);
		$$ = new TreeNode(equop_s);
		
		Symbol eqcomp_s(SymbolID::eqcomp_, SymbolType::terminal_);
		TreeNode eqcomp_n(eqcomp_s);
		
		$$->addNode(eqcomp_n);
	}
      | NE
	{
		Symbol equop_s(SymbolID::equop_, SymbolType::non_terminal_);
		$$ = new TreeNode(equop_s);
		
		Symbol ne_s(SymbolID::ne_, SymbolType::terminal_);
		TreeNode ne_n(ne_s);
		
		$$->addNode(ne_n);
	}
      ;
      
relation : addition
	{
		Symbol relation_s(SymbolID::relation_, SymbolType::non_terminal_);
		$$ = new TreeNode(relation_s);
		
		$$->addNode(*$1);
		
		delete $1;
	}
	 | addition relop addition
	{
		Symbol relation_s(SymbolID::relation_, SymbolType::non_terminal_);
		$$ = new TreeNode(relation_s);
		
		$$->addNode(*$1);
		$$->addNode(*$2);
		$$->addNode(*$3);
		
		delete $1, $2, $3;
	}
	 ;
	 
relop : LT
	{
		Symbol relop_s(SymbolID::relop_, SymbolType::non_terminal_);
		$$ = new TreeNode(relop_s);
		
		Symbol lt_s(SymbolID::lt_, SymbolType::terminal_);
		TreeNode lt_n(lt_s);
		
		$$->addNode(lt_n);
	}
      | LE
	{
		Symbol relop_s(SymbolID::relop_, SymbolType::non_terminal_);
		$$ = new TreeNode(relop_s);
		
		Symbol le_s(SymbolID::le_, SymbolType::terminal_);
		TreeNode le_n(le_s);
		
		$$->addNode(le_n);
	}
      | GT
	{
		Symbol relop_s(SymbolID::relop_, SymbolType::non_terminal_);
		$$ = new TreeNode(relop_s);
		
		Symbol gt_s(SymbolID::gt_, SymbolType::terminal_);
		TreeNode gt_n(gt_s);
		
		$$->addNode(gt_n);
	}
      | GE
	{
		Symbol relop_s(SymbolID::relop_, SymbolType::non_terminal_);
		$$ = new TreeNode(relop_s);
		
		Symbol ge_s(SymbolID::ge_, SymbolType::terminal_);
		TreeNode ge_n(ge_s);
		
		$$->addNode(ge_n);
	}
      ;
      
addition : term
	{
		Symbol addition_s(SymbolID::addition_, SymbolType::non_terminal_);
		$$ = new TreeNode(addition_s);
		
		$$->addNode(*$1);
		
		delete $1;
	}
	 | addition addop term
	{
		Symbol addition_s(SymbolID::addition_, SymbolType::non_terminal_);
		$$ = new TreeNode(addition_s);
		
		$$->addNode(*$1);
		$$->addNode(*$2);
		$$->addNode(*$3);
		
		delete $1, $2, $3;
	}
	 ;
	 
addop : ADD
	{
		Symbol addop_s(SymbolID::addop_, SymbolType::non_terminal_);
		$$ = new TreeNode(addop_s);
		
		Symbol add_s(SymbolID::add_, SymbolType::terminal_);
		TreeNode add_n(add_s);
		
		$$->addNode(add_n);
	}
      | SUB
	{
		Symbol addop_s(SymbolID::addop_, SymbolType::non_terminal_);
		$$ = new TreeNode(addop_s);
		
		Symbol sub_s(SymbolID::sub_, SymbolType::terminal_);
		TreeNode sub_n(sub_s);
		
		$$->addNode(sub_n);
	}
      ;
  
term : factor
	{
		Symbol term_s(SymbolID::term_, SymbolType::non_terminal_);
		$$ = new TreeNode(term_s);
		
		$$->addNode(*$1);
		
		delete $1;
	}
     | term mulop factor
	{
		Symbol term_s(SymbolID::term_, SymbolType::non_terminal_);
		$$ = new TreeNode(term_s);
		
		$$->addNode(*$1);
		$$->addNode(*$2);
		$$->addNode(*$3);
		
		delete $1, $2, $3;
	}
     ;
      
mulop : MUL
	{
		Symbol mulop_s(SymbolID::mulop_, SymbolType::non_terminal_);
		$$ = new TreeNode(mulop_s);
		
		Symbol mul_s(SymbolID::mul_, SymbolType::terminal_);
		TreeNode mul_n(mul_s);
		
		$$->addNode(mul_n);
	}
      | DIV
	{
		Symbol mulop_s(SymbolID::mulop_, SymbolType::non_terminal_);
		$$ = new TreeNode(mulop_s);
		
		Symbol div_s(SymbolID::div_, SymbolType::terminal_);
		TreeNode div_n(div_s);
		
		$$->addNode(div_n);
	}
      | MOD
	{
		Symbol mulop_s(SymbolID::mulop_, SymbolType::non_terminal_);
		$$ = new TreeNode(mulop_s);
		
		Symbol mod_s(SymbolID::mod_, SymbolType::terminal_);
		TreeNode mod_n(mod_s);
		
		$$->addNode(mod_n);
	}
      ;
      
factor : unaryop primary
	{
		Symbol factor_s(SymbolID::factor_, SymbolType::non_terminal_);
		$$ = new TreeNode(factor_s);
		
		$$->addNode(*$1);
		$$->addNode(*$2);
		
		delete $1, $2;
	}
       | primary
	{
		Symbol factor_s(SymbolID::factor_, SymbolType::non_terminal_);
		$$ = new TreeNode(factor_s);
		
		$$->addNode(*$1);
		
		delete $1;
	}
       ;
       
unaryop : SUB
	{
		Symbol unaryop_s(SymbolID::unaryop_, SymbolType::non_terminal_);
		$$ = new TreeNode(unaryop_s);
		
		Symbol sub_s(SymbolID::sub_, SymbolType::terminal_);
		TreeNode sub_n(sub_s);
		
		$$->addNode(sub_n);
	}
        | OPP
	{
		Symbol unaryop_s(SymbolID::unaryop_, SymbolType::non_terminal_);
		$$ = new TreeNode(unaryop_s);
		
		Symbol opp_s(SymbolID::opp_, SymbolType::terminal_);
		TreeNode opp_n(opp_s);
		
		$$->addNode(opp_n);
	}
        ;

primary : ID
	{
		Symbol primary_s(SymbolID::primary_, SymbolType::non_terminal_);
		$$ = new TreeNode(primary_s);
		
		Symbol id_s(SymbolID::id_, SymbolType::terminal_, *$1);
		TreeNode id_n(id_s);
		
		$$->addNode(id_n);
		
		delete $1;
	}
        | INT
	{
		Symbol primary_s(SymbolID::primary_, SymbolType::non_terminal_);
		$$ = new TreeNode(primary_s);
		
		Symbol int_s(SymbolID::int_, SymbolType::terminal_, std::to_string($1));
		TreeNode int_n(int_s);
		
		$$->addNode(int_n);
	}
        | LPAREN expression RPAREN
	{
		Symbol primary_s(SymbolID::primary_, SymbolType::non_terminal_);
		$$ = new TreeNode(primary_s);
		
		Symbol lparen_s(SymbolID::lparen_, SymbolType::terminal_);
		Symbol rparen_s(SymbolID::rparen_, SymbolType::terminal_);
		
		TreeNode lparen_n(lparen_s);
		TreeNode rparen_n(rparen_s);
		
		$$->addNode(lparen_n);
		$$->addNode(*$2);
		$$->addNode(rparen_n);
		
		delete $2;
	}
        ;
        
fuint : ININT
	{
		Symbol fuint_s(SymbolID::fuint_, SymbolType::non_terminal_);
		$$ = new TreeNode(fuint_s);
		
		Symbol inint_s(SymbolID::inint_, SymbolType::terminal_);
		TreeNode inint_n(inint_s);
		
		$$->addNode(inint_n);
	}
      | MOUSEPOSX
	{
		Symbol fuint_s(SymbolID::fuint_, SymbolType::non_terminal_);
		$$ = new TreeNode(fuint_s);
		
		Symbol mouseposx_s(SymbolID::mouseposx_, SymbolType::terminal_);
		TreeNode mouseposx_n(mouseposx_s);
		
		//To be able to translate correctly
		Symbol post_mouseposx_s(SymbolID::post_mouseposx_, SymbolType::terminal_);
		TreeNode post_mouseposx_n(post_mouseposx_s);
		
		$$->addNode(mouseposx_n);
		$$->addNode(post_mouseposx_n);
	}
      | MOUSEPOSY
	{
		Symbol fuint_s(SymbolID::fuint_, SymbolType::non_terminal_);
		$$ = new TreeNode(fuint_s);
		
		Symbol mouseposy_s(SymbolID::mouseposy_, SymbolType::terminal_);
		TreeNode mouseposy_n(mouseposy_s);
		
		//To be able to translate correctly
		Symbol post_mouseposy_s(SymbolID::post_mouseposy_, SymbolType::terminal_);
		TreeNode post_mouseposy_n(post_mouseposy_s);
		
		$$->addNode(mouseposy_n);
		$$->addNode(post_mouseposy_n);
	}
      ;
      
fustring : INSTRING
	{
		Symbol fustring_s(SymbolID::fustring_, SymbolType::non_terminal_);
		$$ = new TreeNode(fustring_s);
		
		Symbol instring_s(SymbolID::instring_, SymbolType::terminal_);
		TreeNode instring_n(instring_s);
		
		$$->addNode(instring_n);
	}
         ;
         
reint : expression
	{
		Symbol reint_s(SymbolID::reint_, SymbolType::non_terminal_);
		$$ = new TreeNode(reint_s);
		
		$$->addNode(*$1);
		
		delete $1;
	}
       ;
       
restring : STRING
	{
		Symbol restring(SymbolID::restring_, SymbolType::non_terminal_);
		$$ = new TreeNode(restring);
		
		Symbol string_s(SymbolID::string_, SymbolType::terminal_, *$1);
		TreeNode string_n(string_s);
		
		$$->addNode(string_n);
		
		delete $1;
	}
	 | ID
	{
		Symbol restring(SymbolID::restring_, SymbolType::non_terminal_);
		$$ = new TreeNode(restring);
		
		Symbol id(SymbolID::id_, SymbolType::terminal_, *$1);
		TreeNode id_n(id);
		
		$$->addNode(id_n);
		
		delete $1;
	}
	 ;

%%

// Supporting routines

extern int yylex();
extern int yyparse();

int main(int argc, char *argv[])
{
	if (argc == 2)
	{
		yyin = fopen(argv[1], "r+");
		if (yyin == NULL)
		{
 			printf("%s couldn't be openend or wasn't found.\n", argv[1]);
			return -1;
		}
	}
	else
	{
		std::cout << "Error: expected 1 argument (the file to compile)." << std::endl;
		return -1;
	}

	yyparse();
	
	std::vector<Symbol> terminals_vector;
	terminals_vector = root->DFSPreOrder();
	
	//std::cout << "Parsed tree terminals:" << std::endl;
  	//for (std::vector<Symbol>::iterator it = terminals_vector.begin() ; it != terminals_vector.end(); it++)
    	//	std::cout << ' ' << (int) it->symbol_ID;
  	//std::cout << '\n';
  	
  	print_code(terminals_vector, std::string("intermediate_code.cpp"));
  	
  	system("g++ -std=c++11 intermediate_code.cpp -o a.out");
  	system("rm intermediate_code.cpp");
  	
  	delete root;
  	
}
