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
TYPE "int"|"real"|"str"
MODIFICATEUR "public"|"private"
CLASS "class"
ID [a-zA-Z_]{1,10}[0-9]*
REAL [0-9]+\.[0-9]+
INT [0-9]+
STR [a-zA-Z_]*[0-9]*
AFFCT ":="
POPEN "("
PCLOSE ")"
SUP ">"
SUPEG ">="
INF "<"
INFEG "<="
EG "="
NEG "!="
NOT "!"
ET "&&"
OU "||"
PLUS "+"
MOINS "-"
FOIS "*"
SUR "/"
INC "++"


%%
FOR|for {return FOR;}
{MODIFICATEUR} {return MODIFICATEUR;}
{CLASS} {return CLASS;}
{DEBBLOCK} {return DEBBLOCK;}
{FINBLOCK} {return FINBLOCK;}
{HEADER} {return HEADER;}
{DEBUTMAIN} {return DEBUTMAIN;}
{AFFCT} {return AFFCT;}
{TYPE} {return TYPE;}
{ID} {return ID;}
{REAL} {yylval.fval = atof(yytext); return REAL;}
{INT} {yylval.ival = atoi(yytext); return INT;}
{STR} {return STR;}
{POPEN} {return POPEN;}
{PCLOSE} {return PCLOSE;}
{SUP} {return SUP;}
{SUPEG} {return SUPEG;}
{INF} {return INF;}
{INFEG} {return INFEG;} 
{EG} {return EG;}
{NEG} {return NEG;}
{NOT} {return NOT;}
{ET} {return ET;}
{OU} {return OU;}
{PLUS} {return PLUS;}
{MOINS} {return MOINS;}
{FOIS} {return FOIS;}
{SUR} {return SUR;}
{INC} {return INC;}
\n {return NL;}
";" {return PV;}
"," {return VI;}
[ \t] ;
. {Error();};
%%
void Error(){
    printf("le valeur ne correspond a aucune regle de production");
}