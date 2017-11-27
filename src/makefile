CC = g++ -std=c++11

all: lex.yy.c y.tab.c control control2

control: 
	$(CC) -c lex.yy.c y.tab.c 

control2:
	$(CC)  treenode.cpp printcode.cpp symbol.cpp -o control y.tab.o lex.yy.o

y.tab.c: 
	yacc -dtv control.y

lex.yy.c: 
	lex control.l
	
clean:
	rm -rf *~ lex.yy.o y.tab.o control

