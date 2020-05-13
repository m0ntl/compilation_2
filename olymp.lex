/* Adam Montlake - 200482131
 Roi Naftali - 305743494 */
%{
#include <string.h> 
#include "olympics.tab.h"

extern int atoi (const char *);
int line = 1;
%}

%option noyywrap

/* exclusive start condition -- deals with C++ style comments */ 
%x COMMENT

%%


[[:digit:]]{4}        { yylval.ival = atoi (yytext); return YEAR_NUM; }
"Olympic Games"       { return TITLE; }
"<sport>"             {  return SPORT;}
","                   {return COMMA;}
\"[[:alpha:]\ ]+\"    {  strcpy(yylval.name,yytext); return NAME; }
"<years>"             {  return YEARS; }
"all"                 {  return ALL; }
"since"               {  return SINCE; }
"-"|"through"         {  return THROUGH; }

[\n\t ]+  /* skip white space */
.          { fprintf (stderr, "unrecognized token %c\n", yytext[0]); }

%%

