%{
#include <stdio.h>
%}

%%
([A-Za-z0-9_]*at[s]?[ \t])+    { printf("Matched pattern c: '%s'\n", yytext); }
.|\n                           { /* Ignore other characters */ }
%%

int main() {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}