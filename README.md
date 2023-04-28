# CS4158-Parser

Run the following commands in the terminal to automatically run the program:

``` 
chmod +x ./run.sh
```
```
./run.sh
```

Else:

You can make the file without running :
```
make
```

This will create a a.out which you can run with:
```
./a.out
```

If you want to automatically add a file to run as an input stream you can use the follow:
``` 
./a.out > Valid.example
```
Replace valid.example with the file of your choosing.


If you want to delete all the generated files from flex or bison run 
```
make clean
```
