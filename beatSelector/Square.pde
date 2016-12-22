class Square {
  int cols;
  int rows;
  int[][] grid;
  int c_start;
  int r_start;
  int c_end;
  int r_end;


  Square(int c_s, int r_s, int c_e, int r_e) {
    c_start = c_s;
    r_start = r_s;
    c_end = c_e;
    r_end = r_e;
    cols = c_s - c_e + 1;
    rows = r_s - r_e + 1;
    grid = new int[cols][rows];
    for (int i=0; i<cols; i++) {
      for (int j=0; j<rows; j++) {
        grid[i][j] = grids[c_start+i][r_start+j];
      }
    }
  }

  void update() {

  }

  void display() {
    noFill();
    stroke(cf);
    strokeWeight(3);
    rect(c_start * scl,
         r_start * scl,
         (c_end + 1) * scl
           - c_pressed * scl,
         (r_end + 1) * scl
           - r_pressed * scl);
  }
}
