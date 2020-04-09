// This is the starter code for the CS 3451 Ray Tracing Project.
// GREG VARGHESE
// CS3451


float fov_angle = 0;
color background_color;
Eye eye;

ArrayList<Lights> lights = new ArrayList();
Lights newLights;

Camera camera; 
Surface surface;
Ellipsoid ellipsoid;
Disk disk;
Ray prevRay;
boolean hit;
Hit finalHit;


PVector initialVect;
ArrayList<Disk> diskList = new ArrayList<Disk>();
ArrayList<Ellipsoid> ellipsoidList = new ArrayList<Ellipsoid>();
Color backgroundColor;
PVector intersection;


boolean debug_flag;  // help to print information for just one pixel

void setup() {
  size(500, 500);  
  noStroke();
  colorMode(RGB);
  background(0, 0, 0);
}

void reset_scene() {
  //reset the global scene variables here
  fov_angle = 0.0;
  background_color = 0;
  eye = null;
  lights = new ArrayList();
  camera = new Camera(0, 0, 0, 0, 0, 0, 0, 0, 0);
  surface = new Surface(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
  ellipsoid = null;
  diskList.clear();
  ellipsoidList.clear();
  prevRay = new Ray(initialVect, initialVect);
  hit = false;
  //intersection = null;

  ///prevHit = new Hit();

  //finalHit = null;
}

void keyPressed() {
  reset_scene();
  switch(key) {
  case '1':  
    interpreter("01.cli"); 
    break;
  case '2':  
    interpreter("02.cli"); 
    break;
  case '3':  
    interpreter("03.cli"); 
    break;
  case '4':  
    interpreter("04.cli"); 
    break;
  case '5':  
    interpreter("05.cli"); 
    break;
  case '6':  
    interpreter("06.cli"); 
    break;
  case '7':  
    interpreter("07.cli"); 
    break;
  case '8':  
    interpreter("08.cli"); 
    break;
  case '9':  
    interpreter("09.cli"); 
    break;
  case '0':  
    interpreter("10.cli"); 
    break;
  case '-':  
    interpreter("11.cli"); 
    break;
  case 'q':  
    exit(); 
    break;
  }
}

// this routine helps parse the text in the scene description files
void interpreter(String filename) {

  println("Parsing '" + filename + "'");
  String str[] = loadStrings(filename);
  if (str == null) println("Error! Failed to read the cli file.");

  for (int i = 0; i < str.length; i++) {

    String[] token = splitTokens(str[i], " ");  // Get a line and parse the tokens

    if (token.length == 0) continue; // Skip blank lines

    if (token[0].equals("fov")) {
      float fov = float(token[1]);
      // call routine to save the field of view
      fov_angle = fov;
    } else if (token[0].equals("background")) {
      float r = float(token[1]);
      float g = float(token[2]);
      float b = float(token[3]);
      // call routine to save the background color
      backgroundColor = new Color(r, g, b); 
      // ask if the values are decimal ******
    } else if (token[0].equals("eye")) {
      float x = float(token[1]);
      float y = float(token[2]);
      float z = float(token[3]);
      // call routine to save the eye position
      eye = new Eye(x, y, z);
    } else if (token[0].equals("uvw")) {
      float ux = float(token[1]);
      float uy = float(token[2]);
      float uz = float(token[3]);
      float vx = float(token[4]);
      float vy = float(token[5]);
      float vz = float(token[6]);
      float wx = float(token[7]);
      float wy = float(token[8]);
      float wz = float(token[9]);
      // call routine to save the camera's values for u,v,w
      camera = new Camera(ux, uy, uz, vx, vy, vz, wx, wy, wz);
    } else if (token[0].equals("light")) {
      float x = float(token[1]);
      float y = float(token[2]);
      float z = float(token[3]);
      float r = float(token[4]);
      float g = float(token[5]);
      float b = float(token[6]);
      newLights = new Lights(x, y, z, r, g, b);
      lights.add(newLights);
      // call routine to save lighting information
    } else if (token[0].equals("surface")) {
      float Cdr = float(token[1]);
      float Cdg = float(token[2]);
      float Cdb = float(token[3]); //diffuse color
      float Car = float(token[4]);
      float Cag = float(token[5]);
      float Cab = float(token[6]); //ambient
      float Csr = float(token[7]);
      float Csg = float(token[8]);
      float Csb = float(token[9]);// specular
      float P = float(token[10]);
      float K = float(token[11]);
      // call routine to save the surface material properties
      surface = new Surface(Cdr, Cdg, Cdb, Car, Cag, Cab, Csr, Csg, Csb, P, K);
    } else if (token[0].equals("ellipsoid")) {
      float x = float(token[1]);
      float y = float(token[2]);
      float z = float(token[3]);
      float rx = float(token[4]);
      float ry = float(token[5]);
      float rz = float(token[6]);
      // call routine to save ellipsoid here
      ellipsoid = new Ellipsoid(x, y, z, rx, ry, rz);
      ellipsoidList.add(ellipsoid);
      ellipsoid.setSurface(surface);
    } else if (token[0].equals("disk")) {
      float x = float(token[1]);
      float y = float(token[2]);
      float z = float(token[3]);
      float nx = float(token[4]);
      float ny = float(token[5]);
      float nz = float(token[6]);
      float radius = float(token[7]);
      // call routine to save disk here
      disk = new Disk(x, y, z, nx, ny, nz, radius);
      diskList.add(disk);
      disk.setSurface(surface);
    } else if (token[0].equals("write")) {
      draw_scene();   // here is where you actually perform the ray tracing
      println("Saving image to '" + token[1] + "'");
      save(token[1]); // this saves your ray traced scene to a .png file
    } else if (token[0].equals("#")) {
      // comment symbol (ignore this line)
    } else {
      println ("cannot parse this line: " + str[i]);
    }
  }
}

// This is where you should place your code for creating the eye rays and tracing them.

void draw_scene() {
  //System.out.println(fov_angle);
  Surface hit_surf = new Surface();
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {

      //boolean hit = faslse 
      // maybe turn on a debug flag for a particular pixel (so you can print ray information)

      if (x == 262 && y == 324)
        debug_flag = true;
      else
        debug_flag = false;
      //finalHit.hit = false;
      // create and cast an eye ray here
      float d = 1.0 / tan(radians(fov_angle) / 2.0); //radians !!
      float u = -1.0 + (2.0 * x / (float) width);
      float v = -1.0 + (2.0 * y / (float) height);
      //EYE Direction Ed
      PVector wd = PVector.mult(camera.getW(), -d);
      PVector uu = PVector.mult(camera.getU(), u);
      PVector vv = PVector.mult(camera.getV(), -v);
      PVector rayDirection = PVector.add(vv, uu);
      // ray direction = -dw + uu + vv
      PVector eye_direction = PVector.add(rayDirection, wd); //ray direction

      // Eye Origin E0
      PVector eye_origin = eye.eyePosition; //ray origin


      // make new eye ray and store it for recursive call later 
      Ray eyeRay = new Ray(eye_origin, eye_direction); 
      prevRay = eyeRay;
      Hit prevHit = new Hit();
      prevHit = intersectionCalc(eyeRay);
      PVector colors = colorCal(prevHit, 0);
      fill (colors.x*255, colors.y*255, colors.z*255);
      rect (x, y, 1, 1);
    }
  }
}

void draw() {
  // nothing should be put here for this project
}

// use this routine to find the coordinates of a particular pixel (for debugging)
void mousePressed()
{
  println ("Mouse pressed at location: " + mouseX + " " + mouseY);
}

//ray direction = -dw + uu + vv
