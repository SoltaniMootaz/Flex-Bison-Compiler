%{
#include <stdio.h>
int yylex(void);
extern int yyparse();
extern FILE* yyin;
extern int yylineno;
void yyerror(const char* s);
%}

%locations
%union{
    int ival;
    float fval;
    char * sval;
}
%token DEBBLOCK
%token FINBLOCK
%token HEADER
%token DEBUTMAIN
%token AFFCT
%token MODIFICATEUR
%token ID
%token<fval> REAL
%token<ival> INT
%token<sval> STR
%token NL
%token PV


%start program
%%
program:
    |   HEADER PV NL main_prog{printf("import \n");}
    ;
main_prog:
        DEBUTMAIN DEBBLOCK FINBLOCK {printf("main program \n");}
    |   DEBUTMAIN DEBBLOCK NL traitement FINBLOCK {printf("main block;\n");}
    |   DEBUTMAIN NL DEBBLOCK NL traitement FINBLOCK  {printf("main block;\n");}
    |   DEBUTMAIN NL DEBBLOCK traitement FINBLOCK     {printf("main block;\n");}
    ;
traitement:
    |   MODIFICATEUR ID PV NL traitement {printf("declaration;\n");}
    |   ID AFFCT INT PV NL traitement {printf("afftectaion;\n");}
    |   ID AFFCT REAL PV NL traitement {printf("afftectaion;\n");}
    |   ID AFFCT STR PV NL traitement {printf("afftectaion;\n");}
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
	fprintf(stderr, "Parse error: Line: %d\n%s\n",yylineno, s);
	
}
