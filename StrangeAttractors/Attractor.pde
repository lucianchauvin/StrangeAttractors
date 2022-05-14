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
  
  float[] toIso(float lx, float ly, float lz) {
    float u = lx * cos(360) + ly * cos(360 + radians(120)) + lz * cos(360 - radians(120));
    float v = lx * sin(360) + ly * sin(360 + radians(120)) + lz * sin(360 - radians(120));
    return new float[] {u,v};
  }
  
  void update(){
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
  
  void drawp(){
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
      hu += .4*c;
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
