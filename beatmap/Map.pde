class Map {
  int id;
  PGraphics canvas;
  Node[][] nodes;
  float xpos, ypos;
  Metro metro;
  int timeUnit = 200;
  int xx, yy;
  int beat;

  float mX, mY;

  //state
  boolean mouseOver = false;
  boolean adjustTimes = false;
  Tab tabOfTimes;
  boolean mouseOverTimes = false;
  float alpha;


  Map(int _i, float _x, float _y) {
    id = _i;
    xx = 0;
    yy = 0;
    xpos = _x;
    ypos = _y;
    canvas = createGraphics(len, len);
    metro = new Metro(true, timeUnit);
    beat = metro.frameCount();
    nodes = new Node[nOfc][nOfc];

    for(int i = 0; i < nOfc; i++) {
      for(int j = 0; j < nOfc; j++) {
        nodes[i][j] = new Node(this, i, j);
        nodes[i][j].setOt(otDefault[j * nOfc + i]);
      }
    }

    //tabs
    tabOfTimes = new Tab(this, 0, _adjustTime);
  }

  void update() {
    if (metro.frameCount() > beat) {
      beat = beat + 1;
      nodes[xx][yy].trigger();
      //TODO the unit of angle

      int ot = nodes[xx][yy].ot % 4;
      switch(ot) {
        case 0 :
          xx = (xx + nOfc + 1) % nOfc;
          break;
        case 1 :
          yy = (yy + nOfc + 1) % nOfc;
          break;
        case 2 :
          xx = (xx + nOfc - 1) % nOfc;
          break;
        case 3 :
          yy = (yy + nOfc - 1) % nOfc;
          break;
        default:
      }


    }
    for(int i = 0; i < nOfc; i++) {
      for(int j = 0; j < nOfc; j++) {
        nodes[i][j].update();
      }
    }
  }
  void display() {
    canvas.beginDraw();
    backgroundDisplay();
    gridDisplay();
    nodesDisplay();
    controlPanelDisplay();

    canvas.endDraw();
    image(canvas, xpos, ypos);
  }

  void backgroundDisplay() {
    // canvas.background(_gbk);
    canvas.noStroke();
    canvas.fill(_gbk);
    canvas.rect(0, 0, len, len, scl / 2);
  }
  void gridDisplay() {
    for (int i = 0; i <= nOfc; i++) {
      float p = margin + map(i, 0, nOfc, 0, nOfc * scl);
      canvas.stroke(255, 30);
      canvas.line(p, 0, p, len);
      canvas.line(0, p, len, p);
    }
  }
  void nodesDisplay() {
    for(int i = 0; i < nOfc; i++) {
      for(int j = 0; j < nOfc; j++) {
        nodes[i][j].display();
      }
    }
  }
  void controlPanelDisplay() {
    // float al = (mouseOverTimes)?200:50;
    // alpha = alpha + 0.2 * (al - alpha);
    //
    // canvas.pushMatrix();
    // canvas.noStroke();
    // canvas.fill(_adjustTime, alpha);
    // canvas.translate(margin, 0);
    // canvas.rect(scl / 8, 0, scl * 3 / 4, scl / 3);
    // canvas.popMatrix();
    tabOfTimes.display();
  }
  void mouseSensed(float _mX, float _mY) {
    mX = _mX - xpos;
    mY = _mY - ypos;

    if ( contain(mX, mY)) {
      mouseOver = true;
      int i = floor((mX - margin)/ float(scl));
      int j = floor((mY - margin)/ float(scl));
      tabOfTimes.mouseOver = (i == 0 && j == -1);
    }
    else {
      mouseOver = false;
    }
  }

  void mousePressed() {
    int i = floor((mX - margin)/ float(scl));
    int j = floor((mY - margin)/ float(scl));
    if ( inGrids(mX, mY) ) {
      if (activating) {
        nodes[i][j].activate();
      }
      else {
        nodes[i][j].rotateClockwise();
      }
    }
    else {
      if (i == 0 && j == -1) {
        tabOfTimes.activate();
      }
    }
  }
  boolean contain(float x, float y) {
    return (x > 0)&&(x < len )&&(y > 0)&&(y < len);
  }
  boolean inGrids(float x, float y) {
    return (x > margin)&&(x < len - margin)&&(y > margin)&&(y < len - margin);
  }
}
