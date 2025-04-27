%{
#include <stdlib.h>
#include "y.tab.h"
void yyerror(char *);
%}

%%

[0-9]+          { yylval = atoi(yytext); return NUMBER; }
[-+*/()\n]      { return yytext[0]; }
[ \t]           ; /* skip whitespace */
.               { yyerror("Invalid character"); }

%%

int yywrap(void) {
    return 1;
}