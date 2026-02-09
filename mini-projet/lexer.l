%option noyywrap
%option yylineno

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
%}

DIGIT [0-9]
ID [a-zA-Z_][a-zA-Z0-9_]*
INT [0-9]+

%%
[ \t\r]+ { }
\n { }

"var" { return VAR; }
"if" { return IF; }
"else" { return ELSE; }
"while" { return WHILE; }
"print" { return PRINT; }

{ID} { yylval.sval = strdup(yytext); return IDENTIFIER; }
{INT} { yylval.ival = atoi(yytext); return INTEGER; }

"==" { return EQ; }
"!=" { return NEQ; }
"<=" { return LE; }
">=" { return GE; }
"<" { return LT; }
">" { return GT; }

"+" { return PLUS; }
"-" { return MINUS; }
"*" { return MULT; }
"/" { return DIV; }

"=" { return ASSIGN; }
";" { return SEMICOLON; }
"(" { return LPAREN; }
")" { return RPAREN; }
"{" { return LBRACE; }
"}" { return RBRACE; }

. { printf("Caractère invalide %s ligne %d\n", yytext, yylineno); }
%%
