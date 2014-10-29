// SPIROGRAPH
//Spencer Cappiello's
//modified sketch to show this with time as a clock
//*decreased number of circles*
  //circle0 = hours
  //circle1 = minutes
  //circl2 = seconds
  //circle3 = 1/60 of a second
  
// try messing with your computer's clock and see the magic of this sketch.
// !!!BEWARE!!
// [changing by more than 2 hours causes the sketch to crash.]

import ddf.minim.*;
import ddf.minim.effects.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;

//Given variables:
int NUMCircles = 5; // how many of these things can we do at once?
float[] circle = new float[NUMCircles]; // an array to hold all the current angles
float rad; // an initial radius value for the central sine
int i; // a counter variable
boolean trace = false; // are we tracing?
// play with these to get a sense of what's going on:
float fund = 0.01; // the speed of the central sine
float ratio = 1.; // what multiplier for speed is each additional sine?
int alpha = 50; // how opaque is the tracing system

//My variables:
float circum = 2*PI*rad; // circum
int timeWarp = 3; //speed up the clock
int j = 0;
int[] countcount = new int[60];
PFont numberFont;
int oldMillis1 = 0; //smart time stuff
int newMillis1 = 1000; //smart time stuff
int oldMillis2 = 0; //smart time stuff
int newMillis2 = 1000; //smart time stuff

void setup()
{
  frameRate(73); // in theory, this should be 60 frames/second, but this makes audio match with moving seconds better 
  size(800, 600, P3D); // OpenGL mode
  rad = height/4.; // compute radius for central circle once, only in setup.
  background(255); // draw the screen
  
  minim = new Minim(this); //sound
  player = minim.loadFile("tick.mp3", 2048);
  
  numberFont = loadFont("ColonnaMT-60.vlw"); //fonts
  textFont(numberFont); 
  textSize(50);
  textAlign(CENTER, BOTTOM);
  
}

void draw()
{  
  // TIME initialized 
  int s = second(); 
  int m = minute(); 
  int hh = hour(); 
  int h = hh;
  if (h >= 12) {
        h = hh-12; }
  if (h == 0) {
        h = 12; }
  // counter [0-99] for 1/100 seconds
  j = (j + 1);
  if (j == 60) {
    j = 0; }
  //println(j); //test
  
  circle[0] = map(h, 0, 12, 0, (PI*2)); //circle0 = hours (24)
  circle[1] = map(m, 0, 59, 0, (PI*2)); //circle1 = minutes (60)
  circle[2] = map(s, 0, 59, 0, (PI*2)); //circle2 = seconds (60)
  circle[3] = map(j, 0, 59, 0, (PI*2)); //circle3 = milliseconds (100)
  //circle[4] = map(j, 0, 99, 0, (PI*2)); //circle3 = milliseconds (100)

  println(j, s, m, h);
  println(circle[0], circle[1], circle[2], circle[3]);

  //Clever sound stuff! -- tick tock clock  
  if(s%2 == 0) {
    oldMillis1 = millis();
  }
  if((oldMillis1-newMillis1) >= 999) {
    player.play();
    player.rewind();
  }
  newMillis1 = oldMillis1;

  if(s%2 == 1) {
    oldMillis2 = millis();
  }
  if((oldMillis2-newMillis2) >= 999) {
    player.play();
    player.rewind();
  }
  newMillis2 = oldMillis2;
  //println(oldMillis, newMillis, (oldMillis-newMillis)); //test

  if (!trace) background(255); // clear screen if showing geometry
  if (!trace) {
    fill(0, 0, 255);
    text("12", width/2, (height/2)-106);
    text("1", ((width/2)+60), (height/2)-86);
    text("2", ((width/2)+108), (height/2)-40);
    text("3", ((width/2)+135), (height/2)+22);
    text("4", ((width/2)+108), (height/2)+89);
    text("5", ((width/2)+60), (height/2)+135);
    text("6", width/2, (height/2)+156);
    text("7", ((width/2)-60), (height/2)+135);
    text("8", ((width/2)-108), (height/2)+89);
    text("9", ((width/2)-135), (height/2)+22);
    text("10", ((width/2)-108), (height/2)-40);
    text("11", ((width/2)-60), (height/2)-86);

    strokeWeight(1.5);
    smooth();
    stroke(0, 150); //  
    noFill(); // don't fill
  }  
  
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
      noFill();
      erad = 5.0*(1.0-float(i)/circle.length); // pen width will be related to which sine
    }
    float radius = rad/(i+1); // radius for circle itself
    rotateZ(circle[i]+PI); // rotate circle
    if (!trace) ellipse(0, 0, radius*2, radius*2); // if we're simulating, draw the sine [big circles]
    pushMatrix(); // go up one level
    translate(0, radius); // move to sine edge
    //if (!trace) ellipse(0, 0, 5, 5); // draw a little circle [points on circles]
    if (trace) ellipse(0, 0, erad, erad); // draw with erad if tracing [trail draw]
    popMatrix(); // go down one level
    translate(0, radius); // move into position for next sine
  }
  popMatrix(); // pop down final transformation
}

void keyReleased()
{
  if (key==' ') {
    trace = !trace; //draw/trace mode
    background(255);
  }
}
