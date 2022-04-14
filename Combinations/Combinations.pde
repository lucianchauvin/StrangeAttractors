int sizew = 3072;
int sizeh = 1920;

float p = 45; //scale
float o = 0.002; //step
float rand = 0; //adds noise to points

float power = 1; //weight at which the first equation holds on the vertex
float x = 1; //init x for e1
float y = 1; //init y for e1
float z = 1; //init z for e1

//e1 constants 
float a = 36;
float b = 3;
float c = 20;

float power2 = 1; //weight for e2
float x2 = 1; //e2 x
float y2 = 0; //e2 y
float z2 = 0; //e2 z

//e2 const
float a2 = 1.4;


//color range
float intcolor = 135; 
float endcolor = 200;

ArrayList<PVector> points = new ArrayList<PVector>(); //vector list

void setup() {
  size(3072, 1920, P3D);
  frameRate(300);
  colorMode(HSB);
  
}

float toisou(float lx, float ly, float lz) {
  float u = lx * cos(360) + ly * cos(360 + radians(120)) + lz * cos(360 - radians(120));
  return u;
}

float toisov(float lx, float ly, float lz) {
  float v = lx * sin(360) + ly * sin(360 + radians(120)) + lz * sin(360 - radians(120));
  return v;
}

void draw() {
  background(0);
  float dxdt = a*(y-x);
  float dydt = -x*z + c*y;
  float dzdt = x*y - b*z;
  
  float dxdt2 = -a2*x2-4*y2-4*z2-y2*y2;
  float dydt2 = -a2*y2-4*z2-4*x2-z2*z2;
  float dzdt2 = -a2*z2-4*x2-4*y2-x2*x2;
  
  x = x + dxdt*o;
  y = y + dydt*o;
  z = z + dzdt*o;
  
  x2 = x2 + dxdt2*o;
  y2 = y2 + dydt2*o;
  z2 = z2 + dzdt2*o;

  
  points.add(new PVector((x*power+x2*power2)/2, (y*power+y2*power2)/2, (z*power+z2*power2)/2)); //combining via average
  //points.add(new PVector(sqrt(pow(x*power,2)+pow(x2*power2,2)), sqrt(pow(y*power,2)+pow(y2*power2,2)), sqrt(pow(z*power,2)+pow(z2*power2,2)))); //combining via pythag

  translate(sizew/2 - sizew/6, sizeh/2, 0);
  scale(1);
  stroke(255);
  noFill();

  float hu = intcolor;
  float c = 1; 
  
  
  beginShape();
  for (int i = 0; i < points.size(); i++) {
    
    stroke(hu, 255, i);
    strokeWeight(i/75);
    
    vertex(toisou(points.get(i).x, points.get(i).y, points.get(i).z)*p+ random(rand), toisov(points.get(i).x, points.get(i).y, points.get(i).z)*p+ random(rand));
    
    hu += .4*c;
    if (hu > endcolor) {
      c = -1;
    }
    if (hu < intcolor) {
      c = 1;
    }
    
    if (points.size() > 255) {
      points.remove(0);
    }
  }
  endShape();
}
