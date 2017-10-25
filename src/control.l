%{
#include <stdio.h>
#include <string.h>

#include "control.h"

%}
%%
[a-zA-Z] ECHO;

%%

int yywrap(void) {
	return 1;
}


int main(void) {
	yylex();
	return 0;
}
