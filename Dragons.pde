import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

PFont f;

PImage Horse[] = new PImage[11];
sprite H;
PImage j1[] = new PImage[12];
sprite J1;
PImage j2[] = new PImage[12];
sprite J2;
PImage os1[] = new PImage[12];
sprite Os1;
PImage os2[] = new PImage[12];
sprite Os2;
PImage dragon[] = new PImage[16];
dragon Dragon = new dragon();
PImage fire[] = new PImage[6];
PImage flames[] = new PImage[3];
PImage bg1;
PImage bg2;
PImage bg3;
int speed = 5; //this is the unit of measurement for how fast our dragon 
//goes at any interval of time. It steps the program. 

int timeSpeed = 100; // this is the delay value that I need to synch
// up with the movement speed, or something.
int hiDistance = 200;
int loDistance = -200;
int gs = 0;


/*
 Notes on image sizes
 
 Horse          -  358 x 227 (maybe)
 Jump1          -  140 x 328
 Jump2          -  15 x 31
 Ostrich1       -  38 x 49
 Ostrich2       -  38 x 49
 Dragon         -  24 x 24
 
 */


int HposX = 800;
int HposY = 200;
int J1posX = 400;
int J1posY = 500;
int J2posX = 700;
int J2posY = 500;
int Os1posX = 100;
int Os1posY = 300;
int Os2posX = 900;
int Os2posY = 400;

Minim minim;
AudioInput in;
AudioRecorder recorder;
AudioPlayer BassWalker;

void setup() {

  
  
  //size(1450, 850);
  fullScreen();
  background(222, 184, 135);
  H = new sprite(HposX , HposY);
  J1 = new sprite(J1posX , J1posY);
  J2 = new sprite(J2posX , J2posY);
  Os1 = new sprite(Os1posX , Os1posY);
  Os2 = new sprite(Os2posX , Os2posY);
  bg1 = loadImage("bg1.png");
  bg2 = loadImage("bg2.png");
  images();
  
  
  f = createFont("Arial",16,true); // Arial, 16 point, anti-aliasing on
  
  //"Fast Talkin" Kevin MacLeod (incompetech.com)
//Licensed under Creative Commons: By Attribution 3.0 License
//http://creativecommons.org/licenses/by/3.0/
  // we pass this to Minim so that it can load files from the data directory
  minim = new Minim(this);
  BassWalker = minim.loadFile("BassWalker.mp3", 1024);
  BassWalker.loop();
  //frameRate(20);
}



void draw() {
  go();
  if (gs == 1) {
    image(bg2, 0, 0, width, height);
    animate();


    show();
    keyPressed();
  } else if (gs == 2) {
    image(bg3, 0, 0, width, height);
  } else {
    image(bg1, 0, 0, width, height);
        if ((mouseX>230) && (mouseX<640) && (mouseY>230) && (mouseY<700)){
            textFont(f,16);                  // STEP 3 Specify font to be used
            fill(255);                         // STEP 4 Specify font color 
            text(" 'On The Ground' Kevin MacLeod incompetech.com ",mouseX + 10, mouseY - 20);   // STEP 5 Display Text
            text("  Licensed under Creative Commons: By Attribution 3.0 License creativecommons.org/licenses/by/3.0/ ",mouseX , mouseY);   // STEP 5 Display Text
        }
  }
  
}


/*
Dragon sprite notes:
 
 these are the animations by filename
 dragon1.png - standing 1   ** remember to copy walking 1 to this position
 dragon2.png - standing 2
 dragon3.png - standing 3
 dragon4.png - walking 1
 dragon5.png - walking 2
 dragon6.png - walking 3
 dragon7.png - walking 4
 dragon8.png - walking 5
 dragon9.png - walking 6
 dragon10.png - firebreath ** requires the fire sprite to appear
 dragon11.png - walking reversed 1
 dragon12.png - walking reversed 2
 dragon13.png - walking reversed 3
 dragon14.png - walking reversed 4
 dragon15.png - walking reversed 5
 dragon16.png - walking reversed 6
 rougly 12 pixels to the RIGHT (+ve)
 of the sprite's location. 
 */

void go() {
  if (mousePressed == true && gs == 0) {
    gs = 1;
  } else if (mousePressed == true && gs == 1) {
    gs = 2;
  } else if (mousePressed == true && gs == 2) {
    gs = 0;
  }
}


void keyPressed() {
  if (keyPressed == true) {
    if (key == CODED) {
      if (keyCode == UP) {

        Dragon.y = Dragon.y - speed;

        if (Dragon.s >= 2 && Dragon.s<8) {
          Dragon.s ++;
        } else {
          Dragon.s = 3;
        }
      } else if (keyCode == DOWN) {

        Dragon.y = Dragon.y + speed;

        if (Dragon.s >= 11 && Dragon.s<16) {
          Dragon.s ++;
        } else {
          Dragon.s = 11;
        }
      } else if (keyCode == RIGHT) {

        Dragon.x = Dragon.x + speed;

        if (Dragon.s >= 11 && Dragon.s<16) {
          Dragon.s ++;
        } else {
          Dragon.s = 11;
        }
      } else if (keyCode == LEFT) {

        Dragon.x = Dragon.x - speed;
        if (Dragon.s >= 2 && Dragon.s<8) {
          Dragon.s ++;
        } else {
          Dragon.s = 3;
        }
      }
    } else if (key == ' ') { // this is the fire button
      burn();
      Dragon.s = 10;
      image (fire[Dragon.f + 2], Dragon.x + 125, Dragon.y + 55);
      if (Dragon.f < 2) {
        Dragon.f ++;
      } else {
        Dragon.f = 0;
      }
     
    }
  } else {
    Dragon.x = Dragon.x;
    Dragon.y = Dragon.y;
    if (Dragon.s == 1) {
      //delay(timeSpeed);
      Dragon.s = 2;
    } else if (Dragon.s == 2) {
      //delay(timeSpeed);
      Dragon.s = 1;
    } else {
      Dragon.s = 1;
    }
  }
}


