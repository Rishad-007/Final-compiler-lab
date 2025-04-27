%{
#include <stdio.h>
%}

%%
88015[0-9]{8}   { printf("Valid Teletalk number: %s\n", yytext); }
015[0-9]{8}     { printf("Valid Teletalk number: %s\n", yytext); }
[0-9]+          { printf("Invalid number: %s\n", yytext); }
.|\n            { /* Ignore other characters */ }
%%

int main() {
    printf("Enter a phone number: ");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}