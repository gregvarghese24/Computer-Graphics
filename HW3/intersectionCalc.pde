Hit intersectionCalc(Ray ray) {
  PVector eye_direction = ray.direction;
  PVector eye_origin = ray.origin;
  PVector p = new PVector(0, 0, 0);
  
  hit = false;
  float t = Float.MAX_VALUE;
  Hit prevHit = new Hit();
  for (Disk aDisk : diskList) {
    //Hit tempHit = new Hit();

    PVector paren = PVector.sub(aDisk.getCenter(), ray.getOrigin());
    float numerator = PVector.dot( aDisk.getSurfaceNormal(), paren);
    float denominator = PVector.dot(aDisk.getSurfaceNormal(), eye_direction);
    float currT = numerator/denominator;
    //currT= -currT;


    //System.out.println(hit);
    //p = PVector.mult(eye_direction, t);
    //p = PVector.add(p, eye_origin);
    PVector intersection = PVector.add(eye_origin, PVector.mult(eye_direction, currT)); //!!!!
    float distance = PVector.dist(intersection, aDisk.getCenter());
    if (debug_flag) {
      println("before if");
      println("paren: " + paren +"\n numerator: " + numerator + "\n denom: " + denominator);
      println("CurrT : " + currT);
      println("eye_origin: " + eye_origin);
      println();
    }
    if (distance <= aDisk.getRadius() && currT < t && currT > 0) {
      t = currT;
      hit = true;
      if (debug_flag) {
        System.out.println("Disk prevHits -------------------------\n Intersection: " + intersection);
        System.out.println("Disk T: " + t);
        println("Eye_origin: " + eye_origin);
        println();
      }  
      prevHit = new Hit(intersection, aDisk.surfaceNormal, t, aDisk.getSurface(), hit);
     
      
    }
    //System.out.println(t);
    p = PVector.mult(eye_direction, t);
    p = PVector.add(p, eye_origin);
  } 

  for (Ellipsoid aEllipsoid : ellipsoidList) {
    // Getting T
    //PVector paren = PVector.sub(aEllipsoid.getCenter(), prevRay.getOrigin());
    //float numerator = PVector.dot( aDisk.getSurfaceNormal(), paren);
    //float denominator = PVector.dot(aDisk.getSurfaceNormal(), eye_direction);
    //float currT = numerator/denominator;
    // eye origin - ellipod center
    PVector updatedOrigin = PVector.sub(eye_origin, aEllipsoid.center);

    float a = (sq(eye_direction.x)/sq(aEllipsoid.radii.x)) + (sq(eye_direction.y)/sq(aEllipsoid.radii.y)) + (sq(eye_direction.z)/sq(aEllipsoid.radii.z));
    float b = ((updatedOrigin.x*eye_direction.x)/sq(aEllipsoid.radii.x)) + ((updatedOrigin.y*eye_direction.y)/sq(aEllipsoid.radii.y)) + ((updatedOrigin.z*eye_direction.z)/sq(aEllipsoid.radii.z));
    b = 2 * b;
    float c = (sq(updatedOrigin.x)/sq(aEllipsoid.radii.x)) + (sq(updatedOrigin.y)/sq(aEllipsoid.radii.y)) + (sq(updatedOrigin.z)/sq(aEllipsoid.radii.z));
    c = c - 1;

    float tPlus = (-b + sqrt(sq(b) - 4*a*c))/(2*a);
    float tMinus = (-b - sqrt(sq(b) - 4*a*c))/(2*a); //smallest and greater than 0
    float currT = -1;
    if (tPlus > 0 && tMinus > 0) {
      currT = min(tPlus, tMinus);
      PVector intersection = PVector.add(eye_origin, PVector.mult(eye_direction, currT));
      PVector sphereNormal = PVector.sub(intersection, aEllipsoid.center);
      float ellipRadiiSqX = sq(aEllipsoid.radii.x);
      float ellipRadiiSqY = sq(aEllipsoid.radii.y);
      float ellipRadiiSqZ = sq(aEllipsoid.radii.z);



      if (currT < prevHit.t) {
        //do here
        sphereNormal.x = (sphereNormal.x/ellipRadiiSqX);
        sphereNormal.y = (sphereNormal.y/ellipRadiiSqY);
        sphereNormal.z = (sphereNormal.z/ellipRadiiSqZ);
        sphereNormal.normalize();
        // PVector spherenormal = new PVector(sphereNormalX, sphereNormalY, sphereNormalZ).normalize();
        hit = true;
        prevHit = new Hit(intersection, sphereNormal, currT, aEllipsoid.getSurface(), hit);
        
      }
    } else if (tPlus >= 0 && tMinus < 0) {
      currT = tPlus; 
      if (currT < prevHit.t) {
        //do here
        PVector intersection = PVector.add(eye_origin, PVector.mult(eye_direction, currT));
        PVector sphereNormal = PVector.sub(intersection, aEllipsoid.center);
        float ellipRadiiSqX = sq(aEllipsoid.radii.x);
        float ellipRadiiSqY = sq(aEllipsoid.radii.y);
        float ellipRadiiSqZ = sq(aEllipsoid.radii.z);

        sphereNormal.x = (sphereNormal.x/ellipRadiiSqX);
        sphereNormal.y = (sphereNormal.y/ellipRadiiSqY);
        sphereNormal.z = (sphereNormal.z/ellipRadiiSqZ);
        sphereNormal.normalize();
        // PVector spherenormal = new PVector(sphereNormalX, sphereNormalY, sphereNormalZ).normalize();
        hit = true;
        prevHit = new Hit(intersection, sphereNormal, currT, aEllipsoid.getSurface(), hit);
        
        //normal
        //2steps
        // find intersection point 
        // find sphere normal - intersection point -center of ellip
        // scale sphere normal | sphere.normal.x/(ellip.raddius.x^2).normalize() <-- sphere normal, pass it in ellip radius
        //
      }
    } else if (tMinus >= 0 && tPlus <=0) {
      currT = tMinus; // set prevHit if currT < prevHit.currT

      if (currT < prevHit.t) {
        //do here
        PVector intersection = PVector.add(eye_origin, PVector.mult(eye_direction, currT));
        PVector sphereNormal = PVector.sub(intersection, aEllipsoid.center);
        float ellipRadiiSqX = sq(aEllipsoid.radii.x);
        float ellipRadiiSqY = sq(aEllipsoid.radii.y);
        float ellipRadiiSqZ = sq(aEllipsoid.radii.z);

        sphereNormal.x = (sphereNormal.x/ellipRadiiSqX);
        sphereNormal.y = (sphereNormal.y/ellipRadiiSqY);
        sphereNormal.z = (sphereNormal.z/ellipRadiiSqZ);
        sphereNormal.normalize();
        // PVector spherenormal = new PVector(sphereNormalX, sphereNormalY, sphereNormalZ).normalize();
        hit = true;
        prevHit = new Hit(intersection, sphereNormal, currT, aEllipsoid.getSurface(), hit);
       
      }
    }
    PVector rayEquation = PVector.mult(eye_direction, currT);
    rayEquation = PVector.add(rayEquation, updatedOrigin); //THis is our hit
  }
  return prevHit;
}
