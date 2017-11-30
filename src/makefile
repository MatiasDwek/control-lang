CC = g++ -std=c++11

all: lex.yy.c y.tab.c control control2

control: 
	$(CC) -c lex.yy.c y.tab.c 

control2: y.tab.o lex.yy.o
	$(CC)  treenode.cpp printcode.cpp symbol.cpp -o control y.tab.o lex.yy.o

y.tab.c: control.y
	yacc -dtv control.y

lex.yy.c: control.l
	lex control.l
	
clean:
	rm -rf *~ lex.yy.o y.tab.o control
