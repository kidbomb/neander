/*************************************PARSER*************************************/
/* Parte 1: declarações*/

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#include "symbol-table.h"
#include "spaghetti-stack.h"

scope_entry * scope;        /* Escopo atual */
int i;                      /* Variavel de iteracao*/
FILE* output;            /* O arquivo de saída gerado pelo compilador */

void table_insert(char* nome) ;
void compiler_fatal_error(char * error);
void scope_enter();
void scope_leave();
void scope_init();

%}
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
%token<inteiro>	INTEIRO
%token<string> 	IDF
%type<character> OP

%%
/********************************************************************************/
/*                     Programa	               				        */
/********************************************************************************/
/* O programa é definido pro declarações, tanto de tipos como de procedimentos */
PROGRAMA: {
    scope_init();
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
	entry_t* entrada = scope_lookup(scope, $1.name) ;
        if (!entrada) {
		table_insert($1.name);
	}
	fprintf(output, "LDA %s", $5.name);
	if($4 == '+'){
		fprintf(output, "ADD %s", $3.name);
	} else {
		compiler_fatal_error("Esse compilador só suporta operações de +");
	}
	fprintf(output, "STA %s", $1.name);
	
};

OP : '+' | '-' | '*' | '/' | '&' ;

DECLARACAO_IF : IF_T IDF '<' INTEIRO GOTOCMD IDF {

}
;
DECLARACAO_LABEL: IDF ':' {

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
     insert(&(scope->table), entrada );
     
}

void compiler_fatal_error(char * message){
	printf("%s", message);
	exit(-1);
}

void scope_init(){
	/* aloca memória para o ponteiro */
	scope = (scope_entry*) malloc(sizeof(scope_entry));
	/* Como é a raiz, não tem pai */
	scope->parent = NULL;
	table_init(&(scope->table));
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
  fprintf(stderr, "%s: %s", progname, s);
}
