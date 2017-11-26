%{
#include <stdio.h>
#include <cstring>
#include <cstdlib>
#include <string>

#include "treenode.hpp"
#include "y.tab.h"

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
"if"	{return IF;}
"else"	{return ELSE;}
"while"	{return WHILE;}
"pause" {return PAUSE;}
"repeat"	{return REPEAT;}
"outstring"	{return OUTSTRING;}
"outint"	{return OUTINT;}
"lclick"	{return LCLICK;}
"rclick"	{return RCLICK;}
"lrelease"	{return LRELEASE;} 
"rrelease"	{return RRELEASE;} 
"up"	{return UP;} 
"down"	{return DOWN;}
"left"	{return LEFT;} 
"right"	{return RIGHT;} 
"presskey"	{return PRESSKEY;}
"releasekey"	{return RELEASEKEY;}
\{	{return LCURLY;}
\}	{return RCURLY;}
\(	{return LPAREN;}
\)	{return RPAREN;}
\;	{return SEMICOL;}
=	{return EQASS;}
"or"	{return OR;}
"and"	{return AND;}
"=="	{return EQCOMP;}
"!="	{return NE;}
"<"	{return LT;}
"<="	{return LE;}
">"	{return GT;}
">="	{return GE;}
"+"	{return ADD;}
"-"	{return SUB;}
"*"	{return MUL;}
"/"	{return DIV;}
"%"	{return MOD;}
"!"	{return OPP;}
"inint"	{return ININT;}
"mouseposx"	{return MOUSEPOSX;}
"mouseposy"	{return MOUSEPOSY;}
"instring"	{return INSTRING;}
"string"	{return STRING_T;}
"int"	{return INT_T;}

\".*\"	{yylval.s = new std::string(yytext); return STRING;}
{number}	{yylval.i = strtol(yytext, NULL, 10); return INT;}

{word}	{yylval.s = new std::string(yytext); return ID;}
	
%%

int yywrap(void) {
	return 1;
}

/*
int main(void) {
	yylex();
	return 0;
}*/
