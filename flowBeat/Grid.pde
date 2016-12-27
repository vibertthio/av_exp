class Grid {
  int[][] grids;
  int cols;
  int rows;
  float scl;

  TimeLine[][] timer;
  Vstate[][] vgates;
  int tth = 1000;


  Grid(int _c, int _r, float _scl) {
    cols = _c;
    rows = _r;
    scl = _scl;
    grids = new int[rows][cols];
    timerInit();
    update();
  }

  void update() {
    float step = 0.1;
    // float offset = (millis()/1000.0) ;
    for (int i=0; i<rows; i++) {
      for (int j=0; j<cols; j++) {
        // grids[i][j] = int( map(noise(offset + j*step, offset + i*step), 0, 1, 0, 255) );
        grids[i][j] = int( map(random(1), 0, 1, 0, 255) );
      }
    }
  }

  void display() {
    for (int i=0; i<rows; i++) {
      for (int j=0; j<cols; j++) {
        noStroke();
        fill(cg, grids[i][j]);
        rect(j * scl, i * scl, scl, scl);
        TimeLine t = timer[i][j];
        if (t.state) {
          fill(cf, 255 * (1 - t.liner()) );
          println("i(r) : " + i);
          println("j(c) : " + j);
          rect(j * scl, i * scl, scl, scl);
        }
      }
    }
  }

  int get(int r, int c) {
    return grids[r][c];
  }

  void timerInit() {
    timer = new TimeLine[rows][cols];
    vgates = new Vstate[rows][cols];
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        timer[i][j] = new TimeLine(200);
        vgates[i][j] = new Vstate(tth, 0);
      }
    }
  }

  boolean blink(int r, int c) {
    println("r : " + r);
    println("c : " + c);
    Vstate g = vgates[r][c];
    g.set(false);
    if ( !g.getState() ) {
      timer[r][c].startTimer();
      g.set(true);
      return true;
    }
    return false;
  }

}
