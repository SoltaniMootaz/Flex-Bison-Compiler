%{
#undef yywrap
#define yywrap()1
 #undef YY_BUF_SIZE
#define YY_BUF_SIZE 2000*1024
%}
HEADER	"import MiniL.lang"[ ]*";"|"import MiniL.io"[ ]*";"
DEBUTCLASS {MODIFICATEUR}[ ]+[^\n]"class"[ ]+{ID}[ ]*"{"|{MODIFICATEUR}+[ ]*+[^\n]"class"+[ ]+{ID}[ \t\n]*"{"
FINBLOC "}"
DEBUTMAIN "main"[ ]*"{"|"main"[ \t\n]*"{"
INSTRUCTION {AFFECTATION}|{BOUCLE}
BOUCLE "for("[ ]*{ID}[ ]*":="[ ]*{DIGIT}+[ ]*","[ ]*{COMPAREXPRES}[ ]*","[ ]*{ID}"++"[ ]*")"[ ]*"{"
NOPL "not"
OPA "+"|"-"|"*"|"/"
OPC "="|"!="|">="|">"|"<"|"<="
OPL "&&"|"||"
ARITHEXPRES {ID}[ ]*{OPA}[ ]*{ID}[ ]*";"|{ID}[ ]*{OPA}[ ]*{DIGIT}+[ ]*";"|{DIGIT}+[ ]*{OPA}[ ]*{DIGIT}+[ ]*";"|{DIGIT}+[ ]*{OPA}[ ]*{ID}[ ]*";"
AFFECTATION {ID}[ ]*":="[ ]*{DIGIT}+[ ]*";"|{ID}[ ]*":="[ ]*{ARITHEXPRES}][ ]*";"|{ID}[ ]*":="[ ]*{ID}[ ]*";"
COMPAREXPRES "("[ ]*{ID}[ ]*{OPC}[ ]*{ID}[ ]*")"|"("[ ]*{DIGIT}+[ ]*{OPC}[ ]*{ID}[ ]*")"|"("[ ]*{DIGIT}+[ ]*{OPC}[ ]*{DIGIT}+[ ]*")"|"("[ ]*{ID}[ ]*{OPC}[ ]*{DIGIT}+[ ]*")"
LOGIQEXPRES {NOPL}*"("[ ]*{COMPAREXPRES}[ ]*{OPL}[ ]*{COMPAREXPRES}[ ]*")"|{NOPL}*"("[ ]*{COMPAREXPRES}[ ]*")"
ID [a-zA-Z_]{1,10}[0-9]*
ALPHA [a-zA-Z]
TYPE "integer"|"real"|"str"
DIGIT [0-9]
VAR {ID}+[","[ ]*{ID}+|[ ]]+[ ]*
DECLARE {TYPE}+[ ]+[^\n]+{VAR}+";"|{TYPE}+[ ]+[^\n]+{VAR}+"["+{DIGIT}+"]"+";"
MODIFICATEUR "public"|"private"


%%
{HEADER} {printf("import\n");}
{BOUCLE} {printf("boucle pour\n");}
{NOPL} {printf("operateur de negation\n");}
{DEBUTMAIN} {printf("main\n");}
{OPA} {printf("operateur arithmetique\n");}
{ARITHEXPRES} {printf("ecpression arithmetique\n");}
{AFFECTATION} {printf("affectation\n");}
{TYPE} {printf("Type\n");}
{ID} {printf("identificateur\n");}
{DEBUTCLASS} {printf("declaration class\n");}
{DECLARE} {printf("declaration variable\n");}
{VAR} {printf("variable\n");}
{OPL} {printf("operateur logique\n");}
{OPC} {printf("operateur de comparaison\n");}
{LOGIQEXPRES} {printf("expression logique\n");}
{COMPAREXPRES} {printf("expression de comparaison\n");}
{FINBLOC} {printf("c'est la fin d'un bloc\n");}
.			         ;
%%
void main(){
yylex();
ECHO;
}