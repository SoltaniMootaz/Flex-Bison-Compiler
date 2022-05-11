%{
#undef yywrap
#define yywrap()1
#include <stdio.h>
#define YY_DECL int yylex()
void Error();
#include "test.tab.h"
%}
%option yylineno
DEBBLOCK "{"
FINBLOCK "}"
HEADER	"import MiniL.lang"|"import MiniL.io"
DEBUTMAIN "main"[ ]*"("[ ]*")"
MODIFICATEUR "int"|"real"|"str"
ID [a-zA-Z_]{1,10}[0-9]*
REAL [0-9]+\.[0-9]+
INT [0-9]+
STR [a-zA-Z_]*[0-9]*
AFFCT ":="

%%
{DEBBLOCK} {return DEBBLOCK;}
{FINBLOCK} {return FINBLOCK;}
{HEADER} {return HEADER;}
{DEBUTMAIN} {return DEBUTMAIN;}
{AFFCT} {return AFFCT;}
{MODIFICATEUR} {return MODIFICATEUR;}
{ID} {return ID;}
{REAL} {yylval.fval = atof(yytext); return REAL;}
{INT} {yylval.ival = atoi(yytext); return INT;}
{STR} {return STR;}
\n {return NL;}
";" {return PV;}
[ \t] ;
. {Error();};
%%
void Error(){
    printf("le valeur ne correspond a aucune regle de production");
}