// Dummy routines for OpenGL commands.
// These are for you to write!
// You should incorporate your transformation matrix routines from part A of this project.

// Greg Varghese
// CS 3451
// Homework 1b
// 31 January 2020

// Matrix Stack Library
import java.util.Stack;
import java.lang.Math;
import java.util.ArrayList;
float windowWidth = 500;
float windowHeight = 500;
Stack<float[][]> update = new Stack();
float[][] ctm = new float[4][4];
float[][] matrix = new float[4][4];


// You should modify the routines listed below to complete the assignment.
// Feel free to define any classes, global variables and helper routines that you need.

float left;
float right;
float top;
float bottom;
float near0;
float far0;
float fov0;
float k; 

float[] fovList; 
float[] points;

boolean ortho = false; 

ArrayList<float[]> vList = new ArrayList<float[]>();




float[][] multiply(float[][] m1, float[][] m2) {
  float[][] ident = identityMatrix();
  for (int i = 0; i < 4; ++i) {
    for (int j = 0; j < 4; ++j) {
      ident[i][j] = 0.0;
      for (int k = 0; k < 4; ++k) {
        ident[i][j] += (m1[i][k]) * (m2[k][j]);
      }
    }
  }
  return ident;
}

void Init_Matrix()
{
  for (int i = 0; i < 4; ++i) {
    for (int j = 0; j < 4; ++j) {
      if (i == j)
        ctm[i][j] = 1.0;
      else
        ctm[i][j] = 0.0;
    }
  }
  update.push(ctm);
  
}

float[][] identityMatrix()
{
  float[][] identity = new float[4][4];
  for (int i = 0; i < 4; ++i) {
    for (int j = 0; j < 4; ++j) {
      if (i == j)
        identity[i][j] = 1.0;
      else
        identity[i][j] = 0.0;
    }
  }
  return identity;
  
}


void Translate(float x, float y, float z)
{
  float[][] m1 = identityMatrix();
  m1[0][3] = x;
  m1[1][3] = y;
  m1[2][3] = z;
  float[][] ans = multiply(update.peek(), m1);
  update.push(ans);
}

void Scale(float x, float y, float z)
{
  float[][] m1 = identityMatrix();
  m1[0][0] = x;
  m1[1][1] = y;
  m1[2][2] = z;
  float[][] ans = multiply(update.peek(), m1);
  update.push(ans);
}

void RotateX(float theta)
{
  theta = (float)Math.toRadians(theta);
  float[][] m1 = identityMatrix();
  m1[1][1] = cos(theta);
  m1[1][2] = -sin(theta);
  m1[2][1] = sin(theta);
  m1[2][2] = cos(theta);
  float[][] ans = multiply(update.peek(), m1);
  update.push(ans);
}

void RotateY(float theta)
{
  theta = (float)Math.toRadians(theta);
  float[][] m1 = identityMatrix();
  m1[0][0] = cos(theta);
  m1[0][2] = sin(theta);
  m1[2][0] = -sin(theta);
  m1[2][2] = cos(theta);
  float[][] ans = multiply(update.peek(), m1);
  update.push(ans);
}

void RotateZ(float theta)
{
  theta = (float)Math.toRadians(theta);
  float[][] m1 = identityMatrix();
  m1[0][0] = cos(theta);
  m1[0][1] = -sin(theta);
  m1[1][0] = sin(theta);
  m1[1][1] = cos(theta);
  float[][] ans = multiply(update.peek(), m1);
  update.push(ans);
}

void Print_Matrix()
{
  for (int i = 0; i < 4; ++i) {
    print("[ ");
    for (int j = 0; j < 4; ++j) {
      print(update.peek()[i][j]);
      if (j < 3)
        print(", ");
    }
    print(" ]");
    println();
  }
  println();
}

void Perspective(float fov, float near, float far)
{
  fov0 = fov;
  //fovList.append(fov);
  near0 = near;
  far0 = far;
  ortho = false;
}

void Ortho(float l, float r, float b, float t, float n, float f)
{
  left = l;
  right = r;
  top = t;
  bottom = b;
  near0 = n;
  far0 = f;
  ortho = true;
  
  
}

void BeginShape() // set up array so vertex can be called
{
  vList.clear();
}

float[] multiply4x1(float[][] m1, float[]m2) {
  float x = m2[0];
  float y = m2[1];
  float z = m2[2];
  
  float row1 = m1[0][0]*x + m1[0][1]*y + m1[0][2]*z +m1[0][3];
  float row2 = m1[1][0]*x + m1[1][1]*y + m1[1][2]*z +m1[1][3];
  float row3 = m1[2][0]*x + m1[2][1]*y + m1[2][2]*z +m1[2][3];
  float row4 = m1[3][0]*x + m1[3][1]*y + m1[3][2]*z +m1[3][3];
  
  float[] dotProd = {row1, row2, row3, row4};
  return dotProd;
}

void Vertex(float x, float y, float z) // every single vertex in shape
{//if isortho = use orth to project points
//if false = perspective 
  float[] x1 = new float[]{x, y, z, 1};
  float[] pP = multiply4x1(update.peek(), x1); // CTM*{x, y, z, 1}
  
  //pPP = proj(pP)
  //vList.add(pP);

  if (ortho == true){
    //use orth equation
    float xP = ((pP[0]-left)*windowWidth)/(right-left); 
    float yP = ((pP[1]-top)*windowHeight)/(bottom-top);
    float[] points = {xP, yP};
    vList.add(points);
    
    
    
  } else if (ortho == false) {
    //use transformation equation
    k = tan(radians(fov0)/2);
    float xP = ((pP[0]/abs(pP[2]))+ k) *windowWidth;
    xP = xP/(2*k);
    float yP = ((pP[1]/abs(pP[2]))+ k) *windowHeight;
    yP = yP/(2*k);
    yP = windowHeight - yP;
    float[] points = {xP, yP};
    vList.add(points);
  }

//transform vertices in begining of vertix but before ertex

//1 transform vetices based on trans matrix
//2 project tranformed vertices
// 3. draw the projected vertices. 
// create an arraylist 
  
}

void EndShape()// do drawing, set vLIst to null 
{
  //[ [1,2], [3,4], [5,6], [7,8] ]
  
  int lineNums = vList.size()/2;
  for (int i = 0; i < vList.size(); i+=2){
    float[] v1 = vList.get(i);
    float[] v2 = vList.get(i+1);
    line(v1[0], v1[1], v2[0], v2[1]); 
  }
  
  
  
}
