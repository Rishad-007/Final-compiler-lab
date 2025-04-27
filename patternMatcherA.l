%{
#include <stdio.h>
%}

%%
[A-Z][a-z]+[ \t][a-z0-9]+    { printf("Matched pattern a: '%s'\n", yytext); }
.|\n                          { /* Ignore other characters */ }
%%

int main() {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}