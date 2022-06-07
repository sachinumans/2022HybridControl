SRC = hys.y hys.l hys2xml.c
OBJ = hys.tab.o lex.yy.o hys2xml.o 


all:
	cd hys2xml ; make ; make clean ; cd ..
	cd @xmltree/private ; make ; cd ../..

clean:
	cd hys2xml ; make realclean ; cd ..
	cd @xmltree/private ; make clean ; cd ../..
