%{
#include <stdio.h> // Include the standard input/output library for printf function.
int yywrap() { return 1; } // Define yywrap function to indicate the end of input.
%}
%%
.|\n { printf("Hello, World!\n"); } // Match any character or newline and print "Hello, World!".
%%
int main() {
    yylex(); // Call the lexical analyzer to process input.
    return 0; // Return 0 to indicate successful program execution.
}
