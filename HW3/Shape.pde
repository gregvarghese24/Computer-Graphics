public abstract class Shape {
  float x, y, z;
  Surface surface;
  PVector pos;
  
  public Shape() {
    pos = new PVector(0,0,0);
    //surface = new Surface();
  }
  
  //public PVector getPosition() {
  //  return pos;
  //}
  
  //public PVector getSurface() {
  //  //return surface;
  //}
}
