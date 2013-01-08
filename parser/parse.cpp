#include <iostream>
#include <fstream>
#include <cctype>
#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <cassert>
#include <unistd.h>
#include <sys/types.h>
#include <sys/time.h>
#include "cpp.hpp"
#include "java.hpp"
#include "parse.hpp"
using namespace std;

char* Parse::execCMD(char *cmd) {
  FILE *pipe = popen(cmd, "r");
  if(pipe==NULL) return NULL;
  fd_set set;
  struct timeval timeout;
     
  /* Initialize the file descriptor set. */
  FD_ZERO (&set);
  FD_SET (pipe, &set);
     
  /* Initialize the timeout data structure. */
  timeout.tv_sec = 1;
  timeout.tv_usec = 0;
  if(select (FD_SETSIZE, &set, NULL, NULL, &timeout) < 0) {
    cerr << "select failure" << endl;
    return NULL;
  }
  fseek(pipe, 0, SEEK_END);
  int fileSize = ftell(pipe);
  fseek(pipe, 0, SEEK_SET);
  if(fileSize < 0) {
    cerr << "execCMD: fileSize < 0" << endl;
    return NULL;
  }
  char *buffer = new char[fileSize+1];
  int readed = fread(buffer, 1, fileSize, pipe);
  if(readed == 0 && !feof(pipe)) return NULL;
  buffer[readed] = '\0';
  return buffer;
}

char* Parse::parse(char *file) {
//czy plik istnieje?
  ifstream ifs(file, ifstream::in);
  if(!ifs.is_open()) {
    cerr << "nie można odczytać wskazanego pliku" << endl;
    return NULL;
  }
//wczytuje ctags
  const char command[] = "ctags -x --verbose --c++-kinds=cdefglmnpstuvx ";  //c++kinds only for debug
  char cmd[strlen(file)+strlen(command)+1];
  cmd[0]='\0';
  strcat(cmd, command);
  strcat(cmd, file);

  //printf("%s\n", cmd);

  char *result = execCMD(cmd);
 
  //printf("%s\n", result);
  
  if(result==NULL) {
    cerr << "ctags failed" << endl;
    return NULL;
  }
//wyłuskuje język i znalezione deklaracje
  const char temp[] = "OPENING ";
  char pattern[strlen(temp)+strlen(file)+4+1];  //4 dla " as "
  pattern[0] = '\0';
  strcat(pattern, temp);
  strcat(pattern, file);
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

  Parser *parser = NULL;

  if(strcmp(language, "C++")==0) {
    parser = new CppParser();
  } else if(strcmp(language, "Java")==0) {
    parser = new JavaParser();
  }

  parser->setCtagsData(ctagsData);
  parser->parseFile(ifs);
  char *output = parser->getParsedFile();

  if(output==NULL) return NULL;
//printf("%s\n", output);
  char *data = new char[strlen(output)];
  data[0] = '\0';
  strcat(data, output);

  delete result;
  if(parser!=NULL) delete parser;
  return data;
  return output;
}
