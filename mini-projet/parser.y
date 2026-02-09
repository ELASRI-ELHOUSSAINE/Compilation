%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);

/* ===== Table des symboles simple ===== */
typedef struct {
    char name[32];
    int value;
} Symbol;

Symbol table[100];
int sym_index = 0;

void declare(char *name) {
    strcpy(table[sym_index].name, name);
    table[sym_index].value = 0;
    sym_index++;
}

int get_value(char *name) {
    for (int i = 0; i < sym_index; i++)
        if (strcmp(table[i].name, name) == 0)
            return table[i].value;

    yyerror("Variable non déclarée");
    return 0;
}

void set_value(char *name, int value) {
    for (int i = 0; i < sym_index; i++)
        if (strcmp(table[i].name, name) == 0) {
            table[i].value = value;
            return;
        }

    yyerror("Variable non déclarée");
}
%}

%union {
    int ival;
    char *sval;
}

%token <ival> INTEGER
%token <sval> IDENTIFIER

%token VAR IF ELSE WHILE PRINT
%token PLUS MINUS MULT DIV
%token EQ NEQ LT GT LE GE
%token ASSIGN SEMICOLON
%token LPAREN RPAREN LBRACE RBRACE

%type <ival> expression condition

%left PLUS MINUS
%left MULT DIV
%left EQ NEQ LT GT LE GE

%start program

%%

program
    : statement_list
      { printf("✔ Programme syntaxiquement correct\n"); }
    ;

statement_list
    : /* vide */
    | statement_list statement
    ;

statement
    : VAR IDENTIFIER SEMICOLON
        { declare($2); }

    | IDENTIFIER ASSIGN expression SEMICOLON
        { set_value($1, $3); }

    | PRINT LPAREN expression RPAREN SEMICOLON
        { printf("PRINT => %d\n", $3); }

    | IF LPAREN condition RPAREN block

    | IF LPAREN condition RPAREN block ELSE block

    | WHILE LPAREN condition RPAREN block
    ;

block
    : LBRACE statement_list RBRACE
    ;

condition
    : expression EQ expression { $$ = ($1 == $3); }
    | expression NEQ expression { $$ = ($1 != $3); }
    | expression LT expression { $$ = ($1 < $3); }
    | expression GT expression { $$ = ($1 > $3); }
    | expression LE expression { $$ = ($1 <= $3); }
    | expression GE expression { $$ = ($1 >= $3); }
    ;

expression
    : expression PLUS expression { $$ = $1 + $3; }
    | expression MINUS expression { $$ = $1 - $3; }
    | expression MULT expression { $$ = $1 * $3; }
    | expression DIV expression
        {
            if ($3 == 0) yyerror("Division par zéro");
            $$ = $1 / $3;
        }
    | INTEGER { $$ = $1; }
    | IDENTIFIER { $$ = get_value($1); }
    | LPAREN expression RPAREN { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    printf("Erreur syntaxique: %s\n", s);
}

int main(int argc, char **argv) {
    extern FILE *yyin;

    if (argc > 1)
        yyin = fopen(argv[1], "r");

    yyparse();
    return 0;
}
