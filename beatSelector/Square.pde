class Square {
  int id;
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



  Square(int c_s, int r_s, int c_e, int r_e, int _id) {
    xpos = 0;
    ypos = 0;
    c_start = c_s;
    r_start = r_s;
    c_end = c_e;
    r_end = r_e;
    id = _id;
    // println(c_s);
    // println(r_s);
    // println(c_e);
    // println(r_e);

    cols = max(c_e, c_s) - min(c_e, c_s) + 1;
    rows = max(r_e, r_s) - min(r_e, r_s) + 1;
    grid = new int[cols][rows];
    updateGrid();

    timer = new TimeLine (200);
    timer.setLinerRate(4);
  }

  void update() {
    timer.startTimer();
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
    sendOSC();
  }

  void updateGrid() {
    for (int i=0; i<cols; i++) {
      for (int j=0; j<rows; j++) {
        grid[i][j] = grids[c_start+i][r_start+j];
      }
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
    fill(cf, 200 * (1 - timer.liner()));
    pushMatrix();
    translate((c_start + xpos + 0.5) * scl,
              (r_start + ypos + 0.5) * scl);
    ellipse(0, 0, scl / 1.33 , scl / 1.33);
    popMatrix();
    // rect( (c_start + xpos) * scl,
    //       (r_start + ypos) * scl,
    //       scl, scl);
  }

  void sendOSC() {
    OscMessage msg = new OscMessage("/f" + str (id));
    msg.add( grid[xpos][ypos] );
    oscP5.send(msg, other);
  }
}
