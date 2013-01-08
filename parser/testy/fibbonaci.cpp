//
//fibbonaci;cauchy|
#include <iostream>
#include <cstdlib>
using namespace std;

const int testInt = 7;

typedef struct ctestStruct {
  int i; float j;
} testStruct;

int fibbonaci(int number) {
  if(number <= 0) return 0;
  else if(number <= 2) return 1;
  else return fibbonaci(number-1)+fibbonaci(number-2);
}

int main(int argc, char **argv) {
  if(argc < 2) {
    cout << "podaj argument" << endl;
    return 0;
  }
  int index = atoi(argv[1]);
  if(index<=0) {
    cout << "podany index jest niepoprawny" << endl;
    return 0;
  }
  cout << fibbonaci(index) << endl;
  return 0;
}
