%{
#include <stdio.h>
%}

%%
is|am|are|was|were|be|being|been { 
    printf("To be verb found: %s\n", yytext); 
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