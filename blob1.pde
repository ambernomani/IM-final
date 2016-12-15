// Daniel Shiffman
// http://codingrainbow.com
// http://patreon.com/codingrainbow
// Code for: https://youtu.be/1scFcY-xMrI
import processing.video.*;

Capture video;

int blobCounter = 0;

int maxTimer = 100000;
int WinCount = 0;
int lossCount = 1000;

float minX, minY, maxX, maxY;
float finalY;
color trackColor; 
float threshold = 25;
int x;
int bWidth = 200;
int numBuild = 5;
int y;
int y1;
ArrayList<Building> buildArray;
ArrayList<Building> buildArrayTop;
int newY;
int screenHeight = 720;
boolean start = true;
boolean begin = false;
float distThreshold = 50;
boolean crash = false;

PImage anAmbulance;

ArrayList<Blob> blobs = new ArrayList<Blob>();

void setup() {
  size(1280, 720);
  x = width-150;
  //anAmbulance = loadImage("amb.png");

  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, 1280, 720);
  video.start();
  trackColor = color(255, 0, 0);
  //buildArray = new ArrayList<Building>();
  //for (int i = 0; i < numBuild; i++){
  //  y = int(random(0,350));
  //  Building build = new Building(x, y);
  //  buildArray.add(build);
  //  //yArray[i] = y;
  //  x = x + 150;
  //}
}

void captureEvent(Capture video) {
  video.read();
}

void keyPressed() {
  if (key == 'a') {
    distThreshold+=5;
  } else if (key == 'z') {
    distThreshold-=5;
  }
  if (key == 's') {
    threshold+=5;
  } else if (key == 'x') {
    threshold-=5;
  }


  println(distThreshold);
}

void draw() {
  
  if (start == true){
    background(0);
    textAlign(CENTER);
    fill(255);
    text("Guide your blob through the city. Careful of the buildings!", width/2, height/2);
    text("REMEMBER: Your actions are mirrored", width/2, height/2);

  }
  //video.resize(1920, 1080);
  video.loadPixels();
  image(video, 0, 0);


  ArrayList<Blob> currentBlobs = new ArrayList<Blob>();

  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      int locate = x + y * video.width;
      // What is current color
      color currentColor = video.pixels[locate];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      float d = distSq(r1, g1, b1, r2, g2, b2); 

      if (d < threshold*threshold) {

        boolean found = false;
        for (Blob b : currentBlobs) {
          if (b.isNear(x, y)) {
            b.add(x, y);
            found = true;
            break;
          }
        }

        if (!found) {
          Blob b = new Blob(x, y);
          currentBlobs.add(b);
        }
      }
    }
  }
  for (int i = currentBlobs.size()-1; i >= 0; i--) {
    if (currentBlobs.get(i).size() < 500) {
      currentBlobs.remove(i);
    }
  }

  // There are no blobs!
  if (blobs.isEmpty() && currentBlobs.size() > 0) {
    println("Adding blobs!");
    for (Blob b : currentBlobs) {
      b.id = blobCounter;
      blobs.add(b);
      blobCounter++;
    }
  } else if (blobs.size() <= currentBlobs.size()) {
    // Match whatever blobs you can match
    for (Blob b : blobs) {
      float recordD = 1000;
      Blob matched = null;
      for (Blob cb : currentBlobs) {
        PVector centerB = b.getCenter();
        PVector centerCB = cb.getCenter();         
        float d = PVector.dist(centerB, centerCB);
        if (d < recordD && !cb.taken) {
          recordD = d; 
          matched = cb;
        }
      }
      matched.taken = true;
      b.become(matched);
    }

    // Whatever is leftover make new blobs
    for (Blob b : currentBlobs) {
      if (!b.taken) {
        b.id = blobCounter;
        blobs.add(b);
        blobCounter++;
      }
    }
  } else if (blobs.size() > currentBlobs.size()) {
    for (Blob b : blobs) {
      b.taken = false;
    }


    // Match whatever blobs you can match
    for (Blob cb : currentBlobs) {
      float recordD = 1000;
      Blob matched = null;
      for (Blob b : blobs) {
        PVector centerB = b.getCenter();
        PVector centerCB = cb.getCenter();         
        float d = PVector.dist(centerB, centerCB);
        if (d < recordD && !b.taken) {
          recordD = d; 
          matched = b;
        }
      }
      if (matched != null) {
        matched.taken = true;
        matched.timer = maxTimer;
        matched.become(cb);
      }
    }

    for (int i = blobs.size() - 1; i >= 0; i--) {
      Blob b = blobs.get(i);
      if (!b.taken) {
        if (b.checkTimer()) {
          blobs.remove(i);
        }
      }
    }
  }

  for (Blob b : blobs) {
    blobs.get(0).show();
  } 

  textAlign(RIGHT);
  fill(0);
  textSize(12);
  text("distance threshold: " + distThreshold, width-10, 25);
  text("color threshold: " + threshold, width-10, 50);
  //text("Life " + lossCount, width-10, 75);

  fill(170);

    if (begin == true) {
      for (int i=0; i < buildArray.size(); i++) {
        Building build = buildArray.get(i);
        Building build2 = buildArrayTop.get(i);
        //if (build.manage(build2) >= 100){
          build.move();
          build2.move();
          //build.manage(build2);
        //}
        checkHit(currentBlobs);
        if (crash == true) {
          //print("You lose");
          background(255, 0, 0);
          lossCount--;
         
  
          //ambulance(currentBlobs, anAmbulance);
          //background(0);
          crash = false;
          //text("You lose", width/2, height/2);
        }
      }
    } 
    if (lossCount <= 0){
      background(0);
      textAlign(CENTER);
      textSize(32);
      fill(255);
      text("Blobby died :(", width/2, height/2);
    }
    fill(0);
    textSize(32);
    text("Life " + lossCount, width-10, 100);
}


// Custom distance functions w/ no square root for optimization
float distSq(float x1, float y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return d;
}


float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}

void mousePressed() {
  begin  = true;
  // Save color where the mouse is clicked in trackColor variable
  int location = mouseX + mouseY*video.width;
  trackColor = video.pixels[location];
  delay(500);
  buildArray = new ArrayList<Building>();
  buildArrayTop = new ArrayList<Building>();
  for (;WinCount <= 0; WinCount++){
   
      for (int i = 0; i < numBuild; i++) {
        y = int(random(0, 700));
        y1 = int(random(0, 700));
        if (y - y1 >= 100) {
          Building build = new Building(x, y, screenHeight, i, true);
          Building build2 = new Building(x, y1, 0, i, false);
          buildArray.add(build);
          buildArrayTop.add(build2);
          
          x = x - bWidth - 100;
        } else {
          i--;
        }
      }
    
  }
}