#ifndef PARSER_HPP
#include "parser.hpp"
#endif
#include <set>
using namespace std;

enum Type {Class, Macro, Function, Local, Member, Namespace, Prototype, Struct, Typedef, Union, Variable, External, Other};

struct Record {
  Type type;
  string name;
  int line;
  Record(string name, Type type, int line) {
    this->type = type;
    this->name = name;
    this->line = line;
  }
  bool operator<(const Record &record) const {
    return name.compare(record.name)==0;
  }
};

class CppParser : public Parser {
  set<Record*> data;
  char *output;
public:
  CppParser();
  ~CppParser();
  bool setCtagsData(char*);
  void parseFile(ifstream&);
  char* getParsedFile();
};
