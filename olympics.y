/* Adam Montlake - 200482131
 Roi Naftali - 305743494 */

%code {
#include <stdio.h>

  /* yylex () and yyerror() need to be declared here */
extern int yylex (void);
void yyerror (const char *s);
}

%code requires {
    struct t_years {
         int total_years; 
         int number_sports; 
    };
}


/* note: no semicolon after the union */
%union {
  char name[20];
  int ival;
  double avg;
  struct t_years _t_years;
}

%token TITLE SPORT YEARS ALL SINCE THROUGH COMMA SPORT_INFO
%token <name> NAME
%token <ival> YEAR_NUM

%type <_t_years> list_of_sports sport_info
%type <ival> list_of_years
%type <ival> year_spec
%error-verbose

%%

input: TITLE list_of_sports
 {
  
  double avg = ((double)$2.total_years)/$2.number_sports;
	printf("\naverage number of games per sport: %f\n", avg);
};

list_of_sports: list_of_sports sport_info {
	$$.total_years = $1.total_years + $2.total_years;
	$$.number_sports = $1.number_sports + 1;
};

list_of_sports: /* empty */ { 
	$$.total_years = 0;
	$$.number_sports = 0;
};

sport_info: SPORT NAME YEARS list_of_years {
	$$.total_years = $4;
  if($4 >= 7) {
    printf("%s\n", $2);
  }
};

list_of_years: list_of_years COMMA year_spec{
	$$ = $1 + $3;
};

list_of_years: year_spec{
	$$ = $1;
};

year_spec: 
	YEAR_NUM
   { 
     if($1==2020)
     {
       $$ = 0;
     }    
     else
     $$ = 1;} |
	
ALL {$$ = (2016 - 1896) / 4 + 1;} |
	YEAR_NUM THROUGH YEAR_NUM {$$ = ($3 - $1)/4 + 1; } |
	SINCE YEAR_NUM {$$ = (2016 - $2)/4 + 1; }
;

%%

int
main (int argc, char **argv)
{
  extern FILE *yyin;
  if (argc != 2) {
     fprintf (stderr, "Usage: %s <input-file-name>\n", argv[0]);
	 return 1;
  }
  yyin = fopen (argv [1], "r");
  if (yyin == NULL) {
       fprintf (stderr, "failed to open %s\n", argv[1]);
	   return 2;
  }
    printf("sports which appeared in at least 7 olympic games\n");

  yyparse ();
  
  fclose (yyin);
  return 0;
}

void yyerror (const char *s)
{
  extern int line;
  fprintf (stderr, "line %d: %s\n", line, s);
}

