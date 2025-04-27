%{
#include <stdio.h>

int char_count = 0;
int word_count = 0;
int space_count = 0;
int line_count = 0;
%}

%%
[a-zA-Z0-9]+ { 
    word_count++; 
    char_count += yyleng; 
}
[ \t]+ { 
    space_count += yyleng; 
    char_count += yyleng; 
}
\n { 
    line_count++; 
    char_count++; 
}
. { 
    char_count++; 
}
%%

int main() {
    printf("Enter input (Ctrl+D to end):\n");
    yylex();
    printf("\nCharacter count: %d\n", char_count);
    printf("Word count: %d\n", word_count);
    printf("Space count: %d\n", space_count);
    printf("Line count: %d\n", line_count);
    return 0;
}

int yywrap() {
    return 1;
}