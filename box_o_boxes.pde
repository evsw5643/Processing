void setup() {
  fullScreen(P3D);
  lights();
  //noStroke();
}

void drawAxes() {
  strokeWeight(1);

  stroke(255, 0, 0);
  line(0, 0, 0, 500, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 100, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 100);
}

void draw() {
  clear();
  translate(width/2, height/2, 0);
  rotateX(sin(frameCount/2000.0)*2*3.145);
  rotateY(sin(frameCount/2000.0)*2*3.145);
  //rotateZ(sin(frameCount/2000.0)*2*3.145);
  scale(sin(frameCount/100.0)*2);
  for (int x = -250; x < 250; x += 50) {
    for (int y = -250; y < 250; y += 50) {
      for (int z = -250; z < 250; z += 50) {
        fill(x+250, y+250, z+250);
        pushMatrix();
        translate(x, y, z);
        box(25);
        popMatrix();
      }
    }
  }
}