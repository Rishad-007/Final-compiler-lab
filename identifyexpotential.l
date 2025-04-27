%{
#include <stdio.h>
%}
// This section is for C code that will be included in the generated C file.
// Here, we include the standard I/O library for input and output operations.

%%
[0-9]+(\.[0-9]+)?[eE][+-]?[0-9]+ { 
    printf("Exponential number found: %s\n", yytext); 
}
// This pattern matches exponential numbers (e.g., 1.23e+10, 4e-5).
// If a match is found, it prints the matched exponential number using `yytext`.

.|\n { 
    /* Ignore other characters */ 
}
// This pattern matches any single character (.) or a newline (\n).
// It is used to ignore all other characters that do not match the exponential number pattern.

%%
// This marks the end of the rules section.

int main() {
    printf("Enter input (Ctrl+D to end):\n");
    yylex();
    return 0;
}
// The main function starts the lexical analysis process by calling `yylex()`.
// It also prompts the user to enter input and ends when EOF (Ctrl+D) is encountered.

int yywrap() {
    return 1;
}
// The `yywrap` function is called when the end of the input is reached.
// Returning 1 indicates that there is no more input to process.