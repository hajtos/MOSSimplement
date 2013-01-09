CC = g++
CFLAGS = -Wall -g -std=c++11 -pthread
OBJ = cpp.o java.o parse.o parser.o

all : main2 main

%.o : %.cpp %.hpp
	$(CC) $(CFLAGS) -c $< -o $@

main.o : main.cpp
	$(CC) $(CFLAGS) -c main.cpp

main2.o : main2.cpp
	$(CC) $(CFLAGS) -c main2.cpp

main : $(OBJ) main.o
	$(CC) $(CFLAGS) $(OBJ) main.o -o main

main2 : $(OBJ) main2.o
	$(CC) $(CFLAGS) $(OBJ) main2.o -o main2

clean : clean-outputs
	rm -f *.o

clean-outputs :
	rm -f output/*
	rm -f temp/*

test : main
	./main testy/fibbonaci.cpp

.PHONY: clean test clean-outputs
