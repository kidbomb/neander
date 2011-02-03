#ifndef _SPAGHETI_STACK_C_
#define _SPAGHETI_STACK_C_

#include "spaghetti-stack.h"
/* Verifica , a aprtir de um escopo inicial, toda a cadeia de escopos acima dela para uma variavel */
/* Retorna a entrada da tabela caso haja uma entrada  */
/* Retorna nulo caso não ache nada */
entry_t * scope_lookup(scope_entry * scope, char * name)
{
	entry_t * res = NULL;	scope_entry * scope_l = scope;

	while(scope_l != NULL)
	{
		res = lookup(scope_l->table, name);
		{
			/* Se achar o elemento */
			if(res != NULL)
			{
				/*  Termina o laço */
				break;
			}
			else
			{
				scope_l = scope_l->parent;
			}
		}
	}
	return res;

}
/* Para inserir, basta usar a função table_insert com o parametro scope->table*/

#endif
