// CONWAY'S GAME OF LIFE
// http://en.wikipedia.org/wiki/Conway's_Game_of_Life
//
// this processing sketch implements John Conway's Game of Life simulation
// as an image-processing system... it looks at pixels in a processing PImage
// and treats them as cells in a version of Conway's simulation.
//
// your tasks:
// (1) make this thing look more interesting... 
// hint: you don't have to display the image directly to the screen.
// another hint: the double for() loop can be used to draw other things (shapes, text, etc.)
// as a proxy for the pixels in the simulation.
// (2) the RULES in the draw() loop determine how the simulation decides to keep a pixel
// alive or generate a new one from a dead pixel.  this rule set is sometimes referred to as
// B3/S23 (a pixel is "Born" with 3 neighbors and "Stays Alive" with 2 or 3 neighbors.
// tweak these rules and see if you can find other interesting (or self-sustaining) systems.
//

//Spencer
//Add colors somehow

PImage c[] = new PImage[2]; // input image
PImage c2[] = new PImage[2]; // input image

int w, h; // width and height
int w2, h2; // width and height

int i, j; // counter variables
int i2, j2; // counter variables

int center; // is the pixel alive or dead?
int sum; // how many neighbors are alive?
int center2; // is the pixel alive or dead?
int sum2; // how many neighbors are alive?

float myColor = 1; //new var
float myColor2 = 30; //new var

int which = 0; // which image are we working on
int which2 = 0; // which image are we working on

// 9 pixels for the neighborhood (p4 is center):
//  p0  p1  p2
//  p3 *p4* p5
//  p6  p7  p8
color p0, p1, p2, p3, p4, p5, p6, p7, p8; 
color pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7, pp8; 

void setup()
{
  size(1000, 800); // make the screen square
  background(0);
  
  //right
  // create two blank images to work with for the game
  c[0] = createImage(50, 50, RGB);
  c[1] = createImage(50, 50, RGB);
  w = c[0].width; // width
  h = c[0].height; // height

  //left
  // create two blank images to work with for the game
  c2[0] = createImage(50, 50, RGB);
  c2[1] = createImage(50, 50, RGB);
  w2 = c2[0].width; // width
  h2 = c2[0].height; // height
  
  fillRandom(); //fill screen
}

