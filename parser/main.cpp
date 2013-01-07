#include <iostream>
#include <cstdio>
#include "parse.hpp"
using namespace std;

int main(int argc, char **argv) {
  if(argc < 2) {
    cerr << "musisz podać plik jako argument" << endl;
    return -1;
  }
  Parse parse;
  printf("%s\n", parse.parse(argv[1]));
  return 0;
}
