// Declarations
%{
#include <iostream>
#include <string>
#include <map>

extern int yylex();
static std::map<std::string, int> vars;

inline void yyerror(const char *s)
{
	std::cout << s << std::endl;
}
%}
 
%union{int i; std::string *s;}
 
%token<i> WHILE LPAREN RPAREN LCURLY RCURLY IF ELSE
    REPEAT SEMICOL PAUSE OUTSTRING OUTINT LCLICK
    RCLICK LRELEASE RRLEASE UP DOWN LEFT RIGHT
    PRESSKEY RELEASEKEY EQASS OR AND EQCOMP NE LT
    LE GT GE ADD SUB MUL DIV MOD OPP ININT MOUSEPOSX 
    MOUSEPOSY INSTRING STRING_T INT_T
    
%token<i> INT
%token<s> STRING
%token<s> ID

%type<i> statement
 
%%


// Translation rules

statement: LCURLY statement RCURLY {std::cout << $$ << $3 << std::endl;}
	 | LCURLY RCLICK {std::cout << $$ << std::endl;}
	 | LCLICK {std::cout << $1 << std::endl;}
	 | INT statement {$$ = $1;}
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
int main() { yyparse(); }
