win_flex olymp.lex
win_bison –d olympics.y
gcc -o olympics.exe lex.yy.c olympics.tab.c
olympics.exe input.txt
