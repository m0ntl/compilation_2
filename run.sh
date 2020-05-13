/bin/bash

rm lex.yy.c  olympics.tab.c  olympics.tab.h olympics.c

flex olymp.lex
bison -d olympics.y
gcc -o olympics.c olympics.tab.c lex.yy.c
./olympics input.txt

