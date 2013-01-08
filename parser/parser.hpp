#include <fstream>
#include <set>

#define PARSER_HPP
using namespace std;

class Parser {
  set<string> known;
public:
  virtual bool setCtagsData(char*) = 0;
  virtual void parseFile(ifstream&) = 0;
  virtual char* getParsedFile() = 0;
  virtual ~Parser() {};
  void addKnown(const string&);
  bool isKnown(const string&);
  bool isKnown(char const*);
};
