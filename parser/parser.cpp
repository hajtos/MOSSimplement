#include <iostream>
#include <fstream>
#include <cctype>
#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <cassert>
#include "cpp.hpp"
#include "java.hpp"
using namespace std;

char* execCMD(char *cmd) {
  FILE *pipe = popen(cmd, "r");
  if(pipe==NULL) return NULL;
  fseek(pipe, 0, SEEK_END);
  int fileSize = ftell(pipe);
  fseek(pipe, 0, SEEK_SET);
  char *buffer = new char[fileSize+1];
  int readed = fread(buffer, 1, fileSize, pipe);
  if(readed == 0 && !feof(pipe)) return NULL;
  buffer[readed] = '\0';
  return buffer;
}

int main(int argc, char **argv) {
  if(argc < 2) {
    cerr << "musisz podać plik jako argument" << endl;
    return -1;
  }
//czy plik istnieje?
  ifstream ifs(argv[1], ifstream::in);
  if(!ifs.is_open()) {
    cerr << "nie można odczytać wskazanego pliku" << endl;
    return -1;
  }
//wczytuje ctags
  const char command[] = "ctags -x --verbose --c++-kinds=cdefglmnpstuvx ";  //c++kinds only for debug
  char cmd[strlen(argv[1])+strlen(command)+1];
  cmd[0]='\0';
  strcat(cmd, command);
  strcat(cmd, argv[1]);

  //printf("%s\n", cmd);

  char *result = execCMD(cmd);
 
  //printf("%s\n", result);
  
  if(result==NULL) {
    cerr << "ctags failed" << endl;
    return -1;
  }
//wyłuskuje język i znalezione deklaracje
  const char temp[] = "OPENING ";
  char pattern[strlen(temp)+strlen(argv[1])+4+1];  //4 dla " as "
  pattern[0] = '\0';
  strcat(pattern, temp);
  strcat(pattern, argv[1]);
  strcat(pattern, " as ");

  //cout << pattern << endl;

  int pos = strstr(result, pattern)-result+strlen(pattern);
  assert(pos > 0 && pos < (int)strlen(result));
  int pos2 = strchr(result+pos, ' ')-result;
  char* language = result+pos;
  *(result+pos2) = '\0';
//muszę przesunąć ctagsData do początku informacji
  char *ctagsData = result+pos2+1;
  int nlCounter = 3;
  while(nlCounter > 0) {
    if(*ctagsData=='\n') nlCounter--;
    ctagsData++;
  }

  printf("%s\n", language);
  printf("%s\n", ctagsData);

  Parser *parser;

  if(strcmp(language, "C++")==0) {
    parser = new CppParser();
  } else if(strcmp(language, "Java")==0) {
    parser = new JavaParser();
  }

  parser->setCtagsData(ctagsData);
  parser->parseFile(ifs);
  char *output = parser->getParsedFile();

  if(output!=NULL) printf("%s\n", output);

  delete result;
  return 0;
}
