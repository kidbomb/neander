#ifndef _SYMBOL_TABLE_H_
#define _SYMBOL_TABLE_H_

#define SYMBOL_TABLE_SIZE 257

typedef struct {
   char* name;  /* Name of the variable */
   int type;    /* Type of the entry: either basic type, either proc.. */
   int size;    /* sizeof(type) */
   int desloc;
   void* extra; /* Information depending on the Type */
} entry_t ;

/* Each entry in the table points to this */
struct list_t {
   entry_t* symb;
   struct list_t * next;
} ;

typedef struct list_t** symbol_t ;

/* Initialize a table of symbols */
int table_init(symbol_t* table) ;

/* Returns a pointer on the entry associated to 'name'. 
 * Returns NULL if 'name' is not in the table.
 */
entry_t* lookup(symbol_t table, char* name) ;

/* Inserts an entry in the table. */
int insert(symbol_t* table, entry_t* entry) ;

#endif
