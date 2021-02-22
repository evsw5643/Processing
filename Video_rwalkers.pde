import processing.video.*;

Walker [] arr;

Capture video;


void setup() {
  video = new Capture(this, Capture.list()[0]);
  video.start();


  background(0);
  size(500,500);//fullScreen();
  strokeWeight(2.5);
  frameRate(60);
  arr = new Walker[200];
  for (int i = 0; i < arr.length; i++) {
    arr[i] = new Walker();
  }
}
void draw() {
  if (video.available()) {    
    video.read();
  }

  for (int i = 0; i < arr.length; i++) {
    arr[i].walk();
  }
}
class Walker {
  int x;
  int y;
  int r;
  int g;
  int b;

  Walker() {
    x = width/2;
    y = height/2;
  }
  void walk() {
    //clear();
    x = x + floor(random(-3,4));
    y = y + floor(random(-3,4));
    //r = int(dist(255, 0, x, y));
    //g = int(dist(377, 255, x, y));
    //b = int(dist(255, 377, x, y));
    //stroke(r, g, b);
    stroke(red(video.get(x, y)), green(video.get(x, y)), blue(video.get(x, y)));
    point(x, y);
  }
}