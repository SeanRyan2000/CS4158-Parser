%{
    #include <stdlib.h>
    #include <string.h>
    #include "parse.tab.h"
%}

%option caseless
%option noyywrap
%option yylineno

/* rule section */
%%
[ \t\n]+         	{}  /* Ignore whitespace */
[\.]             	{ return TERMINATOR; }
[;]             	{ return CONCATENATOR; }
START            	{ return START; }
END              	{ return END; }
MAIN             	{ return MAIN; }
MOVE             	{ return MOVE; }
ADD             	{ return ADD; }
TO               	{ return TO; }
INPUT            	{ return INPUT; }
PRINT            	{ return PRINT; }

[S]+             	{ yylval.ival = strlen(yytext); return INT_SIZE; }
[_A-Z][0-9A-Z-]* 	{ char* temp = (char*) calloc(strlen(yytext)+1, sizeof(char)); strcpy(temp, yytext); yylval.sval = temp; return IDENTIFIER; }
[0-9]+           	{ yylval.ival = atoi(yytext); return NUMBER; }
\"(\\.|[^"\\])*\" 	{ yylval.sval = strdup(yytext); return STRING; }

%%

