%{
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>  /* Added for exit() */
int yylex(void);
void yyerror(const char *s);
%}

%token LETTER DIGIT

%%

variable : LETTER rest_of_var '\n'   { printf("Valid variable!\n"); exit(0); }
         ;

rest_of_var : /* empty */
            | rest_of_var LETTER
            | rest_of_var DIGIT
            ;

%%

#include <ctype.h>

int yylex(void) {
    int c = getchar();
    
    if (isalpha(c)) {
        return LETTER;
    } else if (isdigit(c)) {
        return DIGIT;
    } else if (c == '\n') {
        return '\n';
    } else if (c == EOF) {
        return 0;
    }
    return c;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: Invalid variable name\n");
}

int main() {
    printf("Enter a variable name: ");
    return yyparse();
}

// To compile and run this code:
//yacc validvariable.y
//cc y.tab.c -o validvariable -ll
//./validvariable
// Enter a variable name: a1
// Valid variable!
// Enter a variable name: 1a
// Error: Invalid variable name