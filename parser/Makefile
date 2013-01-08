CC = g++
CFLAGS = -c -Wall -g
OBJ = cpp.o java.o parse.o

all : main2

%.o : %.cpp %.hpp
	$(CC) $(CFLAGS) $< -o $@

main : $(OBJ) main.o
	$(CC) -g $(OBJ) main.o -o main

main2.o : main2.cpp
	$(CC) -g -c main2.cpp

main2 : $(OBJ) main2.o
	$(CC) -g $(OBJ) main2.o -o main2

clean :
	rm -f *.o

test : main
	./main testy/fibbonaci.cpp

.PHONY: clean test
