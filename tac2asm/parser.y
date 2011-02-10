/*************************************PARSER*************************************/
/* Parte 1: declarações*/

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#include "symbol-table.h"
#define ARQ_NEANDER	1
#define ARQ_RAMSES	2
#define ARQ_AHMES	3

symbol_t ts;
int i;                      /* Variavel de iteracao*/
FILE* output;            /* O arquivo de saída gerado pelo compilador */
int chosen_architecture;


void table_insert(char* nome) ;
void compiler_fatal_error(char * error);

%}
%error-verbose
/***************************************************************************************/
/*                              Tipos possíveis                                        */
/***************************************************************************************/
%union{
	int inteiro;		/* Tipo 'inteiro' */
	int byte;
	char character;
	struct s1 {
		char* name ;
		int size ;
	} string ;
}
/********************************************************************/
/* Associação de um tipo de atributo aus tokens e aos não terminais */
/********************************************************************/

%token IF_T
%token ASSIGNMENT
%token GOTOCMD
%token<character> PLUSOP
%token<character> MINUSOP
%token<character> MULTOP
%token<character> DIVOP
%token<character> ANDOP
%token<inteiro>	INTEIRO
%token<string> 	IDF
%type<character> OP

%%
/********************************************************************************/
/*                     Programa	               				        */
/********************************************************************************/
/* O programa é definido pro declarações, tanto de tipos como de procedimentos */
PROGRAMA: {
	table_init(&ts);
}
	DECLARACOES /* Deve ser verificado se o procedimento 'main existe */
	;
/* declarações são um conjunto de declaração */
DECLARACOES:
	DECLARACAO
	| DECLARACOES DECLARACAO
	;
/* declaração poode ser uma declaração de tipo ou de procedimento */
DECLARACAO:
	DECLARACAO_ASSIGNMENT
	| DECLARACAO_IF
	| DECLARACAO_LABEL
	;
/********************************************************************************/
/*                     Declaracoes do assignment			        */
/********************************************************************************/
/* Uma declaração de tipo pode ser de tipo ou de tabela */

DECLARACAO_ASSIGNMENT: IDF ASSIGNMENT IDF OP IDF {
	/*inserir na tabela se não estiver la*/
	entry_t* entrada = lookup(ts, $1.name) ;
        if (!entrada) {
		table_insert($1.name);
	}
	fprintf(output, "LDA %s\n", $5.name);
	if($4 == '+'){
		fprintf(output, "ADD %s\n", $3.name);
	} else {
		compiler_fatal_error("Esse compilador só suporta operações de +\n");
	}
	fprintf(output, "STA %s\n", $1.name);	
}
| IDF ASSIGNMENT IDF {
	fprintf(output, "LDA %s\n", $3.name);
	fprintf(output, "STA %s\n", $1.name);
}
| IDF ASSIGNMENT INTEIRO {
	/**/
	char constname [15];
	sprintf(constname, "CONST_%04d", $3);
	entry_t* entrada = lookup(ts, constname) ;
        if (!entrada) {
		table_insert(constname);
	}
	fprintf(output, "LDA %s\n", constname);
	fprintf(output, "STA %s\n", $1.name);

}
;

OP : PLUSOP | MINUSOP | MULTOP | DIVOP | ANDOP ;

DECLARACAO_IF : IF_T IDF '<' INTEIRO GOTOCMD IDF {
	if($4 !=0){
		compiler_fatal_error("Operação < com número diferente de zero não suportada!\n");
	} else{
		fprintf(output, "LDA %s\n", $2.name);
		fprintf(output, "JN %s\n", $6.name);
	}
} 
;
DECLARACAO_LABEL: IDF ':' {
	fprintf(output, "%s :\n", $1.name);
}
;

%%
/********************************************************************************/
/*    Procedimentos anexos em c:					        */
/*    +table_insert								*/
/*    +gera_tmp									*/
/********************************************************************************/

char* progname;
/********************************************************/
/* table_insert						*/
/*							*/
/* insere uma variável na tabela			*/
/********************************************************/
void table_insert(char* nome) {
     entry_t* entrada = (entry_t*)malloc(sizeof(entry_t));
     entrada->name = (char*)malloc(sizeof(char)*strlen(nome));
     strcpy(entrada->name, nome);
     insert(&ts, entrada );
     
}

void compiler_fatal_error(char * message){
	printf("%s", message);
	exit(-1);
}

/********************************************************/
/* 		           MAIN				*/
/********************************************************/

 /* Inclui o yylex() (analisador lexical), fornecido por lex */
#include "lex.yy.c"

int main(int argc, char* argv[]) {
   progname = argv[0];
   output = stdout;
   if (argc != 3 && argc != 4) {
      printf("Erro. Uso do programa: \n\t%s -o <file.tac> [<input.txt>]\t onde <file.tac> eh o nome do arquivo de saida.\n\t\t e <input.txt> eh o arquivo de entrada (default: entrada padrao).\n", argv[0]);
      exit(-1);
  }
  else output = fopen(argv[2], "w");
  if (argc == 4) {
    yyin = fopen(argv[3], "r");    
   }
   yyparse();
  if (output) fclose(output);
  return(0);
}

yyerror(char* s) {
  fprintf(stderr, "%s: %s\n", progname, s);
}