void animate() {

  if (H.f == 1) {
    for (int i = 0; i < 50; i ++) {
      if (H.s < 8) {
        H.s ++;
      } else {
        H.s = 1;
      }
    } 
    if (J1.f == 1) {
      if (J1.s < 10) {
        J1.s ++;
      } else {
        J1.s = 1;
      }
    } 
    if (J2.f == 1) {
      if (J2.s < 10) {
        J2.s ++;
      } else {
        J2.s = 1;
      }
    } 
    if (Os1.f == 1) {
      if (Os1.s < 10) {
        Os1.s ++;
      } else {
        Os1.s = 1;
      }
    } 
    if (Os2.f == 1) {
      if (Os2.s < 10) {
        Os2.s ++;
      } else {
        Os2.s = 1;
      }
    }
 
  }
}



void burn() {
  if (Dragon.s == 10) { // if he is breathing fire
    if (hiDistance > dist(Dragon.x, Dragon.y, H.x, H.y) && loDistance < dist(Dragon.x, Dragon.y, H.x, H.y)) {
      H.f = 1;
    } 
    if (hiDistance > dist(Dragon.x, Dragon.y, J1.x, J1.y) && loDistance < dist(Dragon.x, Dragon.y, J1.x, J1.y)) {
      J1.f = 1;
    } 
    if (hiDistance > dist(Dragon.x, Dragon.y, J2.x, J2.y) && loDistance < dist(Dragon.x, Dragon.y, J2.x, J2.y)) {
      J2.f = 1;
    } 
    if (hiDistance > dist(Dragon.x, Dragon.y, Os1.x, Os1.y) && loDistance < dist(Dragon.x, Dragon.y, Os1.x, Os1.y)) {
      Os1.f = 1;
    } 
    if (hiDistance > dist(Dragon.x, Dragon.y, Os2.x, Os2.y) && loDistance < dist(Dragon.x, Dragon.y, Os2.x, Os2.y)) {
      Os2.f = 1;
    }
  }
}


/*
 Notes on image sizes
 
 Horse          -  35 x 22 (maybe)
 Jump1          -  14 x 32
 Jump2          -  15 x 31
 Ostrich1       -  38 x 49
 Ostrich2       -  38 x 49
 Dragon         -  24 x 24
 
 */
int hHeight = 150;
int hWidth = 100;
int j1Height = 100;
int j1Width = 200;
int j2Height = 100;
int j2Width = 200;
int os1Height = 200;
int os1Width = 200;
int os2Height = 200;
int os2Width = 200;




  void show() {
    image(Horse[H.s], H.x, H.y, hHeight, hWidth);
    image(j1[J1.s - 1], J1.x, J1.y, j1Height, j1Width );
    image(j2[J2.s], J2.x, J2.y, j2Height, j2Width );
    image(os1[Os1.s - 1], Os1.x, Os1.y, os1Height, os1Width );
    image(os2[Os2.s - 1], Os2.x, Os2.y, os2Height, os2Width);
    image(dragon[Dragon.s - 1], Dragon.x, Dragon.y);
  }


void images() {
  for (int i = 0; i < 11; i++) {
    j1[i] = loadImage("jumping1"+ (1+i) +".png");
    j2[i] = loadImage("jumping2"+ (1+i) +".png");
    os1[i] = loadImage("os1" + (1+i) + ".png");
    os2[i] = loadImage("os2" + (1+i) + ".png");
  }
  for (int i = 0; i<10; i++) {
    Horse[i] = loadImage("Horse" + (i+1) + ".png");
  }
  for (int i = 0; i<16; i++) {
    dragon[i] = loadImage("dragon" + (i+1) + ".png");
  }
  for (int i = 0; i<2; i++) {
    flames[i] = loadImage("Flames" + (i + 1) + ".png");
  }
  for (int i = 0; i<5; i++) {
    fire[i] = loadImage("Fire" + (i + 1) + ".png");
  }
  bg1 = loadImage("bg1.jpg");
  bg2 = loadImage("bg2.png");
  bg3 = loadImage("bg3.jpg");
}


class dragon {
  float x, y;
  int s, f;
  dragon() {
    x = 1000;
    y = height;
    s = 1;
    f = 0;
  }
}

class sprite {
  float x, y;
  int s, f;
  sprite(float x_, float y_) {
    x = x_;
    y = y_;
    s = 1;
    f = 0;
  }
}