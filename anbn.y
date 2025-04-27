%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *s);
int yylex();
%}

%token A B

%%
S : A A A B   { printf("Valid string: aaab\n"); }
  | A B B B   { printf("Valid string: abbb\n"); }
  | A B       { printf("Valid string: ab\n"); }
  | A         { printf("Valid string: a\n"); }
  ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s - Not one of (aaab, abbb, ab, a)\n", s);
}

int main() {
    printf("Enter a string (aaab, abbb, ab, or a): ");
    yyparse();
    return 0;
}