import org.quark.jasmine.*;
  
Attractor[] attractors = {new Attractor(1, 1, 1, 1, 0, .002, 45, 135, 200, "36*(y-x)", "-x*z + 20*y", "x*y - 3*z")};

void setup() {
  size(displayWidth, displayHeight, P3D);
  frameRate(300);
  colorMode(HSB);
  background(0);
}


void draw() {
  rect(50, 50, 25, 25);
  for(Attractor a: attractors){
    background(0);
    a.update();
    a.drawp();
  }
}
