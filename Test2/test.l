%{
#undef yywrap
#define yywrap()1
#include <stdio.h>
#define YY_DECL int yylex()
void Error();
#include "test.tab.h"
%}
DIGIT [0-9]
ALPHA [a-zA-Z_]
ID {ALPHA}{1,10}{DIGIT}*
%%
[0-9]+\.[0-9]+ {yylval.fval = atof(yytext); return REAL;}
[0-9]+ {yylval.ival = atoi(yytext); return INT;}
"+" {return PLUS;}
\n {return NL;}
[ \t]	;
. {Error();}
%%
void Error(){
    printf("le valeur ne correspond a aucune regle de production");
}
