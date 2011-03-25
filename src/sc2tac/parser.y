/*************************************PARSER*************************************/
/* Parte 1: declarações*/

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#include "symbol-table.h"
#include "spaghetti-stack.h"

/* Definir constantes para tipos e tamantos dos tipos*/
#define		_TIPO_BYTE_		104
#define		_TIPO_PROCEDIMENTO_	106
#define		_SIZE_BYTE_		1

static int n_tmp = 0 ;      /* Para contabilizar os tmpXX */
scope_entry * scope;        /* Escopo atual */
int i;                      /* Variavel de iteracao*/
FILE* output;            /* O arquivo de saída gerado pelo compilador */

typedef struct expr {
		int tipo;
		char* local ;
	} expressao;

void table_insert(char* nome, int tipo, int size, void* extra) ;
void opr(char op, expressao* a, expressao* b, expressao* c);
char* gera_tmp() ;
void compiler_fatal_error(char * error);
void scope_enter();
void scope_leave();
void scope_init();
void moreline();



%}
/***************************************************************************************/
/*                              Tipos possíveis                                        */
/***************************************************************************************/
%union{
	int byte;
	struct s1 {
		int tipo;
		char* name ;
		int size ;
	} string ;
	struct s3 {
		int tipo;	/* Constante que define o tipo */
		int size;	/* Tamanho do tipo */
	} tipo;
	expressao expressao;
  	struct s6 {
		int tipo;
		char* local ;
	} l_t ;
	struct s9 {
		char label[100];
	} jump;
}
/********************************************************************/
/* Associação de um tipo de atributo aus tokens e aos não terminais */
/********************************************************************/

%token BYTE_T
%token VOID_T
%token ELSE_T
%token IF_T
%token WHILE_T
%token DOUBLE_EQUAL
%token DE
%token GREATER_OR_EQUAL
%token RETORNA
%token <byte>		BYTE
%token <string> 	IDF
%type	<tipo>		TIPO
%type <expressao> EXPRESSAO
%type <l_t> L
%type <jump> IF_BEGIN
%type <jump> IF_END

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
	DECLARACAO_TIPO ';'
	| DECLARACAO_PROCEDIMENTO
	;
/********************************************************************************/
/*                     Declaracoes de tipo				        */
/********************************************************************************/
/* Uma declaração de tipo pode ser de tipo ou de tabela */
DECLARACAO_TIPO:
	 TIPO IDF {
	        /* Definicao de variavel: insere na tabela de simbolos */
		table_insert($2.name, $1.tipo, $1.size, NULL);
	}
	| TIPO IDF '=' BYTE {
		/*Definição com valor inicial*/
		table_insert($2.name, $1.tipo, $1.size, NULL);
	}
	;

/* Um tipo pode ser byte */
TIPO:
	BYTE_T {
		/* Definir tamanho e tipo  */
		$$.tipo = _TIPO_BYTE_;
		$$.size = _SIZE_BYTE_;	
	}
	;
/********************************************************************************/
/*                     Declaracoes de procedimento			        */
/********************************************************************************/	


DECLARACAO_PROCEDIMENTO:
	/*só suporta funcoes void por enquanto*/
	VOID_T IDF '(' ')' ESCOPO {
		/* Funcao com 0 ou mais parametros*/

		/*so suporta uma funcao por enquanto: a main*/
		if(strcmp($2.name, "main") != 0)
		{
			printf("Erro: este compilador aceita apenas uma funcao main");
			return 0;
		}
	}
	;

ESCOPO:
	ABRE_CHAVES INSTRUCOES FECHA_CHAVES {
	}
	;
	
ABRE_CHAVES:
	'{' {
		/* entra escopo */
	}
	;

FECHA_CHAVES:
	'}'{
		/* sai escopo */
	}
	;
/****************************************************************/
/*					Intrucoes	*/
/***************************************************************/
INSTRUCOES: INSTRUCAO {
		}
	    | INSTRUCOES INSTRUCAO {
		}
INSTRUCAO:
	L '=' BYTE ';' {
		/* para evitar expressões simples em 2 linhas*/
		fprintf(output, "%s \t:= %d\n", $1.local, $3); 
		
	} 
	| L '=' EXPRESSAO  ';' {
		/* Expressão var = 3; */
		moreline();
		if($1.tipo == $3.tipo){
                     fprintf(output, "%s \t:= %s\n", $1.local, $3.local); 
		} else {
			printf("Erro: tipos diferentes na atribuicao!\n");
			exit(-1);
		}
	}
	| IF_BEGIN INSTRUCOES IF_END {
		fprintf(output, "IF_%s :\n", $1.label);
	}
	| WHILE_T '(' IDF DOUBLE_EQUAL BYTE ')' ESCOPO {
	}
	;

