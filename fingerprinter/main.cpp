#include <list>
#include <iostream>
#include <cstdio>
#include <fstream>
#include <errno.h>

using namespace std;
#include "fingerprinter.h"

char* input_directory;
char* output_directory;
char* temp_directory;


int main() {
  ifstream config("config");
  output_directory = new char[1024];
  config.getline(output_directory,1024);
  input_directory = new char[1024];
  config.getline(input_directory,1024);
  temp_directory = new char[1024];
  config.getline(temp_directory,1024);

  int fd = inotify_init();
  int watch = inotify_add_watch(fd, input_directory, IN_CREATE | IN_MOVED_TO);
  if(watch<0) {
    cerr << "inotify_add_watch failed" << endl;
    return -1;
  }

  char    buf [1024 * (sizeof(inotify_event) + 16)];
  ssize_t length;
  while((length = read(fd, buf, sizeof(buf)))>0) {
    inotify_event *event;
    //szukanie pliku
    for (size_t i = 0; i < static_cast<size_t>(length); i += sizeof(inotify_event) + event->len) {
      event = reinterpret_cast<inotify_event *>(&buf[i]);
      if (event->len > 0) {
        try {
          //przenoszenie pliku
          string from = input; from += "/"; from += event->name;
          string to = output; to += "/"; to += event->name;
          rename(from.c_str(), to.c_str());

          //dzialanie na pliku
          ifstream found(to);
          Fingerprinter fp(found,event->name,output_directory);
          fp.loadHeader();
          fp.searchPrints();
          found.close();
          fp.dumpResults();
        } catch (...) {
          //path = "Fail/";
          cout << "Boo" << endl;
          //path+="file";
          //MoveFile(path2.c_str(),path.c_str());
        }
      }
    }
  }
  return 0;
}

