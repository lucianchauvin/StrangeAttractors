/* autogenerated by Processing revision 1276 on 2022-05-15 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import org.quark.jasmine.*;
import peasy.*;
import controlP5.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class StrangeAttractors extends PApplet {





ControlP5 cp5;

PeasyCam cam;

/* 
Current Problems
1. In the attractor class, the eval function for each forumli for demension with repect to time requires manual change for order in variables. 
*/

ArrayList<Attractor> attractors = new ArrayList<Attractor>();

// General Attractor(x, y, z, xoffset, yoffset, power, noise, step, scale, startColor, endColor, iso, dx, dy,dz);

 public void setup() {
  /* size commented out by preprocessor */;
  cam = new PeasyCam(this, displayWidth/2, displayHeight/2, 0, 750);
  frameRate(1000);
  colorMode(HSB);
  background(0);
  /* smooth commented out by preprocessor */;
  float c = .5f ;
  attractors.add(new Attractor("Lorenze", 1, 0, 0, 0, 0, 1, 0, .005f, 20*c, 90, 155, false, "10*(-x+y)", "28*x-y-x*z", "x*y-(8/3)*z"));
  attractors.add(new Attractor("Halvorsen", 1, 0, 0, 0, 0, 1, 0, .005f, 40*c, 135, 200, false, "-1.4*x+-4*y+-4*z-y*y", "-4*x+-1.4*y+-4*z+-z*z", "-4*x+-4*y+-1.4*z+-x*x"));
  attractors.add(new Attractor("BurkeShaw", 1, 0, 0, 0, 0, 1, 0, .005f, 100*c, 180, 255, false, "-1*10*(x+y)", "((-1*x*y)/x)-10*x*z", "10*x*y+4.272"));
  attractors.add(new Attractor("Bouali", 1, .1f, .1f, 0, 0, 1, 0, .006f, 65, 20*c, 88, false, "x*(4-y)+ .3*z", "(1-(x*x))*(-1*y)", "-1*x*(y/y)*(1.5-z) - .05*z"));
  attractors.add(new Attractor("Spott-Linz", .1f, .1f, .1f, 0, 0, 1, 0, .01f, 150*c , 160, 230, false, "(x/x)*y", "(-1*x)+y*z", "1-((x/x)*y*y)"));
  attractors.add(new Attractor("Nose-Hoover", 1, 0, 0, 0, 0, 1, 0, .009f, 100*c, 55, 134, false, "(x/x)*y", "(-1*x)+y*z", "1.5-(x/x)*y*y"));

  cam.rotateY(radians(-1*(90+45)));
  cam.rotateX(radians(30));

  cp5 = new ControlP5(this);
  cp5.addButton("button")
     .setValue(10)
     .setPosition(20,20)
     .setSize(1000,300)
     .setId(1);
}

 public void draw() {
  background(0);
  for(Attractor a: attractors){
    a.update();
    a.drawp();
  }
}
class Attractor { 
  
  private ArrayList<PVector> points = new ArrayList<PVector>();
  
  
  String name;
  float x, y, z, xoffset, yoffset, power, noise, step, scale, startColor, endColor;
  boolean iso;
  Expression dxe;
  Expression dye; 
  Expression dze;
  
  Attractor (String name, float x, float y, float z, float xoffset, float yoffset, float power, float noise, float step, float scale, float startColor, float endColor, boolean iso, String dx, String dy, String dz) {  
    this.name = name;
    this.x = x;
    this.y = y;
    this.z = z;
    this.xoffset = xoffset;
    this.yoffset = yoffset;
    this.power = power;
    this.noise = noise;
    this.step = step;
    this.scale = scale;
    this.startColor = startColor;
    this.endColor = endColor;
    this.iso = iso;
    
    Compile.init();
    
    this.dxe = Compile.expression(dx,true);
    this.dye = Compile.expression(dy,true);
    this.dze = Compile.expression(dz,true);
  
  }
  
   public float[] toIso(float lx, float ly, float lz) {
    float u = lx * cos(360) + ly * cos(360 + radians(120)) + lz * cos(360 - radians(120));
    float v = lx * sin(360) + ly * sin(360 + radians(120)) + lz * sin(360 - radians(120));
    return new float[] {u,v};
  }
  
   public void update(){
    // print(name, "|", x, y, z, "|", "\n");
    float dxdt = dxe.eval(x,y,z).answer().toFloat()*step;
    float dydt = dye.eval(x,y,z).answer().toFloat()*step;
    float dzdt = dze.eval(x,y,z).answer().toFloat()*step;
    //print(name, "|", dxdt, dydt, dzdt, "|", "\n");
    
    this.x += dxdt;
    this.y += dydt;
    this.z += dzdt;
    
    this.points.add(new PVector(this.x, this.y, this.z)); 
  }
  
   public void drawp(){
    translate(displayWidth/2 + xoffset, displayHeight/2 + yoffset, 0);
    noFill();
    
    float hu = this.startColor;
    float c = 1; 
    
    beginShape();
    for (int i = 0; i < this.points.size(); i++) {
      stroke(hu, 255, i);
      strokeWeight(i/75);
      if(iso){
        float[] cords = toIso(this.points.get(i).x,this.points.get(i).y,this.points.get(i).z);
        float u = cords[0];
        float v = cords[1];

        vertex(u*this.scale + random(this.noise), v*this.scale + random(this.noise), 0);
      }
      else{
        vertex(this.points.get(i).x*this.scale + random(this.noise), this.points.get(i).y*this.scale + random(this.noise), this.points.get(i).z*this.scale + random(this.noise));
      }
      hu += .4f*c;
      if (hu > endColor) {
        c = -1;
      }
      if (hu < startColor) {
        c = 1;
      }
      if (this.points.size() > 255) {
        this.points.remove(0);
      }
    }
    endShape();
  translate((displayWidth/2 + xoffset)*-1, (displayHeight/2 + yoffset)*-1, 0);
  }

} 


  public void settings() { size(displayWidth, displayHeight, P3D);
smooth(); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "StrangeAttractors" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
