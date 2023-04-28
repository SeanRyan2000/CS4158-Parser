# Generates lex.yy.c
flex parse.l

# Generates y.tab.c and y.tab.h
bison -d parse.y

# Compiles C files
gcc -c lex.yy.c parse.tab.c
gcc -o output lex.yy.o parse.tab.o -ll

# Execute output
./output < test.jibuc