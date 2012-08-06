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
symbol_t ts_temp;	//para variaveis temporarias
int i;                      /* Variavel de iteracao*/
FILE* output;            /* O arquivo de saída gerado pelo compilador */
int chosen_architecture;
int pc;


void table_insert(symbol_t *t, char* nome, int value) ;
void compiler_fatal_error(char * error);

%}
%error-verbose
/***************************************************************************************/
/*                              Tipos possíveis                                        */
/***************************************************************************************/
%union{
	int inteiro;		/* Tipo 'inteiro' */
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
%token DOUBLE_EQUAL
%token GOTOCMD
%token<character> PLUSOP
%token<character> OROP
%token<character> ANDOP
%token<inteiro>	INTEIRO
%token<string> 	IDF
%type<string> 	VARIABLE
%type<string> 	VALUE_T
%type<character> OP

%%
/********************************************************************************/
/*                     Programa	               				        */
/********************************************************************************/
/* O programa é definido pro declarações, tanto de tipos como de procedimentos */
PROGRAMA: {
	table_init(&ts);
	table_init(&ts_temp);
	pc = 0;
}
	DECLARACOES {
		if(pc > 128) compiler_fatal_error("O programa passou de 127 bytes\n");
		struct list_t * elem ;
		fprintf(output, "HLT\n");
		fprintf(output, "ORG 128\n");

		for (i=0 ; i<SYMBOL_TABLE_SIZE ; i++) {
      			if (ts[i] != NULL) {
				elem = ts[i] ;
				while (elem != NULL) {
           				fprintf(output, "%s:\tDB %d\n",elem->symb->name,  elem->symb->value);

	   				elem = elem->next;
				}
      			}
   		}

		for (i=0 ; i<SYMBOL_TABLE_SIZE ; i++) {
      			if (ts_temp[i] != NULL) {
				elem = ts_temp[i] ;
				while (elem != NULL) {
           				fprintf(output, "%s:\tDB %d\n",elem->symb->name,  elem->symb->value);

	   				elem = elem->next;
				}
      			}
   		}
	}/* Deve ser verificado se o procedimento 'main existe */
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
	| DECLARACAO_GOTO
	;
/********************************************************************************/
/*                     Declaracoes do assignment			        */
/********************************************************************************/
/* Uma declaração de tipo pode ser de tipo ou de tabela */

DECLARACAO_ASSIGNMENT: VARIABLE ASSIGNMENT VARIABLE OP VARIABLE {

	fprintf(output, "LDA %s\n", $5.name);
	if($4 == '+'){
		fprintf(output, "ADD %s\n", $3.name);
		pc+=2;
	} else if($4 == '&'){
		fprintf(output, "AND %s\n", $3.name);
		pc+=2;
	} else if($4 == '|'){
		fprintf(output, "OR %s\n", $3.name);
		pc+=2;
	} else {
		compiler_fatal_error("Esse compilador só suporta operações de + \n");
	}
	fprintf(output, "STA %s\n", $1.name);	
	pc+=4;
}
| VARIABLE ASSIGNMENT '!' VARIABLE {
	fprintf(output, "LDA %s\n", $4.name);
	fprintf(output, "NOT\n");
	fprintf(output, "STA %s\n", $1.name);	
	pc+=5;
}
| VARIABLE ASSIGNMENT VALUE_T {
	fprintf(output, "LDA %s\n", $3.name);
	fprintf(output, "STA %s\n", $1.name);
	pc+=4;
}
;



OP : PLUSOP |  OROP | ANDOP ;

VALUE_T: 
	VARIABLE {
		$$.name = $1.name;
	}
	| INTEIRO {
		
		char * constname  = malloc(sizeof(char)*15);
		sprintf(constname, "CONST_%04d", $1);
		entry_t* entrada = lookup(ts_temp, constname) ;
		if (!entrada) {
			table_insert(&ts_temp, constname, $1);
		}
		$$.name = constname;		
	}
	;


VARIABLE: IDF {
	symbol_t *t;
	/*TODO: not the best solution*/
	if(strstr($1.name, "TMP")){
		t = &ts_temp;
	} else {
		t = &ts;
	}
	
	/*inserir na tabela se não estiver la*/
	entry_t* entrada = lookup(*t, $1.name) ;
        if (!entrada) {
		table_insert(t,$1.name, 0);
	}
	$$.name = $1.name;
};

DECLARACAO_IF : IF_T VARIABLE '<' INTEIRO GOTOCMD IDF {
	if($4 !=0){
		compiler_fatal_error("Operação < com número diferente de zero não suportada!\n");
	} else{
		fprintf(output, "LDA %s\n", $2.name);
		fprintf(output, "JN %s\n", $6.name);
		pc+=4;
	}
} 
| IF_T IDF DOUBLE_EQUAL INTEIRO GOTOCMD IDF {
	if($4 !=0){
		compiler_fatal_error("Operação == com número diferente de zero não suportada!\n");
	} else{
		fprintf(output, "LDA %s\n", $2.name);
		fprintf(output, "JZ %s\n", $6.name);
		pc+=4;
	}
} 
;
DECLARACAO_LABEL: IDF ':' {
	fprintf(output, "%s:\n", $1.name);
}
;
DECLARACAO_GOTO: GOTOCMD IDF {
	fprintf(output, "JMP %s\n", $2.name);
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
void table_insert(symbol_t *t,char* nome, int value) {
     entry_t* entrada = (entry_t*)malloc(sizeof(entry_t));
     entrada->name = (char*)malloc(sizeof(char)*strlen(nome));
     entrada->value = value;
     strcpy(entrada->name, nome);
     insert(t, entrada );
     
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
      printf("Erro. Uso do programa: \n\t%s -o <file.asm> [<input.tac>]\t onde <file.tac> eh o nome do arquivo de saida.\n\t\t e <input.txt> eh o arquivo de entrada (default: entrada padrao).\n", argv[0]);
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
