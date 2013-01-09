CC = g++
CFLAGS = -c -Wall -g
OBJ = cpp.o java.o parse.o parser.o

all : main2 main

%.o : %.cpp %.hpp
	$(CC) $(CFLAGS) $< -o $@

main.o : main.cpp
	$(CC) -g -c main.cpp

main : $(OBJ) main.o
	$(CC) -g $(OBJ) main.o -o main

main2.o : main2.cpp
	$(CC) -g -c main2.cpp

main2 : $(OBJ) main2.o
	$(CC) -g $(OBJ) main2.o -o main2

clean : clean-outputs
	rm -f *.o

clean-outputs :
	rm -f output/*

test : main
	./main testy/fibbonaci.cpp

.PHONY: clean test clean-outputs
