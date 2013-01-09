#include "cpp.hpp"
#include <cstring>
#include <string>
#include <fstream>
#include <cstdlib>
#include <iostream>

#define LETTER 'a'
using namespace std;

CppParser::CppParser() {
  output = NULL;
}

CppParser::~CppParser() {
  if(output!=NULL) delete[] output;
}

bool CppParser::setCtagsData(char *str) {
  char *nlPtr = str;
//name  type  line  stuff \n
  do {
    char *nlPtrTemp = strchr(nlPtr, '\n');
    char *name = strtok(nlPtr, " ");
    nlPtr = nlPtrTemp;
    data.push_back(name);
    nlPtr++;  //ustawiam kursor na nie \n
    if(*nlPtr=='\0') break;  //ostatnia linijka ma \n, ale potem jest \0
  } while(true);  //czytam każdą linijkę, aż nie ma linijek
  return true;
}

void CppParser::parseFile(ifstream &ifs) {
  ifs.seekg(0, ios::end);
  int length = ifs.tellg();
  ifs.seekg(0, ios::beg);
  char *buffer = new char[length];
  output = new char[length+1];
//wczytuje plik
  ifs.read(buffer, length);
  ifs.close();

//szukam wszystkim identyfikatorów
  char *c1, *c2, *dest;
  c1 = c2 = buffer;
  dest = output;
  vector<unsigned short int> nl;
  while(c1 < buffer+length) {
    if(*c1 == '\n') nl.push_back(c1-buffer+1);
    else if(!isblank(*c1)) {  //UWAGA!! wszytkie whitespace wylatują
      c2 = c1;
      while(c2 < buffer+length && (isalpha(*c2) || *c2 == '_' || isdigit(*c2))) c2++;
      if(c2==c1) *dest = *c1;
      else {  //identifier znaleziony
        bool found = false;
        char temp = *c2;
        *c2 = '\0';
        for(vector<char*>::iterator it = data.begin(); it!=data.end(); it++) {
          if(strcmp((*it), c1)==0 && !isKnown(*it)) {
            string temp(*it);
            found = true; break;
          }
        }

        /*for(set<Record>::iterator it = data.begin(); it!=data.end(); it++) {
          if(strcmp((*it).name, c1)==0) {
            found = true; break;
          }
          }*/
        *c2 = temp;  //get over \0
        if(found) {
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
//c1 wskazuje na buffer+length, czyli na \0, ale nie przeniosło do output
  *dest = '\0';
  //cout << dest << endl << buffer << endl;
  string nls = "\n//";
  char temp[15];
  for(vector<unsigned short int>::iterator it = nl.begin(); it!=nl.end(); it++) {
    snprintf(temp, 15, "%d", *it);
    nls += temp; nls += "|";
  }
  char *newOutput = new char[dest-output+1+nls.size()];
  int outputEnd = dest-output;
  memcpy(newOutput, output, outputEnd);
  memcpy(newOutput+outputEnd, nls.c_str(), nls.size()+1);
  delete[] output;
  output = newOutput;
  delete[] buffer;
}

char* CppParser::getParsedFile() {
  return output;
}

/*
  char keywords[][] = {"asm", "do", "if", "return", "try", "auto", "double", "inline", "short", "typedef", "bool", "dynamic_cast", "int", "signed", "typeid", "break", "else", "long", "sizeof", "typename", "case", "enum", "mutable", "static", "union", "catch", "explicit", "namespace", "static_cast", "unsigned", "char", "extern", "new", "struct", "using", "class", "export", "operator", "switch", "virtual", "const", "false", "private", "template", "void", "const_cast", "float", "protected", "this", "volatile", "continue", "for", "public", "throw", "wchar_t", "default", "friend", "register", "true", "while", "delete", "goto", "reinterpret_cast"};
*/
