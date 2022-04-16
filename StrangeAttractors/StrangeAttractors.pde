import org.quark.jasmine.*;

/* 
Current Problems
1. In the attractor class, the eval function for each forumli for demension with repect to time requires manual change for order in variables. 
*/

// General Attractor(x, y, z, xoffset, yoffset, power, noise, step, scale, startColor, endColor, iso, dx, dy,dz);

// Halvorsen
Attractor[] attractors = {new Attractor(1, 0, 0, 0, 0, 1, 0, .005, 20, 135, 200, true, "-1.4*x-4*y-4*z-y*y", "-1.4*y-4*z-4*x-z*z", "-1.4*z-4*x-4*y-x*x")};

// Lorenze
// Attractor[] attractors = {new Attractor(1, 0, 0, 0, 0, 1, 0, .005, 10, 135, 200, false, "10*(-x+y)", "28*x-y-x*z", "x*y-(8/3)*z")};

void setup() {
  size(displayWidth, displayHeight, P3D);
  frameRate(1000);
  colorMode(HSB);
  background(0);
  smooth();

}

void draw() {
  for(Attractor a: attractors){
    background(0);
    a.update();
    a.drawp();
  }
}
