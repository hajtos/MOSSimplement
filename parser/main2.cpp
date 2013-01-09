#include <iostream>
#include <cstdio>
#include <cstring>
#include <string>
#include <unistd.h>
#include <sys/inotify.h>
#include <fstream>
#include <cctype>
#include <vector>
#include <thread>
#include <exception>
#include "parse.hpp"
using namespace std;

char output[1024], input[1024], temp[1024];

void processFile(string *src) {
  const char *source = src->c_str();
  Parse parse = Parse();
  char *out = NULL;
  string from = input; from += "/"; from += source;
  string to = temp; to += "/"; to += source;
  if(rename(from.c_str(), to.c_str()) < 0) {
    cerr << "rename failed" << endl;
    return;
  }
  out = parse.parse(to.c_str());
  if(out == NULL) {
    cerr << "wystąpił błąd przy parsowaniu" << to << endl;
  } else {
    string dest = output; dest += "/"; dest += source;
    FILE *destFile = fopen(dest.c_str(), "w");
    if(destFile == NULL) {
      cerr << "nie można otworzyć pliku " << dest << endl;
      return;
    }
    //printf("%p\n", destFile);
    if(fprintf(destFile, "%s", out) < 0) {
      cerr << "fprintf failed" << endl;
      return;
    }
    fclose(destFile);
  }
  if(remove(to.c_str()) < 0) {
    cerr << "nie można usunąć " << to << endl;
    return;
  }
  delete[] out;
  delete src;
}

int main(int argc, char **argv) {
  char config[100] = "config.conf";
  ifstream conf(config, ifstream::in);
  if(!conf.is_open()){
    cerr << "nie można odczytać konfiguracji" << endl;
    return -1;
  }
  conf.getline(output, 1024);
  conf.getline(input, 1024);
  conf.getline(temp, 1024);

  int fd = inotify_init();
  int watch = inotify_add_watch(fd, input, IN_CREATE | IN_MOVED_TO);
  if(watch<0) {
    cerr << "inotify_add_watch failed" << endl;
    return -1;
  }

  char    buf [1024 * (sizeof(inotify_event) + 16)];
  ssize_t length;
  vector<thread*> threads;
  //const unsigned int excessive = 15;
  while((length = read(fd, buf, sizeof(buf)))>0) {
    inotify_event *event;
    /*f(threads.size() > excessive) {
      for(unsigned int i = 0; i < threads.size(); i++) {
        if(threads[i]->joinable()) threads[i]->join();
        delete threads[i];
      }
      threads.erase(threads.begin(), threads.end());
      }*/
    for (size_t i = 0; i < static_cast<size_t>(length); i += sizeof(inotify_event) + event->len) {
      event = reinterpret_cast<inotify_event *>(&buf[i]);
      if (event->len > 0) {
        if(isalpha(event->name[0]) == 0) continue;  //pomijam 'dziwne' pliki; które mają nazwę start od nie alpha
        printf("The file %s was created.\n", event->name);
        try {
          string *target = new string(event->name);
          threads.push_back(new thread(processFile, target));
        } catch(exception e) {
          cerr << e.what() << endl;
        }
      }
    }
  }
}
