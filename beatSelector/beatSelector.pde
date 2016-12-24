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

int pressedIndex;

Square[] squares;
int numberOfSquares = 4;
Metro metro;
float bpm = 100;
int beat;


color cg = color(210, 82, 127);
color cf = color(247, 202, 24);
void setup() {
  size(800, 800);
  cols = int(w_frame / scl);
  rows = int(h_frame / scl);
  grids = new int[cols][rows];
  init();
  update();
  metro = new Metro(true, floor(6000/bpm) );
  beat = metro.frameCount();
}

void draw() {
  background(255);
  display();


  boolean next = false;
  if ( metro.frameCount() > beat ) {
    beat = beat + 1;
    next = true;
  }
  for (int i=0; i<numberOfSquares; i++) {
    if (mousePressed && pressedIndex == i) {
      drawFrame();
    }
    else {
      if ( next ) {
        beat = beat + 1;
        squares[i].update();
      }
      squares[i].display();
    }
  }

}


void mousePressed() {
  if (mouseX < w_frame && mouseY < h_frame) {
    c_pressed = floor(mouseX / scl);
    r_pressed = floor(mouseY / scl);
  }
}
void mouseReleased() {
  // println("c_s :" + str(c_pressed));
  // println("r_s :" + str(r_pressed));
  // println("c_e :" + str(c_dragged));
  // println("r_e :" + str(r_dragged));
  if (keyPressed) {
    if (pressedIndex > -1 && pressedIndex < numberOfSquares ) {
      squares[pressedIndex] = new Square(c_pressed,
                              r_pressed,
                              c_dragged,
                              r_dragged);
    }
  }
}
void mouseClicked() {
  update();
}
void keyPressed() {
  //1~4 -> 49, 50, 51, 52
  int k = int(key);
  if ( k >= 49 && k <= 52 ) {
    // pressed[ k-49 ] = true;
    pressedIndex = k-49;
  }
  else {
    pressedIndex = -1;
  }
}
void keyReleased() {
  //1~4 -> 49, 50, 51, 52
  int k = int(key);
  if ( k >= 49 && k <= 52 ) {
    // pressed[ k-49 ] = false;
    pressedIndex = -1;
  }
}

void init() {
  squares = new Square[numberOfSquares];
  for (int i=0; i<numberOfSquares; i++) {
    squares[i] = new Square(0, 0, 1, 1);
  }
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
void drawFrame() {
  noFill();
  stroke(cf);
  strokeWeight(3);
  if (mouseX < w_frame && mouseY < h_frame) {
    if (mouseX > c_pressed * scl) {
      c_dragged = floor(mouseX / scl);
    }
    // else {
    //   c_dragged = floor(mouseX / scl);
    // }
    if (mouseY > r_pressed * scl) {
      r_dragged = floor(mouseY / scl);
    }
    // else {
    //   r_dragged = floor(mouseY / scl);
    // }
  }
  rect(c_pressed * scl,
       r_pressed * scl,
       ( c_dragged - c_pressed + 1 ) * scl,
       ( r_dragged - r_pressed + 1 ) * scl );
}
