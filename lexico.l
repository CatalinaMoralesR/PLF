
%{
	#include <stdio.h>
	#include <stdlib.h>	


	FILE * archivo = NULL;
%}
%option noyywrap
caracter _?[^\"]
%%
"*"|"&"|"-"|"~"|"|"|"("|")"|"++"|"--"|"=="|"!="|"<"|">"|"<="|">="|"&&"|"||"|"!"|"+"|"/"|"%"|"^"|"<<"|">>" {fprintf(archivo, "%s\n", yytext );}
sizeof {fprintf(archivo,"SIZEOF\n");}
\"{caracter}*\"  {fprintf(archivo,"CONSTANTE_CADENA\n");}
\'{caracter}\' {fprintf(archivo,"CONSTANTE_CARACTER\n" );}
<<EOF>> {yyterminate();}
. ;

%%
int main( int argc,char **argv ){
	if(argc == 1){
		printf("Error: Faltan parámetros en la línea de comandos.\nUso: lexico.exe archivo_entrada archivo_salida");
		return 0;
		}
	else if(argc==2){
		printf("Error: Falta parámetro en la línea de comandos.\nUso: lexico.exe archivo_entrada archivo_salida");
		return 0;
		}
	else if(argc==4){
		printf("Error: Demasiados parámetros en la línea de comandos.\nUso: lexico.exe archivo_entrada archivo_salida");
		return 0;
	}
	else{
		if(!fopen(argv[1],"r")){
			printf("Error: El archivo de entrada no existe.");
			return 0;
		}
		else if(fopen(argv[2],"r")){
			printf("Error: El archivo de salida ya existe.");
			return 0;
		}
		else{
			archivo = fopen(argv[2],"w");
		    yyin = fopen(argv[1], "r");
		}
	
	}
	
	yylex();
	return 0;
	}