%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%option noyywrap
%option yylineno

palabra_reservada @(if|else|while)
letra [a-zA-z]
letra_ {letra}|_
digito [0-9]
id #({letra_}|{digito})*
aritmeticos "+"|"-"|"*"|"/"|"%"
relacionales ">"|"<"|">="|"<="|"=="
asigancion "="
logicos v
operador {aritmeticos}|{relacionales}|{asigancion}|{logicos}
sim_puntuacion [,;]
comentarios "/*"(~("*/"))"*/"
espacios [ \t\n\r]+

%%

{palabra_reservada} {printf("Encontre una palabra reservada:%s\n",yytext);}
{id} {printf("Encontre un id:%s\n",yytext);}
{operador} {printf("Encontre un operador:%s\n",yytext);}
{sim_puntuacion} {printf("Encontre un simbolo de puntuacion:%s\n",yytext);}
{espacios}  {/* Ignorar los espacios */}
{comentarios} {/* Ignorar los comentarios */}

%%

int main(int argc, char ** argv){
    FILE *f;
    if (argv < 2){
        printf("Falta archivo");
        exit(-1);
    }
    f = fopen(argv[1],"r");
    if (!f){
        printf("No se pudo abrir el archivo");
        exit(-1);
    }
    yyin = f;
    yylex();
    return 0;

}
