%{
#include <stdio.h>
%}

%%
[0-9]+\.[0-9]+    { printf("Floating point number: %s\n", yytext); }
[0-9]+            {printf("integer number: %s\n",yytext);}
.|\n              { /* Ignore other characters */ }
%%

int main() {
    printf("Enter input: ");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}