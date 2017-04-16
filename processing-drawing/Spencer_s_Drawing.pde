/*
Spencer Cappiello
Drawing Circle around the time of Easter Sketch

**Click Mouse**
**Press Spacebar**
**Move mouse**

this sketch draws small circles that drunkenly follow your mouse. the color of the 
circles changes according to which horizontal half of the screen the cursor is on.

clicking the mouse changes the two colors of the circles from blue/purple combo to
red/orange combo. 

pressing the spacebar draws a new background in a new and random color

additionally, the circles will not draw outside of the diamond shaped border.

this sketch is very colorful
*/

float x1, y1; // GLOBAL variables for drunkeness
int mouseValue = 0; //mouse clicked variable
float i = 194; //random number for red channel background
float o = 250; //random number for green channel background
float p = 192; //random number for blue channel background

void setup() // this runs when i hit play
{
  frameRate(20); // sets framerate/number of dots drawn per second
  size(800, 600); // sets up the size of the canvas
  background(i, o, p); //starts with green background
}

void draw() // this runs every frame
{ 
  x1 = mouseX+random(-10, 10); // drunkness factor of following mouseX
  y1 = mouseY+random(-10, 10); // drunkness factor of following mouseY
  
  stroke(0, 20); //light black stroke of ellipse
  
  if (mouseValue == 0){ // uses mouseValue to determine color
    if (mouseX > width/2) {
      fill(#E538E5, 100); // fill of ellipse mouseValue 0 RIGHT
    } else {
      fill(#36C8FF, 100); // fill of ellipse mouseValue 0 LEFT
    }
  }
  if (mouseValue == 255){ // uses mouseValue to determine color
    if (mouseX > width/2) {
      fill(#FF9B36, 100); // fill of ellipse mouseValue 1 RIGHT
    } else {
      fill(#FF4F2C, 100); // fill of ellipse mouseValue 1 LEFT
    }
  }
    
  ellipse(x1, y1, 20, 20); // draw the circle!

  stroke(0, 50); //faded black outline for the diamond
  fill( i, o, p); //color of diamond generates the same color as background
  beginShape();
  vertex(0,0);
  vertex(800,0);
  vertex(800,300);
  vertex(700,300);
  vertex(400,50); // ^v draw the diamond shape ^v
  vertex(100,300);
  vertex(400,550);
  vertex(700,300);
  vertex(800,300);
  vertex(800,600);
  vertex(0,600);
  vertex(0,0);
  endShape();
  
  noStroke();
  fill(i, o, p); //hide black line
  rect(700, 200, 800, 400); //this rectangle makes the black stroke from the diamond on the middle-right disappear. 
}

void keyReleased()
{  
  i = random(0, 255); //make random number between 0-255 for red channel use
  o = random(0, 255); //make random number between 0-255 for green channel use
  p = random(0, 255); //make random number between 0-255 for blue channel use
  
  if(key==' ') background( i, o, p, 100); //draw new background color when spacebar released
}

void mouseClicked() {
  if (mouseValue == 0) { //toggle mouseclicked values from 255 to 0 and back/forth
    mouseValue = 255;
  } else {
    mouseValue = 0;
  }
  println(mouseValue); //print mouseValue in consol
}
