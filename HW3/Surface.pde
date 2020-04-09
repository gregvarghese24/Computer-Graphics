//Greg Varghese
//Surface Class

public class Surface {
  
  PVector diffuse;
  PVector ambient;
  PVector specular;
  float p; //not important
  float k; //not important
  
  Surface() {
    diffuse = new PVector(0,0,0);
    
  }
  
  

  public Surface(float Cdr, float Cdg, float Cdb, float Car,
                    float Cag, float Cab, float Csr, float Csg, 
                                    float Csb, float P, float K){
                                      
         diffuse = new PVector(Cdr, Cdg, Cdb);
         ambient = new PVector(Car, Cag, Cab);
         specular = new PVector(Csr, Csg, Csb);
         p = P;
         k = K;
    
  }
  
  public float getDiffuseX() {
    return diffuse.x;
  }
  
  public float getDiffuseY() {
    return diffuse.y;
  }
  
  public float getDiffuseZ() {
    return diffuse.z;
  }
  
  public PVector getSpecular() {
    return specular;
  }
  

}
