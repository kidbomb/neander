 /* Analisador lexical */
 /* Secao das definicoes globais */
%{
/* Inclui as definicoes dos tokens.
 * o "y.tab.h" sera gerado pela compilacao ('yacc -d ...') do parser.
 * 'parser.y' detalha a definicao dos tokens.
 */
#include "y.tab.h"

%}
  /* Definicoes regulares */
delim    [ \t\n]
br       {delim}+ 
letra    [A-Za-z_]
alga     [0-9]
idf      {letra}+({letra}|{alga})*
numero   {alga}+(\.{alga}+)?(E[+\-]?{alga}+)?
integer [0-9]+ 

%%

 /* Secao das Regras de traducao */

{br}    { /*  Nada para fazer - sem retorno */ }
byte	{ return(BYTE_T);		}
int		{ return(INTEIRO_T);	}
void	{ return(VOID_T);		}
return	{ return(RETORNA);		}
if		{ return(IF_T);			}
else	{ return(ELSE_T);		}
while	{ return(WHILE_T);		}
{idf}   {
			yylval.string.name = (char*)malloc(sizeof(char)*yyleng);
			strcpy(yylval.string.name, yytext);
			yylval.string.size = yyleng;
			return( IDF );
		}
{integer}	{
			yylval.inteiro = (int)atoi(yytext) ;
			return( INTEIRO );
		}

"=="	{ return(DOUBLE_EQUAL);		}	
">="	{ return(GREATER_OR_EQUAL);	}
"*"     { return( '*' ) ;		}
";"     { return( ';' ) ;		}
"="     { return( '=' ) ;		}
"("     { return( '(' ) ;		}
")"     { return( ')' ) ;		}
"+"     { return( '+' ) ;		}
"-"     { return( '-' ) ;		}
"/"     { return( '/' ) ;		}
"{"     { return( '{' ) ;		}
"}"     { return( '}' ) ;		}
"&"		{ return( '&' ) ;		}
"!"		{ return( '!' ) ;		}


%%
 /* Secao dos  Procedimentos auxiliares  */
 /* Nada - o parser acaba fazendo tudo. */
