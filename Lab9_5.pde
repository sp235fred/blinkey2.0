import processing.serial.*;

int numFrames = 3;
int frame = 0;
PImage[] frames = new PImage[numFrames];
PImage image;
PImage[] frames2 = new PImage[numFrames];
int button_x = 64;
int button_y = 64;

Serial sensor;
char buttonValue = 'A';
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
   
  image = loadImage("Switch.png");
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
    image = loadImage("led.png");
  image.loadPixels();
  for (int i = 0; i < numFrames; i++) {
      frames2[i] = createImage(
        image.width / 2,
        image.height,
        ARGB
      );
     frames2[i] = image.get(
        i * image.width / 2,
        0,
        image.width / 2,
        image.height
      );
  }
   
}

void draw() {
  background(255);
  image(frames[frame], button_x, button_y, frames[0].width, frames[0].height);
  fill(0);
  if (buttonValue == 'A'){
    image(frames2[0], button_x + 80, button_y+ 100, frames2[0].width, frames2[0].height);
    image(frames2[0], button_x - 4, button_y+ 100, frames2[0].width, frames2[0].height);
} else {
  image(frames2[1], button_x + 80, button_y+ 100, frames2[0].width, frames2[0].height);
  image(frames2[1], button_x - 4, button_y+ 100, frames2[0].width, frames2[0].height);
}
  
  
}

void serialEvent(Serial s) {
  buttonValue = s.readChar();
}



void mousePressed(){
  if (mouseInRect() && frame==0){
    frame=1;
    sensor.write(1);
   } else if (mouseInRect() && frame==1){
     frame=2;
     sensor.write(2);
   } else if (mouseInRect() && frame==2){
      frame=0; 
      sensor.write(0);
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
