%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(char *);
%}

%token NUMBER

%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

%%

input:    /* empty */
        | input line
;

line:     '\n'
        | exp '\n'  { printf("Result: %d\n", $1); }
;

exp:      NUMBER                { $$ = $1; }
        | exp '+' exp           { $$ = $1 + $3; }
        | exp '-' exp           { $$ = $1 - $3; }
        | exp '*' exp           { $$ = $1 * $3; }
        | exp '/' exp           { $$ = $1 / $3; }
        | '(' exp ')'           { $$ = $2; }
        | '-' exp %prec UMINUS  { $$ = -$2; }
;

%%

void yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("Simple Calculator\n");
    printf("Enter expressions or press Ctrl-D to exit\n");
    yyparse();
    return 0;
}

/* 
to run this code:
yacc -d yacc.y
lex lex.l
cc lex.yy.c y.tab.c -o calculator -ll
./calculator 
*/
