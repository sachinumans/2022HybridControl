PREFIX=yy
#YACC = BISON_PKGDATADIR=`pwd` `which bison-1.875`
YACC = BISON_PKGDATADIR=`pwd` `which bison`
#YACC = /home/michal/progs/hys2xml/bison-1.875
LEX  = flex
YFLAGS = -d -S yaxx.c
XFLAGS =
CFLAGS  = ${XFLAGS} -Os
LFLAGS  =
BIN = .
CC = gcc


SRC = hys.y hys.l hys2xml.c
OBJ = hys.tab.o lex.yy.o hys2xml.o 

all: $(OBJ)
	${CC} $(CFLAGS) $(OBJ) -o hys2xml

%.tab.c: %.y
	${YACC} ${YFLAGS} $<
	
lex.yy.c: hys.l
	${LEX} $<

lex.yy.o: lex.yy.c
	${CC} -c ${CFLAGS} $< -o $@

lex.yy.o: hys.tab.h
hys.tab.h: hys.tab.c

clean   :
	rm -f hys.tab.h hys.tab.c hys.output lex.yy.c *.o *.dtd *.xml

realclean:
	${MAKE} clean
	rm -f hys2xml
