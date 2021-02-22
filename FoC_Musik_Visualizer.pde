 import ddf.minim.analysis.*;
import ddf.minim.*;

Minim       minim;
AudioInput song;
FFT         fft;

float sampleRate = 44100;
int bufferSize = 1024;

float maxbass;
float maxmid;
float maxhigh;

float z =  3000;
float bass;
float mid;
float high;
int depth = 50000;


Box[] boxes = new Box[3000];

void setup() {

  fullScreen(P3D,SPAN);
  //size(1000, 400, P3D);
  noCursor();

  minim = new Minim(this);
  song = minim.getLineIn(Minim.MONO, bufferSize, sampleRate);
  fft = new FFT( song.bufferSize(), song.sampleRate() );

  for (int i=0; i<boxes.length; i++) {
    boxes[i] = new Box();
  }
}


class Box {
  float c;
  float x;
  float y;
  float z;
  float size;
  float xrot;
  float yrot;
  //float mvmt;

  Box() {
    c = random(150, 240);
    //mvmt = ra
    x = random(-2*width, 3*width);
    y = random(-2*height, 3*height);
    z = random(-1*depth, 1);
    size = random(25, 150);
    xrot = random(3)-1;
    yrot = random(3)-1;
  }



  void display() {
    colorMode(HSB, 360, 100, 100);

    float sat = 100-(bass/maxbass)*85;

    if (sat < 0) {
      sat = 0;
    }
    
    fill(c, sat, 100);

    pushMatrix();
    translate(x, y, z);
    rotateX((cos(frameCount/x))+cos(mid/25));
    rotateY((sin(frameCount/y))+sin(mid/25));
    box(( mid)+20);
    popMatrix();
  }
}




void draw() {
  noStroke();
  background(0); // or 244, 100, ((bass/maxbass)*16)+14


  fft.forward( song.mix ); 
  bass = fft.calcAvg(0, 100)*10;
  mid = fft.calcAvg(100, 1000)*8;   
  high = fft.calcAvg(1000, 20000)*10;


  if (bass>maxbass) {
    maxbass = bass;
  }

  if (mid>maxmid) {
    maxmid = mid;
  }
  if (high>maxhigh) {
    maxhigh = high;
  }


  println(maxbass, "maxbass"); //270?
  println(maxmid, "maxmid"); //160
  println(maxhigh, "maxhigh"); //28


  if (mid > maxmid-(maxmid/15)) {
    z+= mid*5;
  } else {
    
    z-=(bass/2)+15;
  }

  if (z<=-1*depth+4000) {
    z=3000;
  }



  camera(mouseX, mouseY, z, width/2, height/2, -1*depth, 0, 1, 0);

  lights();

  smooth();


  for (int i=0; i<boxes.length; i++) {
    boxes[i].display();
  }

  float sat = 100-(bass/maxbass)*100;
  stroke(180, sat, 80);


  pushMatrix();
  translate(width/2, height/2, z-5000);
  scale(100);
  for (int i = 0; i < fft.specSize(); i++)
  {
    float m = map(i, 0, fft.specSize(), 0, 2*PI);

    strokeWeight(.01);
    line(cos(m), sin(m), 0, cos(m)*(fft.getBand(i+20)), sin(m)*(fft.getBand(i+20)), 0);
      
  }
  popMatrix();

}