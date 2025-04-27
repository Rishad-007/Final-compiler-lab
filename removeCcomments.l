%{
#include <stdio.h>
int comment_lines = 0;
int in_comment = 0;
int current_line = 1;
FILE *output_file;
%}

%%
"/*" { 
    if (!in_comment) {
        in_comment = 1; 
        comment_lines++;  // Count the start line of the comment
    }
}
"*/" { 
    if (in_comment) {
        in_comment = 0; 
    }
}
\n { 
    current_line++; 
    if (in_comment) comment_lines++; 
}
. { 
    if (!in_comment) {
        fprintf(output_file, "%s", yytext); 
    }
}
%%

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Usage: %s input_file.c output_file.c\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("Error opening input file");
        return 1;
    }

    output_file = fopen(argv[2], "w");
    if (!output_file) {
        perror("Error opening output file");
        fclose(yyin);
        return 1;
    }

    yylex();

    printf("Total comment lines: %d\n", comment_lines);

    fclose(yyin);
    fclose(output_file);
    return 0;
}

int yywrap() {
    return 1;
}

/* 
lex comment_remover.l                  # Generate lex.yy.c
gcc lex.yy.c -o comment_remover -ll    # Compile
./comment_remover input.c output.c     # Run
cat output.c                           # Verify output */