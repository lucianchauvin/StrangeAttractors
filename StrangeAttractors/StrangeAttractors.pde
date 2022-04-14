import org.quark.jasmine.*;
  
Attractor[] attractors = {new Attractor(1, 0, 0, 1, 0, .005, 20, 135, 200, true, "-1.4*x-4*y-4*z-y*y", "-1.4*y-4*z-4*x-z*z", "-1.4*z-4*x-4*y-x*x")};

void setup() {
  size(displayWidth, displayHeight, P3D);
  frameRate(300);
  colorMode(HSB);
  background(0);
}


void draw() {
  for(Attractor a: attractors){
    background(0);
    a.update();
    a.drawp();
  }
}
