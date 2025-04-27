%{
#include "y.tab.h"
int yywrap() { return 1; }
%}

%%
a { return A; }
b { return B; }
c { return C; }
\n { return 0; }
. { printf("Invalid character: %s\n", yytext); exit(1); }
%%