public class Ellipsoid extends Shape {
  PVector center;
  PVector radii;
  Surface s;
  public Ellipsoid(float x, float y, float z, float rx, float ry, float rz){
    center = new PVector(x, y, z);
    radii = new PVector(rx, ry, rz);
  }
  
  public void setSurface(Surface s){
    this.s = s;
  }
  
  public Surface getSurface() {
    return s;
  }

}
