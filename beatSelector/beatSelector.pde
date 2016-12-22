float scl = 50;
int w_frame = 800;
int h_frame = 800;
int[][] grids;
int cols;
int rows;
int c_pressed;
int r_pressed;
int c_dragged;
int r_dragged;

Square sq;
boolean exist;

//state
boolean pressed = false;


color cg = color(210, 82, 127);
color cf = color(247, 202, 24);
void setup() {
  size(800, 800);
  cols = int(w_frame / scl);
  rows = int(h_frame / scl);
  grids = new int[cols][rows];
  update();
}


void draw() {
  background(255);
  display();
  if (pressed) {
    drawFrame();
  }

  if (pressed) {
    sq.display();
  }
}

void mousePressed() {
  if (mouseX < w_frame && mouseY < h_frame) {
    c_pressed = int(mouseX / scl);
    r_pressed = int(mouseY / scl);
    pressed = true;
  }
}

void mouseReleased() {
  sq = new
  pressed = false;
}

void mouseClicked() {
  update();
}

void drawFrame() {
  noFill();
  stroke(cf);
  strokeWeight(3);
  if (mouseX < w_frame && mouseY < h_frame) {
    if (mouseX > c_pressed * scl) {
      c_dragged = ceil(mouseX / scl);
    }
    else {
      c_dragged = floor(mouseX / scl);
    }
    if (mouseY > r_pressed * scl) {
      r_dragged = ceil(mouseY / scl);
    }
    else {
      r_dragged = floor(mouseY / scl);
    }
  }
  rect(c_pressed * scl,
       r_pressed * scl,
       c_dragged * scl
         - c_pressed * scl,
       r_dragged * scl
         - r_pressed * scl);
}

void update() {
  float step = 0.1;
  float offset = (millis()/1000.0) ;
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      // grids[i][j] = int( map(noise(offset + j*step, offset + i*step), 0, 1, 0, 255) );
      grids[i][j] = int( map(random(1), 0, 1, 0, 255) );
    }
  }
}

void display() {
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      noStroke();
      fill(cg, grids[i][j]);
      rect(i*scl, j*scl, scl, scl);
    }
  }
}
