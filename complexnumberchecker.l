%{
#include <stdio.h>
%}

%%
[+-]?[0-9]+(\.[0-9]+)?[+-][0-9]+(\.[0-9]+)?i { 
    printf("Complex number found: %s\n", yytext); 
}
.|\n { 
    /* Ignore other characters */ 
}
%%

int main() {
    printf("Enter input (Ctrl+D to end):\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}