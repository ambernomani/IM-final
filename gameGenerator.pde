class Building {
  float x;
  float y;
  int id;
  float maxHeight;
  PVector loc;
  boolean isBottom;
  boolean isAlive;

  Building(float x_, float y_, float _maxHeight, int _id, boolean _isBottom) {
    isAlive = true;
    x = x_;
    y = y_;
    maxHeight = _maxHeight;
    id = _id;
    isBottom = _isBottom;
    

    loc = new PVector(x, y);
  }

  //float manage(Building other){
  //  rectMode(CORNERS);
  //  if (loc.x - x3 < width){
  //    noStroke();
  //    rect(loc.x, loc.y, loc.x - 100, maxHeight);
  //    loc.x = loc.x + 1;
  //    }
  //  else{
  //    loc.x = 0;
  //    float finalY;
  //    if (id == other.id){
  //      newY = int(random(50,200));
  //      loc.y = newY;
  //      finalY = loc.y - other.loc.y; 
  //      return finalY;
  //      //if (finalY >= 100){
  //      //  loc.y = loc.y;
  //      //  other.loc.y = other.loc.y;
  //      //} 
  //      //else{
  //      //  newY = int(random(50,200));
  //      //  loc.y = newY;
  //      //  finalY = loc.y - other.loc.y; 
  //  }
  //}
  //  }
  void move() {  
   if(!isAlive){
      return;
   }
    
    rectMode(CORNERS);
    if (loc.x - bWidth < width) {
      noStroke();
      rect(loc.x, loc.y, loc.x - bWidth, maxHeight);
      loc.x = loc.x + 5;
    } else {
      
      //REMOVE
      if(isBottom){
          println("Removing");
          println(buildArray.size());
          buildArray.remove(0);
          println(buildArray.size());
      }
      
      else{

          println("Removing Top");
          println(buildArrayTop.size());
          buildArrayTop.remove(0);
          println(buildArrayTop.size());
        
      }

      //create new building similar to blob1 code
      if(isBottom){
        try{
        createBuilding(id, isAlive, this);
        }
        catch(Exception e){
          println(e);
        }
      }
      
      
      //delete this building.
      
      
    }
  }
}

void createBuilding(int id, boolean isAlive, Building b){
    if(!isAlive){
      return;
    }
      println("Creating new building");
      //int _y = int(random(250, 350));
      //int _y1 = int(random(0, 150));
        
      //Building build = new Building(0, _y, screenHeight, id, true);
      //Building build2 = new Building(0, _y1, 0, id, false);
      //buildArray.add(build);
      //buildArrayTop.add(build2);
      //b.isAlive = false;
      
      
      for (int i = 0; i < 1; i++) {
       int y = int(random(100, 700));
       int y1 = int(random(100, 700));
        
        
       if (y - y1 >= 150) {
          
          
         Building build = new Building(0, y, screenHeight, i, true);
         Building build2 = new Building(0, y1, 0, i, false);
         buildArray.add(build);
         buildArrayTop.add(build2);
         b.isAlive = false;

       } else {
         i--;
       }
      }
}

void checkHit(ArrayList<Blob> blobby) {
  for (int i=0; i < buildArray.size(); i++) {
      Building builds = buildArray.get(i);
      Building builds2 = buildArrayTop.get(i);
      for (Blob b : blobby) {
        if (b.size() > 0) {
          if (blobby.get(0).maxy >= builds.y && blobby.get(0).maxx >= (builds.x - bWidth) || blobby.get(0).maxy >= builds.y && blobby.get(0).minx <= builds.x) {
            crash = true;
            //delay(1000);
            println("you lose");
          } else if (blobby.get(0).miny <= builds2.y && blobby.get(0).maxx >= (builds2.x - bWidth) || blobby.get(0).miny <= builds2.y && blobby.get(0).minx <= builds2.x) {
            crash = true;
            //delay(1000);
            println("you lose");
          } else {
            crash = false;
            println("you are alive");
          }
        }
      }
    }
}
  //return;

  //try{
  //  for (int i=0; i < buildArray.size(); i++) {
  //    Building builds = buildArray.get(i);
  //    Building builds2 = buildArrayTop.get(i);
  //    for (Blob b : blobby) {
  //      if (b.size() > 0) {
  //        if (blobby.get(0).maxy >= builds.y) {
  //          if (blobby.get(0).maxx >= (builds.x - bWidth)){ 
  //            crash = true;
  //            //delay(1000);
  //            println("you lose");
  //          }else if (blobby.get(0).minx <= builds.x) {
  //            crash = true;
  //            //delay(1000);
  //            println("you lose");
  //          } else{
  //            crash = false;
  //            println("you are alive");
  //        }
  //        }else if (blobby.get(0).miny <= builds2.y) {
  //          if (blobby.get(0).maxx >= (builds2.x - bWidth)){ 
  //            crash = true;
  //            //delay(1000);
  //            println("you lose");
  //          }else if (blobby.get(0).minx <= builds2.x) {
  //            crash = true;
  //            //delay(1000);
  //            println("you lose");
  //          }else{
  //            crash = false;
  //            println("you are alive");
  //        }
  //        } else {
  //          crash = false;
  //          println("you are alive");
  //        }
  //      }
  //    }
  //  }
  
  //}catch(Exception e){
  //   println("ERROR");
  //   println(e);
  //}
 


//void ambulance(ArrayList<Blob> blobb, PImage vehicle){
//  //for (int j = blobb.size() - 1; j >= 0; j--) {
//    if (blobb.size() > 0){
//       maxY = blobb.get(0).maxy;
//       minY = blobb.get(0).miny;
//       maxX = blobb.get(0).maxx;
//       minX = blobb.get(0).minx;
//    } 
//       //for (int j = blobb.size() - 1; j >= 0; j--) {
//       //  //Blob b = blobs.get(j);
//       //  blobb.remove(j);
//       //}

//       //check where blob is
//     //for (int h = 0; h >= height; h+=10) {
//       //if (maxY < height){
//       //  minY = minY + h;
//       //  maxY = maxY + h;
//       //  background(0);
//       //  makeFace(minX, minY, maxX, maxY);
//       //}
//       //else{
//         for (int k = width; k > 0; k-=10){
//           //check where ambulance is
//           if (k >= minX){
//             image(vehicle, k, height - 100, 100, 100);
//             makeFace(minX, minY, maxX, maxY);
//           }else{
//             makeFace(k, minY, maxX, maxY);
//             image(vehicle, k, height - 100, 100, 100);
//           }
//         }
//         //background(255,0,0);
//         //image(vehicle, k, height-50, 100,100);
//         println("ambulance");
//         //delay(3000);
//       //}
//     //}
//       crash = false;
//  }