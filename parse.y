%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <stdbool.h>
    #include <string.h>

    extern int yylex();
    extern int yyparse();
    extern int yylineno;
    extern FILE *yyin;

    // Declarations
    void yyerror(char *s);
    void trimVariable(char *variable);
    void createVariable(int variableSize, char *variableName);
    void checkVariable(char *variable);
    bool isVariable(char *variable);
    int getVariableSizeFromArray(char *variable);
    void getFirstVariable(char *variable);
    void moveIntegerToVariable(int integer, char *variable);
    void moveVariableToVariable(char *variableOne, char *variableTwo);
    int getNumberOfDigitsInInteger(int integer);

    // Tables
    char variableArray[100][32];
    int variableSizes[100];
    int numberOfVariables = 0;

%}

%union {
    int ival;
    char* sval;
}

%token <ival> NUMBER
%token <ival> INT_SIZE
%token <sval> IDENTIFIER
%token START MAIN END MOVE ADD INPUT PRINT TO TERMINATOR CONCATENATOR STRING

%%

program:
        START TERMINATOR declarations {}
        ;
declarations:
        declaration declarations {}
        | body
        ;
declaration:
        INT_SIZE IDENTIFIER TERMINATOR { createVariable($1, $2); }
        ;
body:
        MAIN TERMINATOR code {}
        ;
code:
        line code {}
        | end {}
        ;
line:
        print
        | input {}
        | move {}
        | add {}
        ;
print:
        PRINT printStatement {}
        ;
printStatement:
        STRING CONCATENATOR printStatement {}
        | IDENTIFIER CONCATENATOR printStatement { checkVariable($1); }
        | STRING TERMINATOR {}
        | IDENTIFIER TERMINATOR { checkVariable($1); }
        ;
input:
        INPUT inputStatement {}
        ;
inputStatement:
        IDENTIFIER TERMINATOR { checkVariable($1); }
        | IDENTIFIER CONCATENATOR inputStatement { checkVariable($1); }
        ;
move:
        MOVE NUMBER TO IDENTIFIER TERMINATOR { moveIntegerToVariable($2, $4); }
        | MOVE IDENTIFIER TO IDENTIFIER TERMINATOR { moveVariableToVariable($2, $4); }
        ;
add:    ADD NUMBER TO IDENTIFIER TERMINATOR { moveIntegerToVariable($2, $4); }
        | ADD IDENTIFIER TO IDENTIFIER TERMINATOR { checkVariable($2); checkVariable($4); }
        ;
end:
        END TERMINATOR {exit(EXIT_SUCCESS);}
        ;

%%

int main(void)
{
    yyparse();
    return 0;
}

void yyerror(char *s)
{
    fprintf(stderr, "Error [Line %d]: %s.\n", yylineno, s);
}

// Trims the '.' from the end of a variable name
void trimVariable(char *variable)
{
    int lastIndex = strlen(variable) - 1;
    if (variable[lastIndex] == '.')
    {
        variable[lastIndex] = '\0';
    }
}

// Creates a variable
void createVariable(int variableSize, char *variableName)
{
    trimVariable(variableName);
    
    // If variable does not exist
    if(isVariable(variableName) == false)
    {
        strcpy(variableArray[numberOfVariables], variableName);
        variableSizes[numberOfVariables] = variableSize;
        numberOfVariables++;
    }
    else
    {
        printf("Error: Variable '%s' already exists.\n", variableName);
        exit(EXIT_FAILURE);
    }
}

    void checkVariable(char *variable)
{
    trimVariable(variable);

    if (isVariable(variable) == false)
    {
        printf("Error: Variable '%s' does not exist.\n", variable);
        exit(EXIT_FAILURE);
    }
}

bool isVariable(char *variable)
{
    char *comparisonVariable = variable;
    if (comparisonVariable[0] == '_')
    {
        comparisonVariable++;
    }

    for (int i = 0; i < numberOfVariables; i++)
    {
        char *storedVariable = variableArray[i];
        if (storedVariable[0] == '_')
        {
            storedVariable++;
        }

        if (strcmp(storedVariable, comparisonVariable) == 0)
        {
            return true;
        }
    }
    return false;
}


    int getVariableSizeFromArray(char *variable)
    {
        for(int i = 0; i < numberOfVariables; i++)
        {
            if(strcmp(variableArray[i], variable) == 0)
            {
                return variableSizes[i];
            }
        }
        return -1;
    }

    void getFirstVariable(char *variable)
    {
        strcpy(variable, variableArray[0]);
    }

    void moveIntegerToVariable(int integer, char *variable)
    {
        checkVariable(variable);
    }

    void moveVariableToVariable(char *variableOne, char *variableTwo)
    {
        checkVariable(variableOne);
        checkVariable(variableTwo);
    }

    int getNumberOfDigitsInInteger(int integer)
    {
        int i = 0;
        for(i = 0; integer != 0; i++)  
        {
            integer /= 10;
        }
        return i;
    }
