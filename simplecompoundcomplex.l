%{
#include <stdio.h>
int compound_flag = 0;
int complex_flag = 0;
%}

%%
(and|but|or|so)            { compound_flag = 1; }
(because|although|when|if) { complex_flag = 1; }
.|\n                       ;   // Ignore other characters
%%



int main() {
    printf("Enter a sentence:\n");
    yylex();
    
    if (complex_flag)
        printf("This is a COMPLEX sentence.\n");
    else if (compound_flag)
        printf("This is a COMPOUND sentence.\n");
    else
        printf("This is a SIMPLE sentence.\n");
    
    return 0;
}
int yywrap() {
    return 1;
}
