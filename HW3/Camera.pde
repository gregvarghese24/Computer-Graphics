public class Camera {
  
  PVector u;
  PVector v;
  PVector w;
  
  public Camera(float ux, float uy, float uz, float vx, float vy, 
                            float vz, float wx, float wy, float wz){
    u = new PVector(ux,uy,uz);
    v = new PVector(vx,vy,vz);
    w = new PVector(wx,wy,wz);
  }
  
  public PVector getU() {
    return u;
  }
  
  public PVector getV() {
    return v;
  }
  
  public PVector getW() {
    return w;
  }
  

}
