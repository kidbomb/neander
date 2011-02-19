#ifndef _SPAGHETI_STACK_H_
#define _SPAGHETI_STACK_H_

#include "symbol-table.h"
#include <stdio.h>
#include <stdlib.h>
/* http://en.wikipedia.org/wiki/Spaghetti_stack */
struct s_entry{
	symbol_t table;
	struct s_entry * parent;
};

typedef struct s_entry scope_entry;

entry_t * scope_lookup(scope_entry * scope, char * name);
#endif
