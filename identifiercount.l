%{
#include <stdio.h>
#include <ctype.h>

int identifier_count = 0;
%}

%%
[a-zA-Z_][a-zA-Z0-9_]* { 
    identifier_count++; 
    printf("Identifier found: %s\n", yytext); 
}
.|\n { /* Ignore other characters */ }
%%
int main() {
    printf("Enter input: ");
    yylex();
    printf("\nTotal number of identifiers: %d\n", identifier_count);
    return 0;
}

int yywrap() {
    return 1;
}