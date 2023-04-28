all: bucol

bucol: 
	flex parse.l&&bison -d parse.y&&gcc lex.yy.c parse.tab.c

clean:
	rm -f parse lex.yy.c parse.tab.c parse.tab.h a.out
