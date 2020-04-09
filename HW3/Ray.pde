public class Ray{
  PVector origin;
  PVector direction;
  PVector ray;
  
  public Ray(PVector origin, PVector direction) {
    this.origin = origin;
    this.direction = direction;
  }
  
  public PVector getOrigin() {
    return origin; 
  }
  
  public PVector getDirection() {
    return direction;
  }
  public Ray makeRay(PVector origin, PVector intersection) {
    PVector direction = PVector.sub(intersection, origin).normalize();
    return new Ray(origin, direction);
  }
  
  
  //ray direction = -dw + uu + vv // -vV because processing is flipped

  public PVector calculateRay(int x, int y) {
  float d = 1.0 / tan(fov_angle / 2.0); //radians !!
  float u = -1.0 + (2.0 * x / (float) width);
  float v = -1.0 + (2.0 * y / (float) height);
  
  PVector wd = PVector.mult(camera.w, -d);
  PVector uu = PVector.mult(camera.u, u);
  PVector vv = PVector.mult(camera.v, -v);
  
  PVector rayDirection = PVector.add(wd, uu);
  rayDirection = PVector.add(rayDirection, vv);
  return rayDirection; 
  } 
  
  public PVector getRay() {
    return ray;
  }
  
  
}
