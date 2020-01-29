/******************************************************************************
Draw your initials here in perspective.
******************************************************************************/

void persp_initials()
{
  // you should write this routine!
  BeginShape();
  
  persp_multi_cube1();
  
  EndShape();
}

void initialSet()
{
  BeginShape();

  /* top square */

  Vertex (-1.0, -1.0,  1.0);
  Vertex (-1.0,  1.0,  1.0);

  Vertex (-1.0,  1.0,  1.0);
  Vertex ( 1.0,  1.0,  1.0);

  Vertex ( 1.0,  1.0,  1.0);
  Vertex ( 1.0, -1.0,  1.0);

  Vertex ( 1.0, -1.0,  1.0);
  Vertex (-1.0, -1.0,  1.0);

  /* bottom square */

  Vertex (-1.0, -1.0, -1.0);
  Vertex (-1.0,  1.0, -1.0);

  Vertex (-1.0,  1.0, -1.0);
  Vertex ( 1.0,  1.0, -1.0);

  Vertex ( 1.0,  1.0, -1.0);
  Vertex ( 1.0, -1.0, -1.0);

  Vertex ( 1.0, -1.0, -1.0);
  Vertex (-1.0, -1.0, -1.0);

  /* connect top to bottom */

  Vertex (-1.0, -1.0, -1.0);
  Vertex (-1.0, -1.0,  1.0);

  Vertex (-1.0,  1.0, -1.0);
  Vertex (-1.0,  1.0,  1.0);

  Vertex ( 1.0,  1.0, -1.0);
  Vertex ( 1.0,  1.0,  1.0);

  Vertex ( 1.0, -1.0, -1.0);
  Vertex ( 1.0, -1.0,  1.0);

  EndShape();
}

void persp_multi_cube1()
{
  Init_Matrix();
  
  
  
  Perspective (60.0, 1.0, 100.0);

  // draw several cubes in three lines along the axes
  for (float delta = -10; delta <= 10; delta += 1) {
    

    
    //V - left
    Init_Matrix();
    Translate (0.0, 0.0, -40.0);
    RotateZ(5);
    RotateX(25);
    RotateY(20);
    Translate(0, delta, 0);
    cube();
    
    //V - right
    Init_Matrix();
    Translate (3.0, 0.0, -40.0);
    RotateZ(-10);
    RotateX(25);
    RotateY(20);
    Translate(0, delta, 0);
    cube();
    
    //G - stem
    Init_Matrix();
    Translate (-19.0, 1, -42.0);
    RotateZ(0);
    RotateX(0);
    RotateY(0);
    Translate(0, delta-2, 0);
    cube();
    
    //G - top
    Init_Matrix();
    Translate (-15.0, 10, -40.0);
    RotateZ(90);
    RotateX(75);
    RotateY(0);
    Translate(0, delta-6, 0);
    cube();
    
    //G - bottom
    Init_Matrix();
    Translate (-15.0, -10, -40.0);
    RotateZ(90);
    RotateX(75);
    RotateY(0);
    Translate(0, delta-6, 0);
    cube();
    

  }
  
  for (float delta = -5; delta <= 5; delta += 1) {
    Init_Matrix();
    Translate (-15.0, 0, -40.0);
    RotateZ(90);
    RotateX(75);
    RotateY(0);
    Translate(0, delta-6, 0);
    cube();
    
    //G - bottom stem
    Init_Matrix();
    Translate (-10.0, 1, -42.0);
    RotateZ(10);
    RotateX(0);
    RotateY(10);
    Translate(0, delta-6, 0);
    cube();
  }

}
