float x = 1;
float y = 1;
float z = 1;

int sizew = 3072;
int sizeh = 1920;

float a = 36;
float b = 3;
float c = 20;
float o = 0.002;
float p = 41;

float rand = 0;

float intcolor = 135;
float endcolor = 200;

ArrayList<PVector> points = new ArrayList<PVector>();

void setup() {
  size(3072, 1920, P3D);
  frameRate(100);
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
  
  x = x + dxdt*o;
  y = y + dydt*o;
  z = z + dzdt*o;

  points.add(new PVector(x, y, z));

  translate(sizew/2 - sizew/3, sizeh/2+sizeh/6, 0);
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
