public class Disk extends Shape {
   PVector center;
   PVector surfaceNormal;
   float radius;
   Surface s; 
   
  public Disk(float x, float y, float z, float nx, float ny, float nz, float r){
    center = new PVector(x, y, z);
    surfaceNormal = new PVector(nx, ny, nz);
    radius = r; 
        
  }
  
  
  public PVector getCenter(){
    return center;
  }
  
  public PVector getSurfaceNormal() {
    return surfaceNormal;
  }
  
  public float getRadius() {
    return radius;
  }
  
  public void setSurface(Surface s) {
    this.s = s;
  }
  
  public Surface getSurface() {
    
    return s;
  }
  
  public PVector getDiffuse() {
     return s.diffuse;
  }

}