void draw()
{
  
  noStroke();
  fill(200, 10, 10);
  rect(485, 0, 30, 800);
  
  //************************************************************************************
  //******************************* Screen Left (2) ************************************
  //************************************************************************************
  c2[which2].loadPixels(); // load up the pixels array for input
  // step 2 - get the values for the "neighborhood" around each pixel
  for (i2=0; i2<h2; i2++) // these pixels are the rows
  {
    for (j2=0; j2<w2; j2++) // thise pixels are the columns
    {
      
      // top row
      pp0 = c2[which2].pixels[((i2-1+h2)%h2)*w2 + (j2-1+w2)%w2]; // left pixel
      pp1 = c2[which2].pixels[((i2-1+h2)%h2)*w2 + j2]; // center2 pixel
      pp2 = c2[which2].pixels[((i2-1+h2)%h2)*w2 + (j2+1+w2)%w2]; // left pixel
      // center2 row
      pp3 = c2[which2].pixels[i2*w2 + (j2-1+w2)%w2]; // left pixel
      pp4 = c2[which2].pixels[i2*w2 + j2]; // center2 pixel
      pp5 = c2[which2].pixels[i2*w2 + (j2+1+w2)%w2]; // left pixel
      // bottom row
      pp6 = c2[which2].pixels[((i2+1+h2)%h2)*w2 + (j2-1+w2)%w2]; // left pixel
      pp7 = c2[which2].pixels[((i2+1+h2)%h2)*w2 + j2]; // center2 pixel
      pp8 = c2[which2].pixels[((i2+1+h2)%h2)*w2 + (j2+1+w2)%w2]; // right pixel

      sum2 = 0; // start blank
      sum2+= int(green(pp0)>myColor2) + int(green(pp1)>myColor2) + int(green(pp2)>myColor2); // top neighbors
      sum2+= int(green(pp3)>myColor2) + int(green(pp5)>myColor2); // left and right neighbors
      sum2+= int(green(pp6)>myColor2) + int(green(pp7)>myColor2) + int(green(pp8)>myColor2); // bottom neighbors
      center2 = int(green(pp4)>myColor2); // is the center2 pixel alive?

      //
      // RULES: PLAY WITH THESE
      //
      if (center2==1 && (sum2==2 || sum2==3)) // alive... stay alive
      {
        c2[1-which2].pixels[i2*w2 + j2] = color(random(0, 255), 30, random(50, 100));
      } else if (center2==0 && sum2==3) // dead... become alive
      {
        c2[1-which2].pixels[i2*w2 + j2] = color(150, random(200, 255), random(10, 50));
      } else // die (or stay dead)
      {   
        c2[1-which2].pixels[i2*w2 + j2] = color(0, 0, 50);
      }
    }
  }

  c2[1-which2].updatePixels(); // restore the pixels array
  image(c[1-which2], 0, 0, width/2, height); // draw to screen
  which2 = 1-which2; // swap image buffer
  //end screen left
  
  
  //************************************************************************************
  //******************************* Screen Right ***************************************
  //************************************************************************************
  c[which].loadPixels(); // load up the pixels array for input
  // step 2 - get the values for the "neighborhood" around each pixel
  for (i=0; i<h; i++) // these pixels are the rows
  {
    for (j=0; j<w; j++) // thise pixels are the columns
    {

      // top row
      p0 = c[which].pixels[((i-1+(h+3))%h)*w + (j-1+w)%w]; // left pixel
      p1 = c[which].pixels[((i-1+h)%h)*w + j]; // center pixel
      p2 = c[which].pixels[((i-1+h)%h)*w + (j+1+w)%w]; // left pixel
      // center row
      p3 = c[which].pixels[i*w + (j-1+w)%w]; // left pixel
      p4 = c[which].pixels[i*w + j]; // center pixel
      p5 = c[which].pixels[i*w + (j+1+w)%w]; // left pixel
      // bottom row
      p6 = c[which].pixels[((i+1+h)%h)*w + (j-1+w)%w]; // left pixel
      p7 = c[which].pixels[((i+1+h)%h)*w + j]; // center pixel
      p8 = c[which].pixels[((i+1+h)%h)*w + (j+1+w)%w]; // left pixel
      
      sum = 0; // start blank
      sum+= int(green(p0)>myColor) + int(green(p1)>myColor) + int(green(p2)>myColor); // top neighbors
      sum+= int(green(p3)>myColor) + int(green(p5)>myColor); // left and right neighbors
      sum+= int(green(p6)>myColor) + int(green(p7)>myColor) + int(green(p8)>myColor); // bottom neighbors
      center = int(green(p4)>myColor); // is the center pixel alive?

      //
      // RULES: PLAY WITH THESE
      //
      if (center==1 && (sum==2 || sum==3)) // alive... stay alive
      {
        c[1-which].pixels[i*w + j] = color(255, random(0, 255), random(0, 255));
      } else if (center==0 && sum==3) // dead... become alive
      {
        c[1-which].pixels[i*w + j] = color(255, random(0, 255), 255);
      } else // die (or stay dead)
      {   
        c[1-which].pixels[i*w + j] = color(0, 0, 50);
       }
      }
    }
    c[1-which].updatePixels(); // restore the pixels array
    image(c[1-which], width/2, 0, width, height); // draw to screen
    which = 1-which; // swap image buffer
  
  noStroke();
  fill(10, 200, 10);
  ellipse(500, 100, 40, 40); 
 
  noStroke();
  fill(10, 200, 10);
  ellipse(500, 200, 40, 40); 
  
  noStroke();
  fill(10, 200, 10);
  ellipse(500, 300, 40, 40); 
  
  noStroke();
  fill(10, 200, 10);
  ellipse(500, 400, 40, 40); 
  
  noStroke();
  fill(10, 200, 10);
  ellipse(500, 500, 40, 40); 
  
  noStroke();
  fill(10, 200, 10);
  ellipse(500, 600, 40, 40);
 
 noStroke();
  fill(10, 200, 10);
  ellipse(500, 700, 40, 40);  
    
  fill(200, 10, 10);
  noStroke();
  rect(485, 0, 30, 800); // SPECIAL RED
  
  noStroke();
  fill(10, 200, 10);
  ellipse(500, 50, 40, 40);
  
  noStroke();
  fill(10, 200, 10);
  ellipse(500, 150, 40, 40);
  
  noStroke();
  fill(10, 200, 10);
  ellipse(500, 250, 40, 40);
  
  noStroke();
  fill(10, 200, 10);
  ellipse(500, 350, 40, 40);
  
  noStroke();
  fill(10, 200, 10);
  ellipse(500, 450, 40, 40);
  
  noStroke();
  fill(10, 200, 10);
  ellipse(500, 550, 40, 40);
  
  noStroke();
  fill(10, 200, 10);
  ellipse(500, 650, 40, 40);
  
  noStroke();
  fill(10, 200, 10);
  ellipse(500, 750, 40, 40);
      
  
}

void keyPressed()
{
  fillRandom(); // add random noise to image when you press any key
}

void fillRandom()
{
  // fill our current image with random stuff
  c[which].loadPixels();
  for (i=0; i<c[which].pixels.length; i++)
  {
    float rand = random(1000);
    if (rand>900) // 10% alive
    {
      c[which].pixels[i] = color(255, 255, 255);
    }
  }
  c[which].updatePixels();
}
