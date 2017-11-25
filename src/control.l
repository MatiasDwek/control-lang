%{
#include <stdio.h>
#include <cstring>

#include "symbol.hpp"
//#include "y.tab.h"

%}
/* Regular definitions */

delim	[ \t\n]
ws	{delim}+
letter	[a-zA-Z]
digit	[0-9]
word	{letter}({letter}|{digit})*
number	[-+]?{digit}+

%%
{ws}	{/* no action and no return */}
#.*	{/* comments, no action and no return */}
"if"	{return (int) SymbolID::IF;}
"else"	{return (int) SymbolID::ELSE;}
"while"	{return (int) SymbolID::WHILE;}
"pause" {return (int) SymbolID::PAUSE;}
"repeat"	{return (int) SymbolID::REPEAT;}
"outstring"	{return (int) SymbolID::OUTSTRING;}
"outint"	{return (int) SymbolID::OUTINT;}
"lclick"	{return (int) SymbolID::LCLICK;}
"rclick"	{return (int) SymbolID::RCLICK;}
"lrelease"	{return (int) SymbolID::LRELEASE;} 
"rrelease"	{return (int) SymbolID::RRLEASE;} 
"up"	{return (int) SymbolID::UP;} 
"down"	{return (int) SymbolID::DOWN;}
"left"	{return (int) SymbolID::LEFT;} 
"right"	{return (int) SymbolID::RIGHT;} 
"presskey"	{return (int) SymbolID::PRESSKEY;}
"releasekey"	{return (int) SymbolID::RELEASEKEY;}
\{	{return (int) SymbolID::LCURLY;}
\}	{return (int) SymbolID::RCURLY;}
\(	{return (int) SymbolID::LPAREN;}
\)	{return (int) SymbolID::RPAREN;}
\;	{return (int) SymbolID::SEMICOL;}
=	{return (int) SymbolID::EQASS;}
"or"	{return (int) SymbolID::OR;}
"and"	{return (int) SymbolID::AND;}
"=="	{return (int) SymbolID::EQCOMP;}
"!="	{return (int) SymbolID::NE;}
"<"	{return (int) SymbolID::LT;}
"<="	{return (int) SymbolID::LE;}
">"	{return (int) SymbolID::GT;}
">="	{return (int) SymbolID::GE;}
"+"	{return (int) SymbolID::ADD;}
"-"	{return (int) SymbolID::SUB;}
"*"	{return (int) SymbolID::MUL;}
"/"	{return (int) SymbolID::DIV;}
"%"	{return (int) SymbolID::MOD;}
"!"	{return (int) SymbolID::OPP;}
"inint"	{return (int) SymbolID::ININT;}
"mouseposx"	{return (int) SymbolID::MOUSEPOSX;}
"mouseposy"	{return (int) SymbolID::MOUSEPOSY;}
"instring"	{return (int) SymbolID::INSTRING;}
"string"	{return (int) SymbolID::STRING_T;}
"int"	{return (int) SymbolID::INT_T;}

\".*\"	{return (int) SymbolID::STRING;}
{number}	{return (int) SymbolID::INT;}

{word}	{return (int) SymbolID::ID;}
	
%%

int yywrap(void) {
	return 1;
}


int main(void) {
	yylex();
	return 0;
}
