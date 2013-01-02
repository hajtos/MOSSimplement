CC = g++
CFLAGS = -c -Wall -g
OBJ = cpp.o java.o parser.o

all : parser

%.o : %.cpp %.hpp
	$(CC) $(CFLAGS) $< -o $@

parser : $(OBJ)
	$(CC) $(OBJ) -o parser

clean :
	rm -f *.o

test : 
	./parser testy/fibbonaci.cpp

.PHONY: clean test
