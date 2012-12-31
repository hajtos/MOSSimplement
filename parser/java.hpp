#ifndef PARSER_HPP
#include "parser.hpp"
#endif
using namespace std;

class JavaParser : public Parser {
public:
  JavaParser();
  bool setCtagsData(char*);
  void parseFile(ifstream&);
  char* getParsedFile();
};
