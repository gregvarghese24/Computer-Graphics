// Greg Varghese
// CS 3451
// Assignment 2b

// This is the love story of the century - love at first sight
// (A better love story than Twilight)

// For instancing, I called the same object of the main character, however, 
// I changed clothing and hair when the woman variable is marked true. 
// So they look like different people but they are the same object.
// 

// 3D Scene Example
import processing.sound.*;
// 
float time = 0;  // keep track of the passing of time
float s= 0;
float ss = 0;
float mouth = 0;
float b1 = 0;
float b2 = 0;
float b3 = 0;
float b4 = 0;
float ct1 = 75;
float ct2 = 40.0;
float transition = 0; // change to 0
float backTime = 0; //change to 0
float introTime = 20.0;
float trans3Rot = 0;
boolean female = false;
boolean walk = true;
boolean check = false;
boolean approved = true;
boolean transitional = false;
boolean womSpin = false;
float womHeadSpin = 0;
float trans8 = 300;
SoundFile file; 
void setup() {
  size(800, 800, P3D);  // must use 3D here!
  noStroke();           // do not draw the edges of polygons
  file = new SoundFile(this, "needy.mp3");
  file.play();
}
// background = loadImage(.png)
// background(background);
// Draw a scene with a cylinder, a box and a sphere
void draw() {
  
  resetMatrix();  // set the transformation matrix to the identity (important!)
  
  if (backTime <= 15) {
    background(0, 200, 0);  
    camera (0.0, 0.0, 50, 0.0, 50.0, 0.0, 0.0, 1.0, 0.0);
  } else if (backTime <= 30) {
   background(200, 0, 0);
   camera (0.0, 0.0, 50, 0.0, 40.0, 0.0, 0.0, 1.0, 0.0);
  } else if (backTime <= 45) {
   background(0, 0, 200);
   camera (0.0, 0.0, 50, 0.0, 30.0, 0.0, 0.0, 1.0, 0.0);
  } else if (backTime <= 60) {
   background(0, 200, 200);
   camera (0.0, 0.0, 50, 0.0, 20.0, 0.0, 0.0, 1.0, 0.0);
  } else if (backTime <= 75) {
   background(240, 0, 200);
  } else if (backTime <= 90) {
   background(90, 200, 0);
  } else if (backTime >= 91) {
    background(60,60,60);
  }
 backTime += .5;
  
  

  // set up for perspective projection
  perspective (PI * 0.333, 1.0, 0.01, 1000.0);

  // place the camera in the scene
  
  
  if (transition == 0 && backTime >= 59) {
    camera (0.0, 0.0, ct1, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
    ct1 -= 0.05;
    // (eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
  }
  
  if (transition == 1) {
    camera (0.0, 0.0, 80.0, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0);
  }
  
  if (transition == 2) {
    camera (0.0, 0.0, 40.0, 0.0, -10.0, -1.0, 0.0, 1.0, 0.0);
  }
  
  if (transition == 3) {
    camera (0.0, -17.0, ct2, 0.0, -10.0, -1.0, 0.0, 1.0, 0.0);
    ct2 -= 0.05;
  }
  
  if (transition == 6) {
    //ct2 = -100; //change!!
    camera (0.0, -17.0, ct2, 0.0, -10.0, -1.0, 0.0, 1.0, 0.0);
    ct2 -= 0.05;
    if (ct2 < -104) {
      transitional = true;
      transition = 3;
      ct2 = 40;
      walk = false;
    }
  }
  
  if (transition == 4) {
    camera (0.0, 0.0, 80.0, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0);
  }
  
  if (transition == 5) {
    camera (50.0, 0.0, 80.0, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0);
  }
  
  if (transition == 7) {
    camera (-50.0, -30.0, 0.0, 0.0, -1.0, -1.0, 0.0, 1.0, 0.0);
  }
  
  if (transition == 8) {
    //float trans8 = 300;
    camera (-160.0, -25.0, trans8, 0.0, -10.0, -1.0, 0.0, 1.0, 0.0);
    trans8 -= 0.1;
    if (trans8 < 290) {
      transition += 1;
    }
  }
  
  if (transition == 9) {
    file.stop();
  }
  
    
  
  // create an ambient light source
  ambientLight (102, 102, 102);

  ////create two directional light sources
  //lightSpecular (220, 220, 220);
  directionalLight (200, 200, 200, 0, 1, 1); //x,y,z
  directionalLight (200, 200, 200, 0, 0, -1); //color value, sat, brightness
  
  if (transition == 0) {
  pushMatrix();
  //translate(-b2,0);
  //rotateY (30); 
  //scale(.);
  body();
  popMatrix();
  if (b2 < 20){
  b2+= .05;
    }
  if (b2 >= 9) {
    b2 = 0;
    transition = transition + 1;
    }
  }
  
  if (transition == 1) {
  pushMatrix();
  translate(-b2,0);
  rotateY (30); 
  scale(.8);
  body();
  popMatrix();
  
  pushMatrix();
  translate(b2+20,-40,-80);
  scale(2);
  tree();
  popMatrix();
  
  pushMatrix();
  translate(b2-40,-40,-80);
  scale(2);
  tree();
  popMatrix();
  
  pushMatrix();
  translate(b2-80,-40,-80);
  scale(2);
  tree();
  popMatrix();
  
  pushMatrix();
  translate(b2+60,-40,-80);
  scale(2);
  tree();
  popMatrix();
  
  if (b2 < 13){
  b2+= .08;
    } else {
    transition += 1;
    b2 = 0;
    }  
  } 
  
  if (transition == 2) {
   walk = false;
  pushMatrix();
  //translate(-b2,0);
  rotateY (30); 
  scale(.8);
  body();
  popMatrix();
  
  pushMatrix();
  translate(b2+20,-40,-80);
  scale(2);
  tree();
  popMatrix();
  
  pushMatrix();
  translate(b2-40,-40,-80);
  scale(2);
  tree();
  popMatrix();
  
  pushMatrix();
  translate(b2-80,-40,-80);
  scale(2);
  tree();
  popMatrix();
  
  pushMatrix();
  translate(b2+60,-40,-80);
  scale(2);
  tree();
  popMatrix();
  
  }
  if (transition == 3) {
    
   pushMatrix();
  //translate(-b2,0);
  rotateY (30); 
  scale(.8);
  body();
  popMatrix();
  
  pushMatrix();
  translate(b2+20,-40,-80);
  scale(2);
  tree();
  popMatrix();
  
  pushMatrix();
  translate(b2-40,-40,-80);
  scale(2);
  tree();
  popMatrix();
  
  pushMatrix();
  translate(b2-80,-40,-80);
  scale(2);
  tree();
  popMatrix();
  
  pushMatrix();
  translate(b2+60,-40,-80);
  scale(2);
  tree();
  popMatrix();
  
  if (ct2 > 32) {
    ct2 = ct2;
  } else if (transitional == false) {
    
    transition += 1;
    ct2 = -100;
    
  } else if (transitional == true) {
    transition = 7 ;
  }
  
    
  }
  
  if (transition == 6 || transition == 8) {
  walk = false;
  if (approved = true){
    check = true;
     pushMatrix();
  //translate(-b2,0);
  rotateY (30); 
  scale(.8);
  body();
  popMatrix();
  
  pushMatrix();
  translate(b2+20,-40,-80);
  scale(2);
  tree();
  popMatrix();
  
  pushMatrix();
  translate(b2-40,-40,-80);
  scale(2);
  tree();
  popMatrix();
  
  pushMatrix();
  translate(b2-80,-40,-80);
  scale(2);
  tree();
  popMatrix();
  
  pushMatrix();
  translate(b2+60,-40,-80);
  scale(2);
  tree();
  popMatrix();
  }
  
  float b6 = 250;
  check = false;
  walk = true;
  pushMatrix();
  translate(-90,-10,b6);
  rotateY(PI);
  female();
  popMatrix();
  
      float b3 = 0;
    pushMatrix();
    translate(-120,-50,400);
    //translate(30,-b3,-b2);
    scale(2);
    tree();
    popMatrix();
    
    pushMatrix();
    translate(-60,-50,400);
    //translate(-30,-b3,-b2);
    scale(2);
    tree();
    popMatrix();
    
    //float b4 = 0;
    float b5 = 0;
    pushMatrix();
    translate(-20,-10,500);
    //translate(-70,-b5,-b4);
    scale(1);
    tree();
    popMatrix();
    
    pushMatrix();
    translate(-160,-10,500);
    //translate(70,-b5,-b4);
    scale(1);
    tree();
    popMatrix();

  
    
  }
  
  if (transition == 4 || transition == 5) {
    walk = true;
    pushMatrix();
    //rotateY(PI/8);
    female();
    popMatrix();
    float b3 = 0;
    pushMatrix();
    translate(0,-50,-40);
    translate(30,-b3,-b2);
    scale(2);
    tree();
    popMatrix();
    
    pushMatrix();
    translate(0,-50,-40);
    translate(-30,-b3,-b2);
    scale(2);
    tree();
    popMatrix();
    
    //float b4 = 0;
    float b5 = 0;
    pushMatrix();
    translate(0,-10,-40);
    translate(-70,-b5,-b4);
    scale(1);
    tree();
    popMatrix();
    
    pushMatrix();
    translate(0,-10,-40);
    translate(70,-b5,-b4);
    scale(1);
    tree();
    popMatrix();
    
    if (b2 < 18 && transition == 4){
      b2+= .11;
      b3+= .06;
      b4+= .06;
      b5+= .01;
    } else if (b2 <8 && transition == 5) {
      b2+= .11;
      b3+= .06;
      b4+= .06;
      b5+= .01;
    } else {
    transition += 1;
    b2 = 0;
    } 
  }
  
  if (transition == 7) {
    walk = true;
    pushMatrix();
    //rotateY(PI/8);
    female();
    popMatrix();
    //float b2 = 0;
    float b3 = 0;
    pushMatrix();
    translate(0,-50,-40);
    translate(30,-b3,-b2);
    scale(2);
    tree();
    popMatrix();
    
    pushMatrix();
    translate(0,-50,-40);
    translate(-30,-b3,-b2);
    scale(2);
    tree();
    popMatrix();
    
    float b4 = 0;
    float b5 = 0;
    pushMatrix();
    translate(0,-10,-40);
    translate(-70,-b5,-b2);
    scale(1);
    tree();
    popMatrix();
    
    pushMatrix();
    translate(0,-10,-40);
    translate(70,-b5,-b2);
    scale(1);
    tree();
    popMatrix();
    
    //if (b2 == 6) {
    //  womSpin = true; 
    //}
    
    if (b2 < 18){
      b2+= .11;
      b3+= .06;
      b4+= .06;
      b5+= .01;
    }
    
  }
  
  if (transition == 8) {
    
  }
}
  


void female(){
  female = true;
  pushMatrix();
  translate(0,-20);
  //rotateY(PI/8);
  if (transition == 2) {
    rotateY(b2);
    if (b2 < 1.37){
    b2 += .009;
    } else {
      trans3Rot = b2;
      b2 = 0;
      transition += 1;
    }
  }
  if (transition == 3) {
    rotateY(trans3Rot);
  } else if (transition == 6 && check == !false){
    rotateY(trans3Rot);
  } else if (transition == 7 && womSpin == true) {
    rotateY(trans3Rot);
  }
  
  if (transition == 7 && female == true){
    //rotateY(womHeadSpin);
    if (womHeadSpin < .8){
    womHeadSpin += .01;
    } else { transition += 1;}
    rotateY(-womHeadSpin);
  }
  head();
  popMatrix();
  
  pushMatrix();
  //rotateY(PI/8);
  upperBody();
  popMatrix();
  
  pushMatrix();
  //rotateY(PI/8);
  if (transition > 0 && walk == true) {
  translate (0, 0, 2 * sin(2 * time)); 
  }
  leftLeg();
  popMatrix();
  time += 0.03;
  
  pushMatrix();
  //rotateY(PI/8);
  if (transition > 0 && walk == true) {
  translate (0, 0, 2 * cos(2 * time));
  }
  rightLeg();
  popMatrix();
  time +=0.03;
  
  female = false;
  
}
  

  


void stars() {
  pushMatrix();
  fill (100, 100, 200);
  ambient (100, 100, 200);
  specular (0, 0, 0);
  shininess (1.0);
  translate (60, 0, -ss);
  rotate (-s, 1.0, -s,s);      // rotate based on time
  box (5);
  popMatrix();

  // step forward the time
  s += 1.09;
  ss += 0.53;
  
  if (ss > 299){
    ss = 0.5;
  }
}
void body() {
  
  pushMatrix();
  translate(0,-20);
  //rotateY(PI/8);
  if (transition == 2) {
    rotateY(b2);
    if (b2 < 1.37){
    b2 += .009;
    } else {
      trans3Rot = b2;
      b2 = 0;
      transition += 1;
    }
  }
  if (transition == 3 || transition == 4 || transition == 8) {
    rotateY(trans3Rot);
  } 
  
  
  head();
  popMatrix();
  
  pushMatrix();
  //rotateY(PI/8);
  upperBody();
  popMatrix();
  
  pushMatrix();
  //rotateY(PI/8);
  if (transition > 0 && walk == true) {
  translate (0, 0, 2 * sin(2 * time)); 
  }
  leftLeg();
  popMatrix();
  time += 0.03;
  
  pushMatrix();
  //rotateY(PI/8);
  if (transition > 0 && walk == true) {
  translate (0, 0, 2 * cos(2 * time));
  }
  rightLeg();
  popMatrix();
  time +=0.03;
}

void mainBody() {
  pushMatrix();
  translate(0,-20);
  //rotateY(PI/8);
  head();
  popMatrix();
  
  pushMatrix();
  rotateY(PI/8);
  upperBody();
  popMatrix();
  
  pushMatrix();
  rotateY(PI/8);
  //translate (0, 0, 2 * sin(2 * time));
  leftLeg();
  popMatrix();
  time += 0.03;
  
  pushMatrix();
  rotateY(PI/8);
  //translate (0, 0, 2 * cos(2 * time));
  rightLeg();
  popMatrix();
  time +=0.03;
}

void leftLeg() {
  //left leg
  
  pushMatrix();
  fill (0,0,0);
  if (female == true) {
    fill(240,240,240);
  }
  translate(-5,20,0);
  scale(.4, 1.2, 0.6);
  box(15);
  popMatrix();
  
  //left shoe 
  pushMatrix();
  fill (50,50,50);
  translate(-5,30,3);
  scale(.4, .2, 1);
  box(15);
  popMatrix();
  
}

void rightLeg() {
  //right leg
  pushMatrix();
  fill (0,0,0);
  if (female == true) {
    fill(240,240,240);
  }
  translate(5,20,0);
  scale(.4, 1.2, 0.6);
  box(15);
  popMatrix();
  
  //right shoe 
  pushMatrix();
  fill (50,50,50);
  translate(5,30,3);
  scale(.4, .2, 1);
  box(15);
  popMatrix();
}

void upperBody() {
  
  //Body Suit 
  pushMatrix();
  fill (0,0,0);
  if (female == true){
    fill(255, 20, 147);
  }
  scale(1.5, 1.5, 0.9);
  box(15);
  popMatrix();
  
  //White Shirt
  pushMatrix();
  fill (255,255,255);
  if (female == true) {
    fill(255, 148, 220);
  }
  scale(0.2, 1.5, 0.9);
  translate(0,-0.1,0.15);
  box(15);
  popMatrix();
  
  //button 1
  pushMatrix();

  fill (0,0,0);
  ambient (50, 50, 50);
  specular (155, 155, 155);
  shininess (15.0);

  translate (0, 5, 7);  // translate based on time
  sphere (.5);
  popMatrix();
  
  //button 2
  pushMatrix();

  fill (0,0,0);
  ambient (50, 50, 50);
  specular (155, 155, 155);
  shininess (15.0);

  translate (0, 0, 7);  // translate based on time
  sphere (.5);
  popMatrix();
  
  //button 3
  pushMatrix();

  fill (0,0,0);
  ambient (50, 50, 50);
  specular (155, 155, 155);
  shininess (15.0);

  translate (0, -5, 7);  // translate based on time
  sphere (.5);
  popMatrix();
  //left Arm
  pushMatrix();
  fill (20,20,20);
  if (female == true){
    fill(255, 20, 147);
  }
  translate(-13,-2,0);
  if (transition > 0 && walk == true) {
  translate (0, 0, 2 * cos(2 * time));
  }
  scale(0.2, 1.1, 0.6);
  box(15);
  popMatrix();
  
  //Right Arm
  pushMatrix();
  fill (20,20,20);
  if (female == true){
    fill(255, 20, 147);
  }
  translate(13,-2,0);
  if (transition > 0 && walk == true) {
  translate (0, 0, 2 * sin(2 * time)); 
  }
  scale(0.2, 1.1, 0.6);
  box(15);
  popMatrix();
  
  //left Hand
  pushMatrix();
  fill (210,180,140);
  translate(-13,8,0);
  if (transition > 0 && walk == true) {
  translate (0, 0, 2 * cos(2 * time));
  }
  scale(0.2, 0.2, 0.6);
  box(15);
  popMatrix();
  
  //right Hand
  pushMatrix();
  fill (210,180,140);
  translate(13,8,0);
  if (transition > 0 && walk == true) {
  translate (0, 0, 2 * sin(2 * time)); 
  }
  scale(0.2, 0.2, 0.6);
  box(15);
  popMatrix();

}

void head() {
  if (female == false) {
  pushMatrix();
  //TOP HAT 
  fill (0, 0, 0);       // "fill" sets both diffuse and ambient color
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (8.0);            // set specular exponent
  translate (0, -18, 0);
  cylinder (8, 8.2, 32);
  popMatrix();
  }
  
  //HEAD 
  pushMatrix();
  fill (210,180,140);
  ambient (145, 129, 81);
  specular (0,0,0);
  shininess (1.0);
  box(15);
  popMatrix();
  
  //Woman's Hair
  if (female == true) {
  pushMatrix();
  fill (250, 240, 190);
  ambient (145, 129, 81);
  specular (0,0,0);
  shininess (1.0);
  scale(1,1,1);
  translate(0,-4,-5);
  box(14.9);
  popMatrix();
  }
  
  //front hair
  for (int i = -8; i < 9; i++) {
  pushMatrix();
  fill (255,127,80);
  if (female == true) {
    fill(250, 240, 190);
  }
  ambient (50, 50, 50);
  specular (155, 155, 155);
  shininess (15.0);
  translate (i, -8, 8);  // translate based on time
  if (female == true){
  sphere (2);
  } else {
    sphere(1);
  }
  popMatrix();
  }
  //LEFT EAR
  pushMatrix();
  fill (20,20,20);
  translate(-7.5,0,0);
  scale(0.2, 0.2, 0.1);
  box(15);
  popMatrix();
  
  //left earring
  pushMatrix();

  fill (255,215,0);
  ambient (50, 50, 50);
  specular (155, 155, 155);
  shininess (15.0);

  translate (-8.5, 1.9, 0);  // translate based on time
  sphere (.5);
  popMatrix();

  
  //RIGHT EAR
  pushMatrix();
  fill (20,20,20);
  translate(7.5,0,0);
  scale(0.2, 0.2, 0.1);
  box(15);
  popMatrix();
  
  //HAT BRIM
  if (female == false) {
  pushMatrix();
  fill(0,0,0);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (8.0); 
  scale(1.4,0.15,1.2);
  translate (0, -58, 0);
  box(15);
  popMatrix();
  }
  
  //RIGHT EYE GLASSES
  pushMatrix();
  fill(225,225,225);  
  scale(0.3,0.3, 0.1);
  translate (13, -10, 80);     
  box(15);
  popMatrix();
  
  //LEFT RIGHT EYE GLASSES
  pushMatrix();
  scale(0.3,0.3, 0.1);
  translate (-13, -10, 80); 
  
  box(15);
  popMatrix();
  
  //GLASSES BRIDGE
  pushMatrix();
  fill(0,0,0);
  
  scale(0.25,0.05, 0.1);
  translate (0, -60, 80); 
  
  box(15);
  popMatrix();
  
  //LEFT RIGHT BLACK
  pushMatrix();
  fill(0,0,0); 
  
  scale(0.1,0.1, 0.1);
  translate (-37, -30, 81); 
  
  box(15);
  popMatrix();
  
  //RIGHT RIGHT BLACK
  pushMatrix();
  fill(0,0,0); 
  
  scale(0.1,0.1, 0.1);
  translate (37, -30, 81); 
  
  box(15);
  popMatrix();
  
  //GINGER BEARD
  if (female == false) {
  pushMatrix();
  fill(255,127,80); 
  scale(0.44,0.6, 0.1);
  translate (0, 10, 81); 
  
  box(15);
  popMatrix();
  }
  
  //LIPS
  pushMatrix();
  fill(210,180,140); 
  scale(0.3,0.25, 0.1);
  translate (0, 15, 84); 
  
  box(15);
  popMatrix();
  
  //MOUTH
  pushMatrix();
  fill(0,0,0); 
  scale(0.15,0.125, 0.1);
  translate (0, 25, 84); 
  box(15);
  popMatrix();
  
}

void tree() {
 pushMatrix();
 fill(150,75,0);
 translate(0,0,0);
 cylinder(3,40,10);
 popMatrix();
 
 pushMatrix();
 fill(59,122,87);
 sphere(10);
 popMatrix();
 
 pushMatrix();
 fill(59,122,87);
 translate(10,0,0);
 sphere(5);
 popMatrix();
 
 pushMatrix();
 fill(59,122,87);
 translate(-8,5,0);
 sphere(5);
 popMatrix();
}



// Draw a cylinder of a given radius, height and number of sides.
// The base is on the y=0 plane, and it extends vertically in the y direction.
void cylinder (float radius, float height, int sides) {
  int i,ii;
  float []c = new float[sides];
  float []s = new float[sides];

  for (i = 0; i < sides; i++) {
    float theta = TWO_PI * i / (float) sides;
    c[i] = cos(theta);
    s[i] = sin(theta);
  }
  
  // bottom end cap
  
  normal (0.0, -1.0, 0.0);
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape(TRIANGLES);
    vertex (c[ii] * radius, 0.0, s[ii] * radius);
    vertex (c[i] * radius, 0.0, s[i] * radius);
    vertex (0.0, 0.0, 0.0);
    endShape();
  }
  
  // top end cap

  normal (0.0, 1.0, 0.0);
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape(TRIANGLES);
    vertex (c[ii] * radius, height, s[ii] * radius);
    vertex (c[i] * radius, height, s[i] * radius);
    vertex (0.0, height, 0.0);
    endShape();
  }
  
  // main body of cylinder
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape();
    normal (c[i], 0.0, s[i]);
    vertex (c[i] * radius, 0.0, s[i] * radius);
    vertex (c[i] * radius, height, s[i] * radius);
    normal (c[ii], 0.0, s[ii]);
    vertex (c[ii] * radius, height, s[ii] * radius);
    vertex (c[ii] * radius, 0.0, s[ii] * radius);
    endShape(CLOSE);
  }
}
