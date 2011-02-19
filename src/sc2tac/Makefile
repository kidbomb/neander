compilador: lex.yy.c y.tab.c symbol-table.o spaghetti-stack.o
	gcc -o sc2tac y.tab.c symbol-table.o spaghetti-stack.o -ly -lfl

lex.yy.c: lexer.l
	flex lexer.l

y.tab.c: parser.y
	yacc -d parser.y

symbol-table.o: symbol-table.c symbol-table.h
	$(CC) $(OPT) -c symbol-table.c

spaghetti-stack.o: spaghetti-stack.c spaghetti-stack.h
	$(CC) $(OPT) -c spaghetti-stack.c

clean:
	rm -f sc2tac lex.yy.c  y.tab.c  y.tab.h *.o
