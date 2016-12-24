class Square {
  int cols;
  int rows;
  int[][] grid;
  int c_start;
  int r_start;
  int c_end;
  int r_end;
  int xpos;
  int ypos;

  TimeLine timer;



  Square(int c_s, int r_s, int c_e, int r_e) {
    xpos = 0;
    ypos = 0;
    c_start = c_s;
    r_start = r_s;
    c_end = c_e;
    r_end = r_e;
    // println(c_s);
    // println(r_s);
    // println(c_e);
    // println(r_e);

    cols = max(c_e, c_s) - min(c_e, c_s) + 1;
    rows = max(r_e, r_s) - min(r_e, r_s) + 1;
    grid = new int[cols][rows];
    for (int i=0; i<cols; i++) {
      for (int j=0; j<rows; j++) {
        grid[i][j] = grids[c_start+i][r_start+j];
      }
    }
  }

  void update() {
    if ( xpos < cols - 1 ) {
      xpos = xpos + 1;
    }
    else if ( ypos < rows - 1 ){
      xpos = 0;
      ypos = ypos + 1;
    }
    else {
      xpos = 0;
      ypos = 0;
    }
  }

  void display() {
    noFill();
    stroke(255);
    strokeWeight(3);
    rect(c_start * scl,
         r_start * scl,
         (c_end + 1) * scl
           - c_start * scl,
         (r_end + 1) * scl
           - r_start * scl);

    noStroke();
    fill(cf);
    rect( (c_start + xpos) * scl,
          (r_start + ypos) * scl,
          scl, scl);
  }
}
