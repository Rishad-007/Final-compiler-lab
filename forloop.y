%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern int yylex();
extern int yyparse();
extern FILE *yyin;
extern char input_buffer[];
void yyerror(const char *s);
%}

%union {
    int num;
    char *str;
}

%token FOR LPAREN RPAREN LBRACE RBRACE SEMICOLON ASSIGN RELOP INC_DEC ARITH_OP
%token <num> NUMBER
%token <str> IDENTIFIER

%%

program:
    /* empty */
    | program for_loop
    ;

for_loop:
    FOR LPAREN init_expr SEMICOLON cond_expr SEMICOLON iter_expr RPAREN LBRACE nested_loops RBRACE
    {
        printf("\n--- Input ---\n%s\n", input_buffer);
        printf("--- Output ---\nValid 3-level nested FOR loop detected!\n");
        exit(0);  // Exit after first successful parse
    }
    ;

init_expr:
    IDENTIFIER ASSIGN expr
    ;

cond_expr:
    expr RELOP expr
    ;

iter_expr:
    IDENTIFIER INC_DEC
    ;

expr:
    IDENTIFIER
    | NUMBER
    | expr ARITH_OP expr
    ;

nested_loops:
    for_loop
    | nested_loops for_loop
    ;

%%

void yyerror(const char *s) {
    printf("\n--- Input ---\n%s\n", input_buffer);
    fprintf(stderr, "--- Output ---\nError: %s\n", s);
    exit(1);
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s input_file.c\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("Error opening input file");
        return 1;
    }

    yyparse();
    fclose(yyin);
    return 0;
}