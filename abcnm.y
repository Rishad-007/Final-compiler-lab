%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%token A B C

%%
S : A_seq B_seq C_seq { 
        if ($2 != $1 + $3) {
            yyerror("Invalid string: b's count must equal a's + c's count");
            YYABORT;
        }
        printf("Valid string\n"); 
    }
  ;

A_seq : /* empty */ { $$ = 0; }
      | A A_seq { $$ = $2 + 1; }
      ;

B_seq : /* empty */ { $$ = 0; }
      | B B_seq { $$ = $2 + 1; }
      ;

C_seq : /* empty */ { $$ = 0; }
      | C C_seq { $$ = $2 + 1; }
      ;

%%
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter a string: ");
    if (yyparse() == 0) {
        printf("Parsing completed successfully.\n");
    } else {
        printf("Parsing failed.\n");
    }
    return 0;
}