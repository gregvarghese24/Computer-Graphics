// Declare the global variables
// Greg Varghese

PShader floor_shader;
PShader circles_shader;
PShader image_manip_shader;
PShader bumps_shader;

PImage duck_texture;
PImage bumps_texture;

float offsetY;
float offsetX;
float zoom = -200;
boolean locked = false;
float dirY = 0;
float dirX = 0;
float time = 0;

// initialize the variables and load the shaders
void setup() {
  size(640, 640, P3D);
  offsetX = width/2;
  offsetY = height/2;
  noStroke();
  fill(204);

  // load a few textures
  duck_texture = loadImage("data/pic_duck.bmp");
  bumps_texture = loadImage("data/pic_bumps.jpg");

  // load the shaders
  circles_shader = loadShader("data/circles.frag", "data/circles.vert");
  image_manip_shader = loadShader("data/image_manip.frag", "data/image_manip.vert");
  bumps_shader = loadShader("data/bumps.frag", "data/bumps.vert");
  floor_shader = loadShader("data/floor.frag", "data/floor.vert");
}

void draw() {

  background(0);

  // control the scene rotation using the current mouse location
  if (!locked) {
    dirY = (mouseY / float(height) - 0.5) * 2;
    dirX = (mouseX / float(width) - 0.5) * 2;
  }

  // if the mouse is pressed, update the x and z camera locations
  if (mousePressed) {
    offsetY += (mouseY - pmouseY);
    offsetX += (mouseX - pmouseX);
  }

  // create a directional light
  directionalLight(204, 204, 204, 0, 0, -1);

  // translate and rotate all objects to simulate a camera
  // NOTE: processing +y points DOWN (yuck)
  translate(offsetX, offsetY, zoom);
  rotateY(-dirX * 1.5);
  rotateX(dirY);
  
  // Render a floor plane with the default shader
  shader(floor_shader);
  beginShape();
  vertex(-300, 300, -400);
  vertex( 300, 300, -400);
  vertex( 300, 300, 200);
  vertex(-300, 300, 200);
  endShape();

  // Render the image manipulation shader
  shader(image_manip_shader);
  image_manip_shader.set ("time", time);  // pass the "time" value to the shader
  textureMode(NORMAL);
  beginShape();
  texture(duck_texture);
  vertex(-300, 50, 100, 0, 0);
  vertex(-50, 50, 100, 1, 0);
  vertex(-50, 300, 100, 1, 1);
  vertex(-300, 300, 100, 0, 1);
  endShape();

  // Draw using the bump shader
  // (You will need to chop this polygon into many tiny pieces
  // to prepare it for the vertex shader.)
  //shader(bumps_shader);
  //pushMatrix();
  //translate (-150, 0, -200);
  //beginShape();
  //texture(bumps_texture);
  //vertex(0, 0, 0, 0, 0);
  //vertex(300, 0, 0, 1, 0);
  //vertex(300, 300, 0, 1, 1);
  //vertex(0, 300, 0, 0, 1);
  //endShape();
  //popMatrix();
  pushMatrix();
  shader(bumps_shader);
  
  translate (160, 0, 50);
  float range = 50.0; 
  float scale = -300;
  for(float x = 0; x < range; x ++)
  {
    for(float y = 0; y < range; y ++)
    {
      beginShape();
      texture(bumps_texture);

      vertex(scale + x * 5, range + y * 5, scale, x / range, y / range);
      vertex((scale + 5) + x * 5, range + y * 5, scale, (x + 1) / range, y / range);
      vertex((scale + 5)  + x * 5, 55 + y * 5, scale, (x + 1) / range, (y + 1) / range);
      vertex(scale + x * 5, 55 + y * 5, scale, x / range, (y + 1) / range);

      endShape();
    }
  }
  popMatrix();

  // Draw using the circles shader
  shader(circles_shader);
  beginShape();
  vertex(50, 50, 100, 0, 0);
  vertex(300, 50, 100, 1, 0);
  vertex(300, 300, 100, 1, 1);
  vertex(50, 300, 100, 0, 1);
  endShape();

  // update the time variable
  time += 0.01;
  if (time > 1)
    time = 0;
}

// lock or unlock the camera
void keyPressed() {
  if (key == ' ') {
    locked = !locked;
  }
}

// zooming
void mouseWheel(MouseEvent event) {
  zoom += event.getAmount() * 12.0;
}
