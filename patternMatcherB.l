%{
#include <stdio.h>
%}

%%
[A-Z][A-Za-z0-9_]*[ \t][A-Za-z0-9_]*[ \t][A-Za-z0-9_]*!    { printf("Matched pattern b: '%s'\n", yytext); }
.|\n                                                        { /* Ignore other characters */ }
%%

int main() {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}