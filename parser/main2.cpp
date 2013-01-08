#include <iostream>
#include <cstdio>
#include <cstring>
#include <string>
#include <unistd.h>
#include <sys/inotify.h>
#include <dirent.h>
#include <errno.h>
#include <fstream>
#include "parse.hpp"
using namespace std;

int main(int argc, char **argv) {
  char config[100] = "config.conf";
  ifstream conf(config, ifstream::in);
  if(!conf.is_open()){
    cerr << "nie można odczytać konfiguracji" << endl;
    return -1;
  }
  char output[1024], input[1024], temp[1024];
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
  Parse parse = Parse();

  while((length = read(fd, buf, sizeof(buf)))>0) {
    inotify_event *event;
    for (size_t i = 0; i < static_cast<size_t>(length); i += sizeof(inotify_event) + event->len) {
      event = reinterpret_cast<inotify_event *>(&buf[i]);
      if (event->len > 0) {
        printf("The file %s was created.\n", event->name);
        char *out = NULL;
        string from = input; from += "/"; from += event->name;
        string to = output; to += "/"; to += event->name;
        rename(from.c_str(), to.c_str());
        string &filename = to;  //just to keep things old way
        cout << filename << endl;
        out = parse.parse(filename.c_str());
        if(out == NULL) {
          cerr << "wystąpił błąd przy parsowaniu" << filename << endl;
        } else printf("\n", out);
        delete[] out;
        out = NULL;
        //break;
      }
    }/*
//check for files left
DIR *dp;
struct dirent *dirp;
if((dp  = opendir(input)) == NULL) {
cout << "Error(" << errno << ") opening " << input << endl;
return errno;
}
while ((dirp = readdir(dp)) != NULL) {
filename = input;
filename += "/";
filename += dirp->d_name;
if(dirp->d_name[0] != '.') {
cout << filename << endl;
out = parse.parse(filename.c_str());
if(out == NULL) {
cerr << "wystąpił błąd przy parsowaniu" << filename << endl;
} else printf("\n", out);
}
}
closedir(dp);*/
  }
}
