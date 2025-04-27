%{
#include <stdio.h>
%}

DIGIT    [0-9]
INTEGER  -?{DIGIT}+

%%
{INTEGER}   { printf("Found INTEGER: %s\n", yytext); }
[ \t\n]     ;  // Ignore whitespace
.           { printf("Invalid token: %s\n", yytext); }
%%

int main() {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}