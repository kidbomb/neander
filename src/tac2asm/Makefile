compilador: lex.yy.c y.tab.c symbol-table.o
	gcc -o tac2asm y.tab.c symbol-table.o -ly -lfl

lex.yy.c: lexer.l
	flex lexer.l

y.tab.c: parser.y
	yacc -d parser.y

symbol-table.o: symbol-table.c symbol-table.h
	$(CC) $(OPT) -c symbol-table.c

clean:
	rm -f tac2asm lex.yy.c  y.tab.c  y.tab.h *.o
