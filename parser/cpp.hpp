#ifndef PARSER_HPP
#include "parser.hpp"
#endif
#include <set>
#include <vector>
#include <cstring>
using namespace std;

enum Type {Class, Macro, Function, Local, Member, Namespace, Prototype, Struct, Typedef, Union, Variable, External, Other};

struct Record {
  Type type;
  char *name;
  int line;
  Record(char *name, Type type, int line) {
    this->type = type;
    this->name = name;
    this->line = line;
  }
  Record(const Record &record) {
    this->type = record.type;
    this->name = record.name;
    this->line = record.line;
  }
  bool operator<(const Record &record) const {
    return strcmp(name, record.name)<0;
  }
};

class CppParser : public Parser {
  vector<char*> data;
  //set<Record> data;
  char *output;
public:
  CppParser();
  ~CppParser();
  bool setCtagsData(char*);
  void parseFile(ifstream&);
  char* getParsedFile();
};
