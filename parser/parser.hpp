#include <fstream>

#define PARSER_HPP
using namespace std;

class Parser {
public:
  virtual bool setCtagsData(char*) = 0;
  virtual void parseFile(ifstream&) = 0;
  virtual char* getParsedFile() = 0;
  virtual ~Parser() {};
};
