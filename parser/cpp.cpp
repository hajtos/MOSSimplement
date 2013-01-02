#include "cpp.hpp"
#include <cstring>
#include <string>
#include <fstream>
#include <cstdlib>
#include <iostream>

#define LETTER 'a'
using namespace std;

CppParser::CppParser() {

}

CppParser::~CppParser() {
  delete output;
}

bool CppParser::setCtagsData(char *str) {
  char *nlPtr = str;
//name  type  line  stuff \n
  do {
    char *nlPtrTemp = strchr(nlPtr, '\n');
    char *name = strtok(nlPtr, " ");
    char *temp = new char[strlen(name)];
    temp[0] = '\0';
    strcat(temp, name);
    name = temp;
    char *type = strtok(NULL, " ");
    int line = atoi(strtok(NULL, " "));
    Type t;
    if(strcmp(type, "class")==0) {
      t = Class;
    } else if(strcmp(type, "function")==0) {
      t = Function;
    } else if(strcmp(type, "member")==0) {
      t = Member;
    } else if(strcmp(type, "variable")==0) {
      t = Variable;
    } else if(strcmp(type, "local")==0) {
      t = Local;
    } else {
      t = Other;
    }
    //Record record = Record(name, t, line);
    nlPtr = nlPtrTemp;
    //cout << name << endl;
    //cout << record.name << ' ' << record.type << ' ' << record.line << ' ' << endl;
    data.push_back(name);
    nlPtr++;  //ustawiam kursor na nie \n
    if(*nlPtr=='\0') break;  //ostatnia linijka ma \n, ale potem jest \0
  } while(true);  //czytam każdą linijkę, aż nie ma linijek
  /*for(vector<char*>::iterator it = data.begin(); it!=data.end(); it++) {
  //cout << it->name << ' ' << it->type << ' ' << it->line << ' ' << endl;
  printf("%s\n", *it);
  }*/
  return true;
}

void CppParser::parseFile(ifstream &ifs) {
  ifs.seekg(0, ios::end);
  int length = ifs.tellg();
  ifs.seekg(0, ios::beg);
  char *buffer = new char[length];
  output = new char[length];
//wczytuje plik
  ifs.read(buffer, length);
  ifs.close();

//szukam wszystkim identyfikatorów
  char *c1, *c2, *dest;
  c1 = c2 = buffer;
  dest = output;
  while(c1 < buffer+length) {
    if(!isblank(*c1)) {  //UWAGA!! wszytkie whitespace wylatują
      c2 = c1;
      while(c2 < buffer+length && (isalpha(*c2) || *c2 == '_' || isdigit(*c2))) c2++;
      if(c2==c1) *dest = *c1;
      else {  //identifier znaleziony
        char *target = NULL;
        char temp = *c2;
        *c2 = '\0';
        for(vector<char*>::iterator it = data.begin(); it!=data.end(); it++) {
          if(strcmp((*it), c1)==0) {
            target = *it; break;
          }
        }
        *c2 = temp;  //get over \0
        if(target!=NULL) {
          *dest = LETTER;
          while(c1+1 < c2) c1++;
        } else {
          while(c1+1 < c2) {
            *dest=*c1; c1++; dest++;
          }
          *dest=*c1;
        }
      }
      dest++;
    }
    c1++;
  }
}

char* CppParser::getParsedFile() {

  return output;
}

/*
  char keywords[][] = {"asm", "do", "if", "return", "try", "auto", "double", "inline", "short", "typedef", "bool", "dynamic_cast", "int", "signed", "typeid", "break", "else", "long", "sizeof", "typename", "case", "enum", "mutable", "static", "union", "catch", "explicit", "namespace", "static_cast", "unsigned", "char", "extern", "new", "struct", "using", "class", "export", "operator", "switch", "virtual", "const", "false", "private", "template", "void", "const_cast", "float", "protected", "this", "volatile", "continue", "for", "public", "throw", "wchar_t", "default", "friend", "register", "true", "while", "delete", "goto", "reinterpret_cast"};
*/
