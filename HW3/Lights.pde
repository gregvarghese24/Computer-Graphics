public class Lights {
  
   PVector pos;
   PVector colors;
   float x,y,z,r,g,b;
   PVector source;
   
  public Lights(float x, float y, float z, float r, float g, float b){
    this.source = new PVector(x,y,z);
    this.x = x;
    this.y = y;
    this.z = z;
    this.r = r;
    this.g = g;
    this.b = b;
    
    
    pos = new PVector(x, y, z);
    colors = new PVector(r,g,b);
  }
  
  public PVector getPosition() {
    return pos;
  }
  
  public PVector getColors() {
    return colors;
  }

}
