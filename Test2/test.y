%{

#include <stdio.h>
#include <stdlib.h>
int yylex(void);
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%union{
    int ival;
    float fval;
}
%token<ival> INT
%token<fval> REAL
%token PLUS
%type<ival> exp
%token NL;
%start calcul
%%
calcul: 
| calcul line;
line:NL
| exp { printf("\tResult: %i\n", $1);}
 ;
exp: INT {$$ = $1;}
  |exp PLUS exp  { $$ = $1 + $3;}
  ;
%%

int main() {
	yyin = stdin;

	do {
		yyparse();
       
	} while(!feof(yyin));

	return 0;
}
void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	
}