IF_BEGIN: IF_T '(' IDF DOUBLE_EQUAL BYTE ')' ABRE_CHAVES {
		/*gera um label pra goto*/
		if($5 == 0){
		    char * iflabel_in = gera_tmp();
		    char * iflabel_out = gera_tmp();
		    strcpy($$.label, iflabel_out);
		    fprintf(output, "if %s == 0 GOTO IF_%s\n", $3.name, iflabel_in);
		    fprintf(output, "GOTO IF_%s\n",  iflabel_out);
		    fprintf(output, "GOTO IF_%s\n", iflabel_in);
		} else {
		    printf("Erro: compilador nao aceita esse tipo de comparacao\n");
		    exit(-1);
		}
	}
	| IF_T '(' IDF GREATER_OR_EQUAL BYTE  ')' ABRE_CHAVES {
		/*gera um label pra goto*/
		if($5 == 0){
		    char * iflabel = gera_tmp();				
		    strcpy($$.label, iflabel);
		    fprintf(output, "if %s < 0 GOTO IF_%s\n", $3.name, iflabel);
		} else {
		    printf("Erro: compilador nao aceita esse tipo de comparacao\n");
		    exit(-1);
		}

    }
	;
IF_END: FECHA_CHAVES {
	}
	;
EXPRESSAO: EXPRESSAO '+' EXPRESSAO {
	 opr('+', &$$, &$1, &$3);
    }
    | EXPRESSAO '|' EXPRESSAO {
	 opr('|', &$$, &$1, &$3);
	}
    | EXPRESSAO '&' EXPRESSAO {		
	 opr('&', &$$, &$1, &$3);
	
    }
    | '!' EXPRESSAO {
	    $$.local = gera_tmp();
            $$.tipo = $2.tipo;
            fprintf(output, "%s \t:= ! %s\n", $$.local, $2.local);
    }
    | '(' EXPRESSAO ')' {
	 $$.local = $2.local ;
	$$.tipo = $2.tipo;
	}
    | L {
	$$.tipo = $1.tipo;
            $$.local = $1.local ;
        }
    | BYTE {
	$$.local = gera_tmp();
	$$.tipo = _TIPO_BYTE_;
        fprintf(output, "%s \t:= %d\n", $$.local, $1);
	}
    ;

L:  IDF {
           entry_t* entrada = scope_lookup(scope, $1.name) ;
           if (!entrada) {
		     	printf("O simbolo %s nao foi declarado neste escopo!\n", $1.name);
		     exit(-1);
		  }
      	   $$.local = $1.name ;
	   $$.tipo = entrada->type;
	 ; }
     ;

%%
/********************************************************************************/
/*    Procedimentos anexos em c:					        */
/*    +table_insert								*/
/*    +gera_tmp									*/
/********************************************************************************/

char* progname;
int lineno;
/********************************************************/
/* table_insert						*/
/*							*/
/* insere uma variável na tabela			*/
/********************************************************/
void table_insert(char* nome, int tipo, int size, void* extra) {
     entry_t* entrada = (entry_t*)malloc(sizeof(entry_t));
     entrada->name = (char*)malloc(sizeof(char)*strlen(nome));
     strcpy(entrada->name, nome);
     entrada->type = tipo;
     entrada->size = size;
     entrada->extra = extra;
	
	insert(&(scope->table), entrada );
     
     
}
/********************************************************/
/* gera_tmp						*/
/*							*/
/* gera o nome de uma variável local			*/
/********************************************************/
char* gera_tmp() {
   char* res = malloc(8*sizeof(char));
   /* LIMITACAO: nao usar mais de 9999 temporarios! */
   sprintf(res, "TMP%04d", n_tmp);
   n_tmp++;
   return( res );
}

void opr(char op, expressao *a, expressao *b, expressao *c){
	if(b->tipo == c->tipo){
            a->local = gera_tmp();
            a->tipo = b->tipo;
            fprintf(output, "%s \t:= %s %c %s\n", a->local, b->local, op, c->local);
        } else{
            printf("Erro: elementos com tipos diferentes numa expressão ( %c )\n", op);
            exit(-1);
        }

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


void scope_enter(){
	scope_entry * child_scope = (scope_entry * ) malloc(sizeof(scope_entry));
	child_scope->parent = scope;
	table_init(&(child_scope->table));
	scope = child_scope;
}
void scope_leave(){
	/* Devove o espo ao escopo pai */
	scope = scope->parent;
}

void moreline()
{
	lineno++;
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
  fprintf(stderr, "line %d\n", lineno);
}
