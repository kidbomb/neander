#ifndef _SYMBOL_TABLE_C_
#define _SYMBOL_TABLE_C_

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol-table.h"


/* The hash function 
 * See Aho/Sethi/Ulman, Fig. 7.35 for the HPJW function
 */

#define PRIME 211
#define FDL '\0'

int hpjw(char* c) {
   char* p;
   unsigned int h =  0, g ;
   for (p= c; *p != FDL ; p++) {
      h = (h << 4) + (*p);
      if ( (g = h & 0xF0000000) != 0 ) {
         h = h ^ (g >> 24 );
	 h = h^g;
      }
   }
   return( h%PRIME );
}

int table_init(symbol_t* table) {
   int i;
   *table = (symbol_t) malloc(SYMBOL_TABLE_SIZE * sizeof(struct list_t *));
   if (*table == NULL) {
      printf("Error: not enough space for symbol table.\n");
      exit(-1);
   }
   for (i=0 ; i<SYMBOL_TABLE_SIZE ; i++) (*table)[i] = NULL ;
   return(0); 
}

/* Inserts an entry in the table. */
int insert(symbol_t* table, entry_t* entry) {
   entry_t* e ;
   int hash ;
   struct list_t * elem ;

   e = lookup(*table, entry->name) ;
   if (e != NULL) {
      printf("The entry with the name %s is already in the table.\n", 
		      entry->name);
      return(-1);
   }
   else {
      hash = hpjw(entry->name);
      elem = (*table)[hash] ;
      if (elem == NULL) {
         (*table)[hash] = (struct list_t *)malloc(sizeof(struct list_t));
	 (*table)[hash]->next = NULL;
	 (*table)[hash]->symb = entry;
      }
      else {
         while (elem->next != NULL) elem = elem->next;
	 elem->next = (struct list_t *)malloc(sizeof(struct list_t));
         elem->next->next = NULL;
         elem->next->symb = entry;
      }
  }
}

/* Returns a pointer on the entry associated to 'name'. 
 * Returns NULL if 'name' is not in the table.
 */
entry_t* lookup(symbol_t table, char* name) {
   int hash;
   struct list_t * elem ;
   entry_t* res = NULL; 
   hash = hpjw(name);
   elem = table[hash] ;
   while (elem != NULL) {
      if ( strcmp(elem->symb->name, name) == 0 ) {
         res = elem->symb;
	 break;
      }
      else elem = elem->next;
   }
   return(res);
}

int print_table(symbol_t table) {
   int i;
   struct list_t * elem ;
   printf("======================== TABLE ====================== \n");
   for (i=0 ; i<SYMBOL_TABLE_SIZE ; i++) {
      if (table[i] != NULL) {
        printf("%3d -> ", i);
	elem = table[i] ;
	while (elem != NULL) {
           printf("%s | ", elem->symb->name);
	   elem = elem->next;
	}
        printf("\n");
      }
   }
   printf("====================== END TABLE ==================== \n");
}

#ifdef _TEST_SYMBOLS_
int main(int argc, char* argv[]) {
   int i, n;
   FILE* in;
   char string[256];
   symbol_t ts;
   entry_t* dado;

   if (argc!=3) {
      printf("Uso: %s <int> <file>, where <int> is the number of lines\n", argv[0]);
      printf("     in the file <file>.\n");
      exit(-1);
   }
   n = atoi(argv[1]);
   in = fopen(argv[2], "r");
   if (!in) {
      printf("Error: could not find file %s!\n", argv[2]);
      exit(-1);
   }
   init_table(&ts);
   dado = lookup(ts, "Nicolas");
   if (dado == NULL)
	   printf("Test of a look-up in an empty table... Ok.\n");
   else
	   printf("Test of a look-up in an empty table... FAILED.\n");
   for (i=0 ; i<n ; i++) {
      fscanf(in, "%s", &string); 
      printf("Trying to insert the string %s in the table...", string);
      dado = (entry_t*)malloc(sizeof(entry_t));
      dado->name = (char*)malloc(sizeof(char)*strlen(string));
      strcpy(dado->name, string);
      insert( &ts, dado );
      printf("... Ok.\n");
   }
   fclose(in);
   /* Make a lookup to verify */
   in = fopen(argv[2], "r");
   for (i=0 ; i<n ; i++) {
      fscanf(in, "%s", &string); 
      printf("Trying to look-up the string %s in the table...\n", string);
      dado = lookup( ts, string );
      if (dado == NULL)
	   printf("Test of look-up(%s)... FAILED.\n", string);
      else {
	   printf("Test of look-up(%s)... Ok. %s = %s.\n", string, string, dado->name);
      }
   }
   fclose(in);
   dado = lookup(ts, "NiCoLaS");
   if (dado == NULL)
	   printf("Test of a look-up of something weird... Ok.\n");
   else
	   printf("Test of a look-up of something weird... FAILED.\n");
   
   print_table(ts);
   return(0);
}
#endif

#endif
