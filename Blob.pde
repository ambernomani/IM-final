// Daniel Shiffman
// http://codingrainbow.com
// http://patreon.com/codingrainbow
// Code for: https://youtu.be/1scFcY-xMrI

class Blob {
  float minx;
  float miny;
  float maxx;
  float maxy;
  
  int timer = maxTimer;

  int id;
 
  boolean taken = false;

  Blob(float x, float y) {
    minx = x;
    miny = y;
    maxx = x;
    maxy = y;
    
  }
  
  boolean checkTimer(){
    timer--;
    if (timer < 0) {
      return true;
    }else {
      return false;
    }
  }
  
  void show() {
    stroke(0);
    fill(255);
    strokeWeight(2);
    rectMode(CORNERS);
    //rect(minx, miny, maxx, maxy);
    makeFace(minx, miny, maxx, maxy);
  }


  void add(float x, float y) {
    minx = min(minx, x);
    miny = min(miny, y);
    maxx = max(maxx, x);
    maxy = max(maxy, y);
  }
  
  void become(Blob other) {
    minx = other.minx;
    maxx = other.maxx;
    miny = other.miny;
    maxy = other.maxy;
  }

  float size() {
    return (maxx-minx)*(maxy-miny);
  }
  
  PVector getCenter() {
    float x = (maxx - minx)* 0.5 + minx;
    float y = (maxy - miny)* 0.5 + miny;    
    return new PVector(x,y); 
  }

  boolean isNear(float x, float y) {

    // The Rectangle "clamping" strategy
     float cx = max(min(x, maxx), minx);
     float cy = max(min(y, maxy), miny);
     float d = distSq(cx, cy, x, y);

    if (d < distThreshold*distThreshold) {
      return true;
    } else {
      return false;
    }
  }
}