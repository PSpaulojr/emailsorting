%{

#include <stdio.h>
#include <string.h>

/* Criteiros de desempate:
   1 - Maior match
   2 - Regra que vem antes */

unsigned int valido = 0;
unsigned int unicamp = 0;
unsigned int fee = 0;


%}


PALAVRA   [a-zA-Z0-9.]

FINAL     .[(com)(br)]

USUARIO1   {PALAVRA}+
USUARIO2   {PALAVRA}*

/*VALIDO    {USUARIO}[@]{USUARIO}
/*UNICAMP   (@unicamp.br)
/*FEE       (@fee.unicamp.br)*/

%%

{USUARIO1}@{USUARIO2}fee[.]unicamp[.]br {++fee; ++valido; ++unicamp;}

{USUARIO1}@{USUARIO2}unicamp[.]br {++unicamp; ++valido;} 

{USUARIO1}@{USUARIO1}{FINAL} {++valido;} 
 
[[:space:]]+ ;
[[:^space:]]+ ;

[.\n]* ;

%%

int main() {
  yylex();
  printf("%d %d %d\n", valido, unicamp, fee);
  return 0;
}