// Fragment shader
//greg varghese

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_LIGHT_SHADER

// These values come from the vertex shader
varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
varying vec4 vertTexCoord;

void main() {
    //gl_FragColor = vec4(0.2, 0.4, 1.0, vertTexCoord.s);
    float radius = 0.12;
    vec4 centerPointTop = vec4(0.5, 0.85, 0.0, 0.0);
    vec4 centerPointLeft = vec4(0.15, 0.5, 0.0, 0.0);
    vec4 centerPointRight = vec4(0.85, 0.5, 0.0, 0.0);
    vec4 centerPointBottom = vec4(0.5, 0.15, 0.0, 0.0);

    vec4 centerPointLeftTop = vec4(0.253, 0.747, 0.0, 0.0);
    vec4 centerPointLeftBottom = vec4(0.253, 0.253, 0.0, 0.0);
    vec4 centerPointRightTop = vec4(0.747, 0.747, 0.0, 0.0);
    vec4 centerPointRightBottom = vec4(0.747, 0.253, 0.0, 0.0);

    // finding distance between radius and X,Y coordinates
    float distTop = distance(vertTexCoord.xy, centerPointTop.xy);
    float distBottom = distance(vertTexCoord.xy, centerPointBottom.xy);
    float distRight = distance(vertTexCoord.xy, centerPointRight.xy);
    float distLeft = distance(vertTexCoord.xy, centerPointLeft.xy);
    float distRightTop = distance(vertTexCoord.xy, centerPointRightTop.xy);
    float distRightBottom = distance(vertTexCoord.xy, centerPointRightBottom.xy);
    float distLeftTop = distance(vertTexCoord.xy, centerPointLeftTop.xy);
    float distLeftBottom = distance(vertTexCoord.xy, centerPointLeftBottom.xy);
    if (distTop < radius) { //bottom
        gl_FragColor = vec4(0.0, 1.0, 1.0, 0.4);
    } else if (distBottom < radius) { //top
        gl_FragColor = vec4(0.0, 1.0, 1.0, 0.8);
    } else if (distRight < radius) { //left
        gl_FragColor = vec4(0.0, 1.0, 1.0, 0.2);
    } else if (distLeft < radius) { //right
        gl_FragColor = vec4(0.0, 1.0, 1.0, 0.6);
    } else if (distRightTop < radius) {
        gl_FragColor = vec4(0.0, 1.0, 1.0, 0.3);
    } else if (distRightBottom < radius) {
        gl_FragColor = vec4(0.0, 1.0, 1.0, 0.9);
    } else if (distLeftTop < radius) { //left bottom
        gl_FragColor = vec4(0.0, 1.0, 1.0, 0.5);
    } else if (distLeftBottom < radius) { //left top
        gl_FragColor = vec4(0.0, 1.0, 1.0, 0.7);
    }else {
        gl_FragColor = vec4(0,0,0,0);
    }


}

