/bin/bash

rm lex.yy.c  olympics.tab.c  olympics.tab.h olympics.c

flex olymp.lex
bison -d olympics.y
gcc  olympics.tab.c lex.yy.c -o olympics.c 
./olympics input.txt

