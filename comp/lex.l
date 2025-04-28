%{
#include <stdlib.h>
#include <string.h>
#include "ast.h"
#include "parser.tab.h"  // Include the generated Bison header file

// Function prototype for yyerror
void yyerror(const char *s);
%}

%option noyywrap
%option yylineno
%option nounput
%option noinput

%%

"if"      { printf("TOKEN: IF\n"); return IF; }
"else"    { printf("TOKEN: ELSE\n"); return ELSE; }
"while"   { printf("TOKEN: WHILE\n"); return WHILE; }
"for"     { printf("TOKEN: FOR\n"); return FOR; }
"int"     { printf("TOKEN: INT\n"); return INT; }
"float"   { printf("TOKEN: FLOAT\n"); return FLOAT; }
"char"    { printf("TOKEN: CHAR_TYPE\n"); return CHAR_TYPE; }
"void"    { printf("TOKEN: VOID\n"); return VOID; }
"return"  { printf("TOKEN: RETURN\n"); return RETURN; }

"&&"      { printf("TOKEN: AND\n"); return AND; }
"||"      { printf("TOKEN: OR\n"); return OR; }
"!"       { printf("TOKEN: NOT\n"); return NOT; }
"<="      { printf("TOKEN: LE\n"); return LE; }
">="      { printf("TOKEN: GE\n"); return GE; }
">"       { printf("TOKEN: GT\n"); return GT; }
"<"       { printf("TOKEN: LT\n"); return LT; }
"!="      { printf("TOKEN: NE\n"); return NE; }
"=="      { printf("TOKEN: EQ\n"); return EQ; }
"++"      { printf("TOKEN: INC\n"); return INC; }
"--"      { printf("TOKEN: DEC\n"); return DEC; }
"+"       { printf("TOKEN: PLUS\n"); return '+'; }
"-"       { printf("TOKEN: MINUS\n"); return '-'; }
"*"       { printf("TOKEN: MULT\n"); return '*'; }
"/"       { printf("TOKEN: DIV\n"); return '/'; }
"%"       { printf("TOKEN: MOD\n"); return '%'; }
"="       { printf("TOKEN: ASSIGN\n"); return '='; }
"+="      { printf("TOKEN: PLUS_ASSIGN\n"); return PLUS_ASSIGN; }
"-="      { printf("TOKEN: MINUS_ASSIGN\n"); return MINUS_ASSIGN; }
"*="      { printf("TOKEN: MULT_ASSIGN\n"); return MULT_ASSIGN; }
"/="      { printf("TOKEN: DIV_ASSIGN\n"); return DIV_ASSIGN; }
"{"       { printf("TOKEN: LBRACE\n"); return '{'; }
"}"       { printf("TOKEN: RBRACE\n"); return '}'; }
"("       { printf("TOKEN: LPAREN\n"); return '('; }
")"       { printf("TOKEN: RPAREN\n"); return ')'; }
"["       { printf("TOKEN: LBRACK\n"); return '['; }
"]"       { printf("TOKEN: RBRACK\n"); return ']'; }
";"       { printf("TOKEN: SEMICOLON\n"); return ';'; }
","       { printf("TOKEN: COMMA\n"); return ','; }

[0-9]+\.[0-9]+ { 
    printf("TOKEN: FLOAT_VAL (%s)\n", yytext); 
    yylval.floatval = atof(yytext); 
    return FLOAT_VAL; 
}

[0-9]+    { 
    printf("TOKEN: INT_VAL (%s)\n", yytext); 
    yylval.intval = atoi(yytext); 
    return INT_VAL; 
}

\"[^\"]*\"  { 
    printf("TOKEN: STRING_VAL (%s)\n", yytext); 
    yylval.strval = strdup(yytext); 
    return STRING_VAL; 
}

\'[^\']\' { 
    printf("TOKEN: CHAR_VAL (%s)\n", yytext); 
    yylval.charval = yytext[1]; 
    return CHAR_VAL; 
}

[a-zA-Z_][a-zA-Z0-9_]* { 
    printf("TOKEN: ID (%s)\n", yytext); 
    yylval.strval = strdup(yytext); 
    return ID; 
}

[ \t\r]   ; /* Skip whitespaces */
\n        { yylineno++; } /* Track line numbers */
"$"       { printf("TOKEN: END\n"); return END; }
.         { 
    printf("TOKEN: CHAR (%s)\n", yytext); 
    yylval.charval = yytext[0]; 
    return yytext[0]; 
}

%%