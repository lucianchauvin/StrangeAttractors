class Attractor { 
  
  ArrayList<PVector> points = new ArrayList<PVector>();
  
  float x, y, z, power, noise, step, scale, startColor, endColor;
  boolean iso;
  Expression dxe;
  Expression dye; 
  Expression dze;
  String[] dxo;
  String[] dyo;
  String[] dzo;
  
  Attractor (float x, float y, float z, float power, float noise, float step, float scale, float startColor, float endColor, boolean iso, String dx, String dy, String dz) {  
    this.x = x;
    this.y = y;
    this.z = z;
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
    
    //for(String c: split(dx,"")){
    //  if(c.equals("x") || c.equals("y") || c.equals("z")){
    //    append(dxo, c);
    //  }
    //}
    //for(String c: split(dy,"")){
    //  if(c.equals("x") || c.equals("y") || c.equals("z")){
    //    append(dyo, c);
    //  }
    //}
    //for(String c: split(dz,"")){
    //  if(c.equals("x") || c.equals("y") || c.equals("z")){
    //    append(dzo, c);
    //  }
    //}
  
  }
  
  float[] toIso(float lx, float ly, float lz) {
    float u = lx * cos(360) + ly * cos(360 + radians(120)) + lz * cos(360 - radians(120));
    float v = lx * sin(360) + ly * sin(360 + radians(120)) + lz * sin(360 - radians(120));
    return new float[] {u,v};
  }
  
  void update(){
    //print("|", x, y, z, "|", "\n");
    float dxdt = dxe.eval(x,y,z).answer().toFloat()*step;
    float dydt = dye.eval(y,z,x).answer().toFloat()*step;
    float dzdt = dze.eval(z,x,y).answer().toFloat()*step;
    //print("|", dxdt, dydt, dzdt, "|", "\n");
    
    x += dxdt;
    y += dydt;
    z += dzdt;
    
    points.add(new PVector(x, y, z));
    
  }
  
  void drawp(){
    translate(displayWidth/2, displayHeight/2, 0);
    stroke(255);
    noFill();
    
    float hu = startColor;
    float c = 1; 
    
    
    beginShape();
    for (int i = 0; i < points.size(); i++) {
      
      stroke(hu, 255, i);
      strokeWeight(i/75);
      
      if(iso){
        float u = toIso(points.get(i).x,points.get(i).y,points.get(i).z)[0];
        float v = toIso(points.get(i).x,points.get(i).y,points.get(i).z)[1];
        
        vertex(u*scale + random(noise), v*scale + random(noise), 0);
        
      }
      else{
        vertex(points.get(i).x*scale + random(noise), points.get(i).y*scale + random(noise), points.get(i).z*scale + random(noise));
        
      }
      
      hu += .4*c;
      if (hu > endColor) {
        c = -1;
      }
      if (hu < startColor) {
        c = 1;
      }
      
      if (points.size() > 255) {
        points.remove(0);
      }
    }
    endShape();
    
    
  }
 
} 
