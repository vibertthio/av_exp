PImage img;
import oscP5.*;
import netP5.*;

ArrayList<Circle> circles;
Metro metro;
int beat;
int b;
boolean bang;

//oscP5
OscP5 oscP5;
NetAddress other;

void setup() {
  size(800, 800);
  frameRate(60);
  background(0);
  img = loadImage("blur.png");
  circles = new ArrayList<Circle>();
  metro = new Metro(true, 300);
  beat = 0;
  b = 0;
  bang = false;

  //oscP5
  oscP5 = new OscP5(this, 12000);
  other = new NetAddress("127.0.0.1", 12002);
}


void draw() {
  background(0);

  if (metro.frameCount() > beat) {
    println("beat : " + beat);
    beat = beat + 1;
    if (!circles.isEmpty()) {
      b = beat % ( circles.size() );
    }
    bang = true;
  }
  else {
    bang = false;
  }




  for (int i = 0, n = circles.size(); i < n; i++) {
    Circle c = circles.get(i);
    c.update();
    c.display();
    if ( bang && i==b ) {
      // println("trigger!!!!!");
      c.trigger();
    }
  }

}


void mousePressed() {
  if (mouseButton == LEFT) {
    circles.add( new Circle(mouseX, mouseY));
  }
}

void keyPressed() {
  if (key == ' ') {
    circles.clear();
  }
}

int nOfC(ArrayList<Circle> list) {
  int ret = 0;
  for( int i = 0, n = list.size(); i < n; i++) {
    if ( !list.get(i).move ) { ret++; }
  }
  return ret;
}
