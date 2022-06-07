MEX = mex
EXARCH=mexglx

TARGETS = sub_allchildren.{EXARCH} xml_cell_find.{EXARCH} xml_findstr.{EXARCH}
#OBJ = hys.tab.o lex.yy.o hys2xml.o 

#all: $(OBJ)
#	${CC} $(CFLAGS) $(OBJ) -o hys2xml.lnx

all: $(TARGETS)

sub_allchildren.{EXARCH}: sub_allchildren.c
	${MEX} sub_allchildren.c
	
xml_cell_find.{EXARCH}: xml_cell_find.c
	${MEX} xml_cell_find.c
	
xml_findstr.{EXARCH}: xml_findstr.c
	${MEX} xml_findstr.c

clean   :
	rm -f *.${EXARCH}
