// SPIROGRAPH
// http://en.wikipedia.org/wiki/Spirograph
// also (for inspiration):
// http://ensign.editme.com/t43dances
//
// this processing sketch uses simple OpenGL transformations to create a
// Spirograph-like effect with interlocking circles (called circle).  
// press the spacebar to switch between tracing and
// showing the underlying geometry.
//
// your tasks:
// (1) tweak the code to change the simulation so that it draws something you like.
// hint: you can change the underlying system, the way it gets traced when you hit the space bar,
// or both.  try to change *both*.  :)
// (2) use minim to make the simulation MAKE SOUND.  the full minim docs are here:
// http://code.compartmental.net/minim/
// hint: the website for the docs has three sections (core, ugens, analysis)... look at all three
// another hint: minim isn't super efficient with a large number of things playing at once.
// see if there's a simple way to get an effective sound, or limit the number of shapes
// you're working with.

//Spencer's
//modify sketch to show this with time as a clock
//decrease number of circles
//largest = hours
//minutes
//seconds
//millisecond 
//etc
//
//how to access computers clock

int NUMCircles = 5; // how many of these things can we do at once?
float[] circle = new float[NUMCircles]; // an array to hold all the current angles
float rad; // an initial radius value for the central sine
int i; // a counter variable
boolean trace = false; // are we tracing?
// play with these to get a sense of what's going on:
float fund = 0.01; // the speed of the central sine
float ratio = 1.; // what multiplier for speed is each additional sine?
int alpha = 50; // how opaque is the tracing system

//TIME to position inits
float circum = 2*PI*rad; // circum
float percent1;
int timeWarp = 3; //speed up the clock

void setup()
{
  size(800, 600, P3D); // OpenGL mode

  rad = height/4.; // compute radius for central circle
  background(255); // clear the screen
  
  /*
  for (int i = 0; i<circle.length; i++)
  {
    circle[i] = PI; // start EVERYBODY facing NORTH
  }
  */
}

void draw()
{
  // TIME initialized 
  int ms = millis(); // 5 places of digits
  int s = second();
  int m = minute();
  int h = hour(); 
  int d = day();    // Values from 1 - 31

  circle[0] = map(d, 0, 60, 0, (PI*2)); //circle0 = days
  circle[1] = map(h, 0, 60, 0, (PI*2));
  circle[2] = map(m, 0, 24, 0, (PI*2));
  circle[3] = map(s, 0, 24, 0, (PI*2));
  circle[4] = map(s, 0, 24, 0, (PI*2));
  
  println(mils, s, m, h, d, mth, y);
  
 
  if (!trace) background(255); // clear screen if showing geometry
  if (!trace) {
    strokeWeight(2);
    smooth();
    stroke(0, 150); // black pen
    noFill(); // don't fill
  }  

/*
  // MAIN ACTION - original
  pushMatrix(); // start a transformation matrix
  translate(width/2, height/2); // move to middle of screen

  for (i = 0; i<circle.length; i++) // go through all the circle
  {
    float erad = 0; // radius for small "point" within circle... this is the 'pen' when tracing
    // setup tracing
    if (trace) {
      smooth();
      stroke(0, 0, 255*(float(i)/circle.length), 200); // blue
      fill(0, 0, 255, 200/2); // also, um, blue
      erad = 5.0*(1.0-float(i)/circle.length); // pen width will be related to which sine
    }
    float radius = rad/(i+1); // radius for circle itself
    rotateZ(circle[i]); // rotate circle
    if (!trace) ellipse(0, 0, radius*2, radius*2); // if we're simulating, draw the sine
    pushMatrix(); // go up one level
    translate(0, radius); // move to sine edge
    if (!trace) ellipse(0, 0, 5, 5); // draw a little circle
    if (trace) ellipse(0, 0, erad, erad); // draw with erad if tracing
    popMatrix(); // go down one level
    translate(0, radius); // move into position for next sine
    circle[i] = (circle[i]+(0.01+(0.01*i)))%TWO_PI; // update angle based on fundamental
  }
  popMatrix(); // pop down final transformation
  */
  
  // MAIN ACTION - modified
  pushMatrix(); // start a transformation matrix
  translate(width/2, height/2); // move to middle of screen
  for (i = 0; i<circle.length; i++) // go through all the circles
  {
    float erad = 0; // radius for small "point" within circle... this is the 'pen' when tracing
    // setup tracing
    if (trace) {
      smooth();
      stroke(150, 0, 0, alpha); // blue
      fill(0, 180, 0, alpha/2); // also, um, blue
      erad = 5.0*(1.0-float(i)/circle.length); // pen width will be related to which sine
    }
    float radius0 = rad/(i+1); // radius for circle itself
    rotateZ(circle[i]+PI); // rotate circle
    if (!trace) ellipse(0, 0, radius0*2, radius0*2); // if we're simulating, draw the sine
    pushMatrix(); // go up one level
    translate(0, radius0); // move to sine edge
    if (!trace) ellipse(0, 0, 5, 5); // draw a little circle
    if (trace) ellipse(0, 0, erad, erad); // draw with erad if tracing
    popMatrix(); // go down one level
    translate(0, radius0); // move into position for next sine
    //circle[i] = (circle[i]+(fund+(fund*i)))%TWO_PI; // update angle based on fundamental
  }
  popMatrix(); // pop down final transformation
  
  /*
  // Circle 0
  pushMatrix(); // start a transformation matrix
  translate(width/2, height/2); // move to middle of screen
  //float erad = 0; // radius for small "point" within circle... this is the 'pen' when tracing
  float radius0 = rad/(i+1); // radius for circle itself
  //rotateZ(circle[i]); // rotate circle
  rotateZ(position1+PI); // rotate circle
  if (!trace) ellipse(0, 0, radius0*2, radius0*2); // if we're simulating, draw the sine
  pushMatrix(); // go up one level
  translate(0, radius0); // move to sine edge
  if (!trace) ellipse(0, 0, 5, 5); // draw a little circle
  popMatrix(); // go down one level
  translate(0, radius0); // move into position for next sine[1]
  popMatrix(); // pop down final transformation
  //circle = (circle + 1);
  */
  
  /*
  // Circle 2
  pushMatrix(); // start a transformation matrix
  translate(width/2, height/2); // move to middle of screen
  //float erad = 0; // radius for small "point" within circle... this is the 'pen' when tracing
  float radius2 = rad/(i+1); // radius for circle itself
  //rotateZ(circle[i]); // rotate circle
  rotateZ(position1); // rotate circle
  if (!trace) ellipse(0, 0, radius2*2, radius2*2); // if we're simulating, draw the sine
  pushMatrix(); // go up one level
  translate(0, radius2); // move to sine edge
  if (!trace) ellipse(0, 0, 5, 5); // draw a little circle
  popMatrix(); // go down one level
  translate(0, radius2); // move into position for next sine[1]
  popMatrix(); // pop down final transformation

*/


}

void keyReleased()
{
  if (key==' ') {
    trace = !trace; 
    background(255);
  }
}
