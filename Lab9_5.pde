import processing.serial.*;

int numFrames = 3;
int frame = 0;
PImage[] frames = new PImage[numFrames];
PImage image;
int button_x = 64;
int button_y = 64;

Serial sensor;
int buttonValue = 85;
int led1Fill = 128;
int led2Fill = 128;
int led1 = 0;
int led2 = 0;

int w = 64;
int h = 64;
int x1 = 324;
int x2 = x1 + w + w / 2;
int y = 200;

void setup() {
  size(640, 480);
   //printArray(Serial.list());
   //printArray(PFont.list());
   sensor= new Serial(this, Serial.list()[0], 9600);
   
  image = loadImage("newButton.png");
  image.loadPixels();
  for (int i = 0; i < numFrames; i++) {
      frames[i] = createImage(
        image.width / 3,
        image.height,
        ARGB
      );
     frames[i] = image.get(
        i * image.width / 3,
        0,
        image.width / 3,
        image.height
      );
  }
   
}

void draw() {
  background(255);
  image(frames[frame], button_x, button_y, frames[0].width, frames[0].height);
  fill(0);
  switch(buttonValue){
    case 85:
      fill(0);
;
      break;
    case 68:
      fill(0,255,0);
;
      break;
    default:
      break;
  }
  stroke(0);
  fill(led1Fill,0,0);
  ellipse(x1,y,w,h);
  fill(led2Fill,0,0);
  ellipse(x2,y,w,h);
}

void serialEvent(Serial s) {
 
}



void mousePressed(){
  if (mouseInRect() && frame==0){
    frame=1;
   } else if (mouseInRect() && frame==1){
     frame=2;
   } else if (mouseInRect() && frame==2){
      frame=0; 
   }  
}

boolean mouseInRect() {
  return (
    (mouseX >= button_x) &&
    (mouseX <= button_x + image.width / 3) &&
    (mouseY >= button_y) &&
    (mouseY <= button_y + image.height)
  );
}
