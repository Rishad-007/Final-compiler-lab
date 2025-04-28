%{
#include <stdio.h>
#include "y.tab.h"
void store_input();
%}

%%
"for"        { store_input(); return FOR; }
"("          { store_input(); return LPAREN; }
")"          { store_input(); return RPAREN; }
"{"          { store_input(); return LBRACE; }
"}"          { store_input(); return RBRACE; }
";"          { store_input(); return SEMICOLON; }
"="          { store_input(); return ASSIGN; }
"<"|">"|"<="|">="|"=="|"!=" { store_input(); return RELOP; }
"++"|"--"    { store_input(); return INC_DEC; }
"+"|"-"|"*"|"/" { store_input(); return ARITH_OP; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); store_input(); return IDENTIFIER; }
[0-9]+       { yylval.num = atoi(yytext); store_input(); return NUMBER; }
[ \t]        { store_input(); } /* skip whitespace but keep newlines */
\n           { store_input(); } /* keep track of newlines */
.            { store_input(); return yytext[0]; }
%%

char input_buffer[10000] = "";
int buffer_index = 0;

void store_input() {
    int i;
    for (i = 0; yytext[i] != '\0' && buffer_index < sizeof(input_buffer) - 1; i++) {
        input_buffer[buffer_index++] = yytext[i];
    }
}

int yywrap() {
    return 1;
}