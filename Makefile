all: bucol

bucol: parse.l parse.y
	flex parse.l
	bison -d parse.y
	gcc -o parse parse.tab.c lex.yy.c -lfl

clean:
	rm -f parse lex.yy.c parse.tab.c parse.tab.h
