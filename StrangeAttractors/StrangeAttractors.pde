import org.quark.jasmine.*;

/* 
Current Problems
1. In the attractor class, the eval function for each forumli for demension with repect to time requires manual change for order in variables. 
*/

ArrayList<Attractor> attractors = new ArrayList<Attractor>();

// General Attractor(x, y, z, xoffset, yoffset, power, noise, step, scale, startColor, endColor, iso, dx, dy,dz);

void setup() {
  size(displayWidth, displayHeight, P3D);
  frameRate(1000);
  colorMode(HSB);
  background(0);
  smooth();
  attractors.add(new Attractor("Lorenze", 1, 0, 0, 0, 0, 1, 0, .005, 20, 90, 155, false, "10*(-x+y)", "28*x-y-x*z", "x*y-(8/3)*z"));
  attractors.add(new Attractor("Halvorsen", 1, 0, 0, 0, 0, 1, 0, .005, 40, 135, 200, true, "-1.4*x+-4*y+-4*z-y*y", "-4*x+-1.4*y+-4*z+-z*z", "-4*x+-4*y+-1.4*z+-x*x"));
  attractors.add(new Attractor("BurkeShaw", 1, 0, 0, 0, 0, 1, 0, .005, 100, 180, 255, true, "-1*10*(x+y)", "((-1*x*y)/x)-10*x*z", "10*x*y+4.272"));
  attractors.add(new Attractor("Bouali", 1, .1, .1, 0, 0, 1, 0, .006, 65, 20, 88, true, "x*(4-y)+ .3*z", "(1-(x*x))*(-1*y)", "-1*x*(y/y)*(1.5-z) - .05*z"));
  attractors.add(new Attractor("Spott-Linz", .1, .1, .1, 0, 0, 1, 0, .01, 150 , 160, 230, true, "(x/x)*y", "(-1*x)+y*z", "1-((x/x)*y*y)"));
  attractors.add(new Attractor("Nose-Hoover", 1, 0, 0, 0, 0, 1, 0, .009, 100, 55, 134, true, "(x/x)*y", "(-1*x)+y*z", "1.5-(x/x)*y*y"));

}

void draw() {
  background(0);
  for(Attractor a: attractors){
    a.update();
    a.drawp();
  }
}
