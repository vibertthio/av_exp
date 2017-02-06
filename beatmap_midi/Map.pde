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

  int[] pitchStep = {
    36, 37, 39, 41, 43, 44, 46,
    48, 49, 51, 53, 55, 56, 58,
    60, 61, 63, 65, 67, 68, 70,
  };

  //state
  boolean mouseOver = false;

  //sense, pressed, display
  //three sections need to be adjusted
  // Tab tabOfTimes;
  // Tab tabOfPitch;
  // Tab tabOfVel;

  Tab[] tabs;
  int nOfTabs = 3;


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
        nodes[i][j] = new Node(this, i, j, midiNotes[id]);
        nodes[i][j].setOt(otDefault[j * nOfc + i]);
      }
    }

    //tabs
    tabs = new Tab[nOfTabs];
    for (int i = 0; i < nOfTabs; i++) {
      tabs[i] = new Tab(this, i, _colorOfTabs[i]);
    }
  }

  void update() {
    for(int i = 0; i < nOfc; i++) {
      for(int j = 0; j < nOfc; j++) {
        nodes[i][j].update();
      }
    }
  }
  void toNext() {
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
  void sendClock(int b) {
    for(int i = 0; i < nOfc; i++) {
      for(int j = 0; j < nOfc; j++) {
        nodes[i][j].sendClock(b);
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
    for (int i = 0; i < nOfTabs; i++) {
      tabs[i].display();
    }
  }
  void mouseSensed(float _mX, float _mY) {
    mX = _mX - xpos;
    mY = _mY - ypos;

    if ( contain(mX, mY)) {
      mouseOver = true;
      int c = floor((mX - margin)/ float(scl));
      int r = floor((mY - margin)/ float(scl));
      for (int i = 0; i < nOfTabs; i++) {
        tabs[i].mouseOver = (c == i && r == -1);
      }
    }
    else {
      mouseOver = false;
    }
  }

  void mousePressed() {
    int c = floor((mX - margin)/ float(scl));
    int r = floor((mY - margin)/ float(scl));
    if ( inGrids(mX, mY) ) {
      Node node = nodes[c][r];
      if (activating) {
        node.activate();
      }
      else if (tabs[TIMES].active) {
        node.setTiming();
      }
      else if (tabs[VELOCITY].active) {
        node.setVelocity();
      }
      else if (tabs[PITCH].active) {
        node.setPitch();
      }
      else {
        node.rotateClockwise();
      }
    }
    else if (contain(mX, mY)) {
      if (r == -1){
        for (int i = 0; i < nOfTabs; i++) {
          if (c != i) {
            tabs[i].deactivate();
          }
          else {
            tabs[i].trigger();
          }
        }
      }
    }
  }
  void mouseWheel(float e) {

  }
  boolean contain(float x, float y) {
    return (x > 0)&&(x < len )&&(y > 0)&&(y < len);
  }
  boolean inGrids(float x, float y) {
    return (x > margin)&&(x < len - margin)&&(y > margin)&&(y < len - margin);
  }
}
