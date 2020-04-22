// Fragment shader
// greg varghese

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXLIGHT_SHADER

// set by host code
uniform float time;

// Set in Processing
uniform sampler2D texture;

// These values come from the vertex shader
varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
varying vec4 vertTexCoord;


void main() {
  float xStep = 1.0/textureSize(texture,0).x;
  float yStep = 1.0/textureSize(texture,0).y;

  vec4 pixelTop = vec4(vertTexCoord.x, vertTexCoord.y + yStep, vertTexCoord.s, vertTexCoord.t);
  vec4 pixelBottom = vec4(vertTexCoord.x, vertTexCoord.y - yStep, vertTexCoord.s, vertTexCoord.t);
  vec4 pixelRight= vec4(vertTexCoord.x +xStep, vertTexCoord.y , vertTexCoord.s, vertTexCoord.t);
  vec4 pixelLeft= vec4(vertTexCoord.x -xStep, vertTexCoord.y , vertTexCoord.s, vertTexCoord.t);
  vec4 currentPixel = vec4(vertTexCoord.x, vertTexCoord.y , vertTexCoord.s, vertTexCoord.t);

  // Finding the current pixel colors -- then multiplying by 4 for Laplacian later
  vec4 currentPixelColor = texture2D(texture, currentPixel.xy);
  float currR = currentPixelColor.r * (-4);
  float currG = currentPixelColor.g * (-4);
  float currB = currentPixelColor.b * (-4);

  vec4 colorTop = texture2D(texture, pixelTop.xy);
  vec4 colorBottom = texture2D(texture, pixelBottom.xy);
  vec4 colorRight = texture2D(texture, pixelRight.xy);
  vec4 colorLeft = texture2D(texture, pixelLeft.xy);

  // adding all the RGB values of surrounding pixels
  float red = colorTop.r + colorBottom.r + colorRight.r + colorLeft.r;
  float green = colorTop.g + colorBottom.g + colorRight.g + colorLeft.g;
  float blue = colorTop.b + colorBottom.b + colorRight.b + colorLeft.b;

  // RBG - CurrRGB
  float redFinal = red + currR;
  float greenFinal = green + currG;
  float blueFinal = blue + currB;

  vec4 color = texture2D(texture, vertTexCoord.xy);

  float n = (redFinal + greenFinal + blueFinal) + 0.5;
  float diffuse = clamp(dot (vertNormal, vertLightDir),0.0,1.0);

  if (currentPixel.x <= time) {
    gl_FragColor = vec4(n*diffuse, n*diffuse, n*diffuse, 1.0);
  } else {
    float diffuse = clamp(dot (vertNormal, vertLightDir),0.0,1.0);
    gl_FragColor = vec4(diffuse * color.rgb, 1.0);
    //int shade = textureSize(diffuse_color, 0);
  }

}

