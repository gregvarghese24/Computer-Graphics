public class Hit extends Surface{
  boolean hit;
  float t;
  PVector intersection, normal,p;
  PVector surfacee;
  Surface surface;

  // Initialize with this constructor if there is a hit.
  public Hit(float x, float y, float z, float nx, float ny, float nz, float t, Surface s, boolean hit) {
    this.t = t;
    this.surface = s;
    this.intersection = new PVector(x, y, z);
    this.normal = new PVector(nx, ny, nz);
    this.hit = hit;
  }

  public Hit(PVector intersection, PVector normal, float t, Surface s, boolean hit) { //used a lot 
    this.t = t;
    this.surface = s;
    this.intersection = intersection;
    this.normal = normal;
    this.hit = hit;
  

  }

  // initialize with empty constructor if there is no hit.
  public Hit() {
    this.hit = false;
    this.t = Float.MAX_VALUE;
  }
  
  public PVector getIntersection() {
    return intersection;
  }
  
  public PVector getNormal() {
    return normal;
  }
  
  public Surface getSurface() {
    return surface;
  }
}
