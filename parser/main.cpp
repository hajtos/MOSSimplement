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
  char *out = parse.parse((const char*)argv[1]);
  if(out != NULL) printf("%s\n", out);
  return 0;
}
