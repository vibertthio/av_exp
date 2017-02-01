import org.puredata.processing.PureData;

PureData pd;
Circle[] circles;
PImage img;

boolean pressing = false;
float x_pressed;
float y_pressed;

int maxNumberOfCircles = 100;
int numberOfCircles = 0;

void setup() {
  frameRate(100);
  size(800, 600, P3D);
  background(0);
  blendMode(ADD);
  circles = new Circle[maxNumberOfCircles];
  createImage();
  hint(ENABLE_DEPTH_SORT);

  pd = new PureData(this, 44100, 0, 2);
  pd.openPatch("test.pd");
  pd.start();
}

void draw() {
  background(0);
  if ( pressing ) {
    drawDots();
  }
  for(int i = 0; i < numberOfCircles; i++) {
    circles[i].update();
    circles[i].display();
  }
}

void mousePressed() {
  pressing = true;
  x_pressed = mouseX;
  y_pressed = mouseY;
}

void mouseReleased() {
  pressing = false;
  createCircle();
}

void keyPressed() {
  if ( key == 'c' ) {
    clearCirlces();
  }
}

//other function
void createImage() {
  int w = 400;
  PGraphics pg;
  pg = createGraphics(w, w, P2D);
  pg.beginDraw();
  pg.background(0,0,0,0);
  pg.fill(255);
  pg.noStroke();
  pg.ellipse(w/2, w/2, w/2, w/2);
  pg.filter(BLUR,20);
  pg.endDraw();
  img = pg.get();
}
void drawDots() {
  int numberOfDots = 60;
  float d = 2;
  float r = dist(mouseX, mouseY, x_pressed, y_pressed);
  float delta = 2 * PI / numberOfDots;
  pushMatrix();
  translate( x_pressed, y_pressed);
  for (int i = 0; i < numberOfDots; i++) {
    noStroke();
    fill(255);
    float x = r * cos ( i * delta );
    float y = r * sin ( i * delta );
    ellipse( x, y, d, d);
  }
  popMatrix();
}
void createCircle() {
  if ( numberOfCircles < maxNumberOfCircles - 1 ) {
    float r = dist(mouseX, mouseY, x_pressed, y_pressed);
    circles[numberOfCircles] = new Circle(x_pressed, y_pressed, r);
    numberOfCircles++;
  }
}
void clearCirlces() {
  numberOfCircles = 0;
}
