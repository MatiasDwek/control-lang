%{
#include <stdio.h>
#include <string.h>

#include "control.h"
//#include "y.tab.h"

%}
/* Regular definitions */

delim	[ \t\n]
ws	{delim}+
letter	[a-zA-Z]
digit	[0-9]
id	{letter}({letter}|{digit})*
number	[-+]?{digit}+

%%
{ws}	{/*no action and no return */}
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
"rrelease"	{return RRLEASE;} 
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



{id}	{return ID;}

#.*	//comments
	
%%
/*EQASS, OR, AND, EQCOMP, NE, LT, LE, GT, GE, ADD, SUB,
		MUL, DIV, MOD, NEG, OPP, INTT, ININT, MOUSEPOSX, MOUSEPOSY,
		INSTRING, STRINGT*/

int yywrap(void) {
	return 1;
}


int main(void) {
	yylex();
	return 0;
}
