%{
#include "y.tab.h"
extern void yyerror(const char *s);
%}

%%

[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[-+*/()]    { return yytext[0]; }
[ \t]       ; /* skip whitespace */
\n          { return '\n'; }
.           { yyerror("Invalid character"); return 0; }

%%

int yywrap() {
    return 1;
}