flex parse.l && bison -d parse.y && gcc lex.yy.c parse.tab.c 

# Execute output
echo "Running Valid Example"
./a.out < Valid.example
echo "Valid Example Completed"
echo ""
echo ""

echo "Running Invalid Example"
./a.out < Invalid.example
echo "Invalid Example Completed"
echo ""
echo ""

# ./output < test.jibuc