#include <iostream>
#include "parser.hpp"
using namespace std;

void Parser::addKnown(const string &str) {
  known.insert(str);
}

bool Parser::isKnown(const string &str) {
  return known.find(str)!=known.end();
}

bool Parser::isKnown(char const *str) {
  //return true;
  return known.find(str)!=known.end();
}
