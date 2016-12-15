void makeFace(float x, float y, float x2, float y2){
  y = y + (y2-y)/2;
  float xNew = x;
  x = x + 20;
  for (int i = 0; i<2; i++){
    stroke(255);
    fill(0);
    ellipse(x, y, int(random(5,10)), int(random(5,10)));
    x= x2 - 20;
  }
  stroke(170);
  line(xNew, y, xNew-20, y);
  line(x2, y, x2+20, y);
  line(xNew, y2, xNew-20, y2);
  line(x2, y2, x2+20, y2);
  
}