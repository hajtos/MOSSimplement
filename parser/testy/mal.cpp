#include <iostream>
#include <stdio.h>
#include <set>
using namespace std;

struct Point {
  long int x,y;
  Point() {}
  Point(long int x, long int y) {
    this->x = x; this->y = y;
  }
  Point(const Point &source) {
    this->x = source.x;
    this->y = source.y;
  }
  bool operator<(const Point &point) const {
    return point.x > this->x || point.y > this->y;
  }
};

struct Rect {
  Point ld, ru;
  long int paintCounter;
  Rect() {paintCounter=1;}
  Rect(long int x, long int y) {
    paintCounter=1;
    ld.x = x; ld.y = y;
    ru.x = x; ru.y = y;
  }
  Rect(long int lx, long int ly, long int ux, long int uy) {
    paintCounter=1;
    ld.x = lx; ld.y = ly;
    ru.x = ux; ru.y = uy;
  }
  Rect(long int lx, long int ly, long int ux, long int uy, long int counter) {
    paintCounter=counter;
    ld.x = lx; ld.y = ly;
    ru.x = ux; ru.y = uy;
  }
  Rect(Point pl, Point pu) {
    paintCounter=1;
    ld = pl; ru = pu;
  }
  Rect(Point pl, Point pu, long int counter) {
    paintCounter=counter;
    ld = pl; ru = pu;
  }
  bool operator<(const Rect &rect) const {
    return rect.ru.x > this->ru.x || rect.ru.y > this->ru.y;
  }
  long long int volume() const {
    return (ru.x-ld.x)*(ru.y-ld.y);
  }
};

void message(string str) {
  cout << str << endl;
}

void check(set<Rect> &newRects, const Rect &rect) {
  if(rect.volume()!=0) newRects.insert(rect);
}

