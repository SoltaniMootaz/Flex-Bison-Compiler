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
%token TYPE
%token ID
%token<fval> REAL
%token<ival> INT
%token<sval> STR
%token NL
%token PV
%token VI
%token MODIFICATEUR
%token CLASS
%token FOR
%token POPEN
%token PCLOSE
%token SUP
%token SUPEG
%token INF
%token INFEG
%token EG
%token NEG
%token NOT
%token ET
%token OU
%token PLUS
%token MOINS
%token FOIS
%token SUR
%token INC

%type<ival> expression_int
%type<fval> expression_real
%type<sval> expression_str
%start program
%%
program:
    |  header class_prog
    ;
header:
        HEADER  PV NL {printf("import \n");}
    |   HEADER PV NL header {printf("import \n");}
    ;
class_prog:
        MODIFICATEUR CLASS ID DEBBLOCK FINBLOCK {printf("class program \n")}
    |   MODIFICATEUR CLASS ID DEBBLOCK NL main_prog NL FINBLOCK {printf("class program \n")}
    |   MODIFICATEUR CLASS ID DEBBLOCK NL declaration main_prog NL FINBLOCK {printf("class program \n")}
    |   MODIFICATEUR CLASS ID NL DEBBLOCK main_prog  FINBLOCK   {printf("class program \n")}
    |   MODIFICATEUR CLASS ID NL DEBBLOCK declaration main_prog  FINBLOCK   {printf("class program \n")}
    |   MODIFICATEUR CLASS ID DEBBLOCK  main_prog  FINBLOCK {printf("class program \n")}
    |   MODIFICATEUR CLASS ID DEBBLOCK  declaration main_prog  FINBLOCK {printf("class program \n")}
    ;
declaration:
        TYPE ID PV NL
    |   declaration
    ;
main_prog:
        DEBUTMAIN DEBBLOCK FINBLOCK {printf("main program \n");}
    |   DEBUTMAIN DEBBLOCK NL traitement FINBLOCK {printf("main block;\n");}
    |   DEBUTMAIN NL DEBBLOCK NL traitement FINBLOCK  {printf("main block;\n");}
    |   DEBUTMAIN NL DEBBLOCK traitement FINBLOCK     {printf("main block;\n");}
    ;
traitement:
    |   declaration traitement {printf("declaration;\n");}
    |   afftectaion_int PV NL traitement {printf("afftectaion entiers;\n");}
    |   afftectaion_real PV NL traitement {printf("afftectaion reels;\n");}
    |   afftectaion_str PV NL traitement {printf("afftectaion chaine de caracteres;\n");}
    |   deb_bloucle DEBBLOCK NL traitement FINBLOCK {printf("boucle pour;\n");}
    ;

deb_bloucle:
        FOR POPEN afftectaion_int VI compare_stmt VI incrementation  PCLOSE
        ;
incrementation:
        ID INC 
    |   INC ID
    ;
compare_stmt:
        compare_element SUP compare_element
    |   compare_element SUPEG compare_element
    |   compare_element INF compare_element
    |   compare_element INFEG compare_element
    |   compare_element EG compare_element
    |   compare_element NEG compare_element
    ;
compare_element:
        ID
    |   INT
    |   REAL
    ;
afftectaion_int:
        ID AFFCT expression_int  {printf("afftectaion;\n");}
    ;
afftectaion_real:
        ID AFFCT expression_real  {printf("afftectaion;\n");}
    ;
afftectaion_str:
        ID AFFCT expression_str  {printf("afftectaion;\n");}
    ;
expression_int:
        INT
    |   expression_int PLUS expression_int
    |   expression_int MOINS expression_int
    |   expression_int FOIS expression_int
    |   expression_int SUR expression_int   { if($3){
				     					        $$ = $1 / $3;
				  					          }
				  					          else{
										        $$ = 0;
										        printf("\t erreur:division par zero\n");
				  					          } 	
				    			             }
    ;
expression_real:
        REAL
    |   expression_real PLUS expression_real
    |   expression_real MOINS expression_real
    |   expression_real FOIS expression_real
    |   expression_real SUR expression_real  { if($3){
				     					        $$ = $1 / $3;
				  					          }
				  					          else{
										        $$ = 0;
										        printf("\n erreur:division par zero\n");
				  					          } 	
				    			             }
    ;
expression_str:
        STR
    |   expression_str PLUS expression_str
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
