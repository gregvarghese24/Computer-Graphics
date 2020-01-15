// Greg Varghese
// CS 3451

void setup(){
  size (800, 800); // set size of screen (in pixels)
  background (255, 255, 255); // set background color to white
  noStroke(); // don't draw shape outlines
  //fill(0, 0, 0); // fill with black color
}

float width = 200;
float length = 200;

void draw() {
  background(255);
  drawRect (mouseX, mouseY, 400, 400, width/2, length/2);
  mainRect();
  }

void mainRect(){
  rectMode(CENTER);
  fill(0, 0, 0);
  rect(400, 400, width, length); //center square
  
  
}

void drawRect(float x1, float x2, float s, float t, float width, float leng){
  rectMode(CENTER);
  //color changes 
  if (x1 < 400 && x2 < 400){
    fill(0, 90, 0);
  } else if (x1 < 400 && x2 > 400) {
    fill (0, 0, 90);
  } else if (x1 > 400 && x2 > 400) {
    fill (0, 90, 90);
  } else {
    fill (90, 0, 90);
  }
    
  rect(s - (s-x1),t - (t-x2), width, leng);
  rect(s + (s-x1),t + (t-x2), width, leng); //bottom
  rect(t + (t-x2),s - (s-x1), width, leng);
  rect(t - (t-x2),s + (s-x1), width, leng);
  
  //drawRect(sqrt(x1), sqrt(x2), s -(s-x1), t - (t-x2), width/3, leng/3);

  drawSmallRect(width/2, leng/2, s -(s-x1),  t - (t-x2), width/2, leng/2);
  drawSmallRect(mouseX, mouseY, s + (s-x1),t + (t-x2), width/2, leng/2);
  drawSmallRect(mouseX, mouseY, t + (t-x2),s - (s-x1), width/2, leng/2);
  drawSmallRect(mouseX, mouseY, s -(s-x1),t - (t-x2), width/2, leng/2);
  
  if (mousePressed == true){
    float a = sq(s -(s-x1)) + sq(t - (t-x2));
    a = sqrt(a);
  print("a = ", mouseX, " mY = ", mouseY, "s = ", s -(s-x1), "t = ", t - (t-x2));
  }
  
}

void drawSmallRect(float x, float y, float s, float t, float w, float l){
  rectMode(CENTER);
  
    if (x < 400 && y < 400){
    fill(90, 0, 90);
  } else if (x < 400 && y > 400) {
    fill (0, 90, 90);
  } else if (x > 400 && y > 400) {
    fill (0, 0, 90);
  } else {
    fill (90, 0, 0);
  }
  if (mousePressed == true){
  print("a = ", x, " mY = ", y, "s = ", s -(s-x), "t = ", t - (t-y));
  }

  rect(x, y, w, l);
  rect(s + (s-x),t + (t-y), w, l); //bottom
  rect(t + (t-y),s - (s-x), w, l);
  rect(t - (t-y),s + (s-x), w, l);
  //drawSmallRect1(float x, float y, float s, float t, float w, float l)
}

void drawSmallRect1(float x, float y, float s, float t, float w, float l){
  rectMode(CENTER);
  if (mousePressed == true){
  print("a = ", x, " mY = ", y, "s = ", s -(s-x), "t = ", t - (t-y));
  }
  
  //float x1 = 
  fill(90,0,0);
  rect(x, y, w, l);
  rect(s + (s-x),t + (t-y), w, l); //bottom
  rect(t + (t-y),s - (s-x), w, l);
  rect(t - (t-y),s + (s-x), w, l);
}