int main() {
  ios_base::sync_with_stdio(0);
  long int n;
  cin >> n;
  set<Rect> painted;

  for(long int i=0; i<n; ++i) {
    Rect rect;
    cin >> rect.ld.x >> rect.ld.y >> rect.ru.x >> rect.ru.y;

    if(painted.empty()) {
      painted.insert(rect);
      continue;
    }

    bool test = false;
    set<Rect> toRemove;
    set<Rect> newRects;
    for(set<Rect>::iterator it=painted.begin(); it!=painted.end(); it++) {
      //message("loop");
      //cout << it->ld.x << ' ' << it->ld.y << ' ' << it->ru.x << ' ' << it->ru.y << endl;
      long int size = newRects.size();
      bool p = rect.ld.x < it->ld.x;
      bool q = rect.ld.y < it->ld.y;
      bool s = rect.ru.x < it->ru.x;
      bool t = rect.ru.y < it->ru.y;
      //czy rect zawiera it?
      if(p) {
	if(q) {
	  if(s) {
	    if(t) {
	      //czy rect.ru jest w it?
	      if(rect.ru.x > it->ld.x && rect.ru.y > it->ld.y) {
		check(newRects, Rect(it->ld, rect.ru, it->paintCounter+1));
		check(newRects, Rect(it->ld.x, rect.ru.y, rect.ru.x, it->ru.y, it->paintCounter));
		check(newRects, Rect(rect.ru.x, it->ld.y, it->ru.x, it->ru.y, it->paintCounter));
	      } //pole wspólne = 0
	    } else {
	      if(rect.ru.x > it->ld.x) {
		check(newRects, Rect(it->ld.x, it->ld.y, rect.ru.x, it->ru.y, it->paintCounter+1));
		check(newRects, Rect(rect.ru.x, it->ld.y, it->ru.x, it->ru.y, it->paintCounter));
	      }
	    }
	  } else {
	    if(t) {
	      if(rect.ru.y > it->ld.y) {
		check(newRects, Rect(it->ld.x, rect.ru.y, it->ru.x, it->ru.y, it->paintCounter));
		check(newRects, Rect(it->ld.x, it->ld.y, it->ru.x, rect.ru.y, it->paintCounter+1));
	      } else {
		check(newRects, Rect(it->ld, it->ru, it->paintCounter+1));
	      }
	    }
	  }
	} else {
	  if(s) {
	    if(t) {
	      check(newRects, Rect(it->ld.x, rect.ru.y, rect.ru.x, it->ru.y, it->paintCounter));
	      check(newRects, Rect(rect.ru.x, rect.ld.y, it->ru.x, it->ru.y, it->paintCounter));
	      check(newRects, Rect(it->ld.x, it->ld.y, it->ru.x, rect.ru.y, it->paintCounter));
	      check(newRects, Rect(rect.ru.x, rect.ld.y, rect.ru.x, rect.ru.y, it->paintCounter+1));
	    } else {
	      if(rect.ru.x > it->ld.x && rect.ld.y < it->ru.y) {
		check(newRects, Rect(it->ld.x, rect.ld.y, rect.ru.x, it->ru.y, it->paintCounter+1));
		check(newRects, Rect(it->ld.x, it->ld.y, rect.ru.x, rect.ld.y, it->paintCounter));
		check(newRects, Rect(rect.ru.x, it->ld.y, it->ru.x, it->ru.y, it->paintCounter));
	      }
	    }
	  } else {
	    if(t) {
	      check(newRects, Rect(it->ld.x, rect.ru.y, it->ru.x, it->ru.y, it->paintCounter));
	      check(newRects, Rect(it->ld.x, rect.ld.y, it->ru.x, rect.ru.y, it->paintCounter+1));
	      check(newRects, Rect(it->ld.x, it->ld.y, it->ru.x, rect.ld.y, it->paintCounter));
	    } else {
	      if(rect.ld.y < it->ru.y) {
		check(newRects, Rect(it->ld.x, it->ld.y, it->ru.x, rect.ld.y, it->paintCounter));
		check(newRects, Rect(it->ld.x, rect.ld.y, it->ru.x, it->ru.y, it->paintCounter+1));
	      }
	    }
	  }
	}
      } else {
	if(q) {
	  if(s) {
	    if(t) {
	      if(rect.ru.y > it->ld.y) {
		check(newRects, Rect(it->ld.x, it->ld.y, rect.ld.x, it->ru.y, it->paintCounter));
		check(newRects, Rect(rect.ld.x, rect.ru.y, it->ru.x, it->ru.y, it->paintCounter));
		check(newRects, Rect(rect.ru.x, it->ld.y, it->ru.x, rect.ru.y, it->paintCounter));
		check(newRects, Rect(rect.ld.x, it->ld.y, rect.ru.x, rect.ru.y, it->paintCounter+1));
	      }
	    } else {
	      check(newRects, Rect(it->ld.x, it->ld.y, rect.ld.x, it->ru.y, it->paintCounter));
	      check(newRects, Rect(rect.ld.x, it->ld.y, rect.ru.x, it->ru.y, it->paintCounter+1));
	      check(newRects, Rect(rect.ru.x, it->ld.y, it->ru.x, it->ru.y, it->paintCounter));
	    }
	  } else {
	    if(t) {
	      if(rect.ld.x < it->ru.x && rect.ru.y > it->ld.y) {
		check(newRects, Rect(it->ld.x, it->ld.y, rect.ld.x, it->ru.y, it->paintCounter));
		check(newRects, Rect(rect.ld.x, it->ld.y, it->ru.x, rect.ru.y, it->paintCounter+1));
		check(newRects, Rect(rect.ld.x, rect.ru.y, it->ru.x, it->ru.y, it->paintCounter));
	      }
	    } else {
	      if(rect.ld.x < it->ru.x) {
		check(newRects, Rect(it->ld.x, it->ld.y, rect.ld.x, it->ru.y, it->paintCounter));
		check(newRects, Rect(rect.ld.x, it->ld.y, it->ru.x, it->ld.y, it->paintCounter+1));
	      }
	    }
	  }
	} else {
	  if(s) {
	    if(t) {
	      check(newRects, Rect(it->ld.x, it->ld.y, rect.ld.x, it->ru.y, it->paintCounter));
	      check(newRects, Rect(rect.ld.x, it->ld.y, rect.ru.x, rect.ld.y, it->paintCounter));
	      check(newRects, Rect(rect.ru.x, it->ld.y, it->ru.x, it->ru.y, it->paintCounter));
	      check(newRects, Rect(rect.ld.x, rect.ld.y, rect.ru.x, it->ru.y, it->paintCounter+1));
	    } else {
	      if(rect.ld.y < it->ru.y) {
		check(newRects, Rect(it->ld.x, it->ld.y, rect.ld.x, it->ru.y, it->paintCounter));
		check(newRects, Rect(rect.ld.x, it->ld.y, rect.ru.x, rect.ld.y, it->paintCounter));
		check(newRects, Rect(rect.ru.x, it->ld.y, it->ru.x, it->ru.y, it->paintCounter));
		check(newRects, Rect(rect.ld.x, rect.ld.y, rect.ru.x, it->ru.y, it->paintCounter+1));
	      }
	    }
	  } else {
	    if(t) {
	      if(rect.ld.x < it->ru.x) {
		check(newRects, Rect(it->ld.x, it->ld.y, rect.ld.x, it->ru.y, it->paintCounter));
		check(newRects, Rect(rect.ld.x, it->ld.y, it->ru.x, rect.ld.y, it->paintCounter));
		check(newRects, Rect(rect.ld.x, rect.ru.y, it->ru.x, it->ru.y, it->paintCounter));
		check(newRects, Rect(rect.ld.x, rect.ld.y, it->ru.x, rect.ru.y, it->paintCounter+1));
	      }
	    } else {
	      if(rect.ld.x < it->ru.x && rect.ld.y < it->ru.y) {
		check(newRects, Rect(it->ld.x, it->ld.y, rect.ld.x, it->ru.y, it->paintCounter));
		check(newRects, Rect(rect.ld.x, it->ld.y, it->ru.x, rect.ld.y, it->paintCounter));
		check(newRects, Rect(rect.ld.x, rect.ld.y, it->ru.x, it->ru.y, it->paintCounter+1));
	      }
	    }
	  }
	}
      }
      /*message("debug");
	for(set<Rect>::iterator it2=newRects.begin(); it2!=newRects.end(); ++it2) {
	cout << it2->ld.x << ' ' << it2->ld.y << ' ' << it2->ru.x << ' ' << it2->ru.y << endl;
	painted.insert(*it);
	}*/
      if(newRects.size()-size > 0 || it->paintCounter+n-(i+1) < n-1) toRemove.insert(*it);
    }
    if(!newRects.empty()) {
      //usuwam podzielone
      //message("erase");
      for(set<Rect>::iterator it=toRemove.begin(); it!=toRemove.end(); ++it) {
	//cout << it->ld.x << ' ' << it->ld.y << ' ' << it->ru.x << ' ' << it->ru.y << endl;
	painted.erase(*it);
      }
      //dodaje nowy podział
      //message("insert");
      for(set<Rect>::iterator it=newRects.begin(); it!=newRects.end(); ++it) {
	//cout << it->ld.x << ' ' << it->ld.y << ' ' << it->ru.x << ' ' << it->ru.y << endl;
	painted.insert(*it);
      }
    }
  }
  //message("print");
  long long int volume = 0;
  for(set<Rect>::iterator it=painted.begin(); it!=painted.end(); ++it) {
    //cout << it->ld.x << ' ' << it->ld.y << ' ' << it->ru.x << ' ' << it->ru.y << endl;
    if(it->paintCounter >= n-1) volume += it->volume();
  }
  cout << volume << endl;
}
