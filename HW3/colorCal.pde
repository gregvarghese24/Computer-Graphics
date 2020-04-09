PVector colorCal(Hit prevHit, float traceNum) {
  PVector finalColor = new PVector(0, 0, 0);
  if (prevHit.hit) {
    PVector colorHere = new PVector(0, 0, 0);
    //float max;
    for (Lights l : lights) {
      PVector N = prevHit.normal;
      PVector lightPos = l.getPosition();
      PVector hitPos = prevHit.intersection; 

      // SHADOWS ---------------------------------------
      Ray shadow = makeRay(hitPos, l.source);
      shadow.origin = PVector.add(shadow.origin, PVector.mult(shadow.direction, 0.0001));
      Hit shadowHit = intersectionCalc(shadow);
      if (debug_flag) {
        System.out.println("SHADOW HIT ~~~~~~~~~~~~~~~~~");
        System.out.println("hitPos: " +hitPos);
        System.out.println("lightPos: " + lightPos);
        System.out.println("shadow - Origin : " + shadow.origin + " Direction : " + shadow.direction);
        System.out.println("shadowHit ~~~~ \n Intersection: " + shadowHit.intersection);
        System.out.println("Normal: " + shadowHit.normal);
        System.out.println("t: " + shadowHit.t);
        System.out.println("Hit Boolean: " + shadowHit.hit);
        System.out.println();
      }
      // DIFFUSE ---------------------------------------
      PVector L_unormalized = PVector.sub(lightPos, hitPos);
      PVector L = L_unormalized.normalize();
      N = N.normalize();
      //System.out.println(l.getColors().x);
      float nl = PVector.dot(N, L);
      float max = max(0, nl);
      PVector lightRGB = new PVector(l.getColors().x, l.getColors().y, l.getColors().z);
      PVector surf_cd = new PVector(prevHit.surface.getDiffuseX(), prevHit.surface.getDiffuseY(), prevHit.surface.getDiffuseZ());

      //SPECULAR ----------------------------------------
      //adding surface specular
      Surface currSurface = prevHit.surface;
      PVector specular = new PVector(0, 0, 0);
      specular = PVector.add(specular, currSurface.specular);

      //create EyeRay to calc E
      Ray eyeRay_spec = new Ray(eye.eyePosition, prevHit.intersection);
      eyeRay_spec = eyeRay_spec.makeRay(eye.eyePosition, prevHit.intersection);

      PVector E = PVector.mult(eyeRay_spec.direction, -1);
      PVector H = PVector.add(L_unormalized, E).normalize();
      float hDotN = (float) Math.pow(PVector.dot(H, prevHit.normal), prevHit.surface.p);
      specular.mult(hDotN);
      specular.x = specular.x * lightRGB.x;
      specular.y = specular.y * lightRGB.y;
      specular.z = specular.z * lightRGB.z;

      // AMBIENT -----------------------------------------
      PVector ambient = new PVector(0, 0, 0);
      ambient = PVector.add(ambient, prevHit.surface.ambient);

      ambient.x = ambient.x * surf_cd.x * lightRGB.x;
      ambient.y = ambient.y * surf_cd.y * lightRGB.y;
      ambient.z = ambient.z * surf_cd.z * lightRGB.z;

      // SHADOW - special case
     // if (shadowHit.hit == true && PVector.dist(shadowHit.intersection, l.source) < shadowHit.t) {
      //  shadowHit = new Hit();
     // }

      // SHADOW - if statement
      if (shadowHit.hit == false || shadow.direction.mag() < PVector.sub(shadowHit.intersection, hitPos).mag()) {  //shadowHit.t >= Float.MAX_VALUE || shadowHit.t <= 0) {
          if (debug_flag) {
           System.out.println("Shadowhit.hit: " + shadowHit.hit);
           println("ShadowHit.t " + shadowHit.t);
           println("shadow.direction" + shadow.direction.mag());
          // println("2nd part - " + PVector.sub(shadowHit.intersection, hitPos).mag());
          }
        //DIFFUSE - adding to final
        colorHere = new PVector(colorHere.x+max*lightRGB.x*surf_cd.x, 
          colorHere.y+max*lightRGB.y*surf_cd.y, 
          colorHere.z+max*lightRGB.z*surf_cd.z);

        // SPECULAR - adding to final
        colorHere = new PVector(colorHere.x+specular.x, colorHere.y+specular.y, colorHere.z+specular.z);
      }


      // AMBIENT - adding to final
      colorHere = new PVector(colorHere.x+ambient.x, colorHere.y+ambient.y, colorHere.z+ambient.z);
    } //light loop end

    //REFLECTION - Recursive call
    if (prevHit.surface.k > 0 && traceNum < 10) {
      PVector e = PVector.sub(prevRay.origin, prevHit.intersection).normalize();
      float multiplier = 2.0 * PVector.dot(prevHit.normal, e);
      PVector reflDirection = PVector.sub(PVector.mult(prevHit.normal, multiplier), e);

      Ray reflRay = new Ray(prevHit.intersection, reflDirection);
      prevRay = reflRay;
      reflRay.origin = PVector.add(reflRay.origin, PVector.mult(reflRay.direction, 0.0001));
      Hit reflHit = intersectionCalc(reflRay);
      PVector reflection = colorCal(reflHit, traceNum + 1);
      reflection = new PVector(reflection.x, reflection.y, reflection.z);
      reflection = reflection.mult(prevHit.surface.k);
      colorHere.add(reflection);
      if (debug_flag) {
        System.out.println("e: " + e);
        System.out.println("krefl: " + prevHit.surface.k);
        System.out.println("reflection: " + reflection);
      }
    }

    finalColor = new PVector (colorHere.x, colorHere.y, colorHere.z);
  } else {

    finalColor = new PVector(backgroundColor.r, backgroundColor.g, backgroundColor.b);
  }
  return finalColor;
}

Ray makeRay(PVector origin, PVector intersection) {
  PVector direction = PVector.sub(intersection, origin);
  return new Ray(origin, direction);
}
