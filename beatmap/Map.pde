class Map {
  PGraphics canvas;
  Node[][] nodes;
  int nOfc = 5;
  float xpos, ypos;

  int margin = scl / 2;

  Map(float _x, float _y) {
    int len = (2 * nOfc + 1) * scl;
    println("len: " + len);
    xpos = _x;
    ypos = _y;
    canvas = createGraphics(len, len);
    nodes = new Node[nOfc][nOfc];

    for(int i = 0; i < nOfc; i++) {
      for(int j = 0; j < nOfc; j++) {
        nodes[i][j] = new Node(canvas, i, j);
      }
    }
  }

  void update() {
    for(int i = 0; i < nOfc; i++) {
      for(int j = 0; j < nOfc; j++) {
        nodes[i][j].update();
      }
    }
  }

  void display() {
    canvas.beginDraw();
    canvas.background(_gbk);

    for(int i = 0; i < nOfc; i++) {
      for(int j = 0; j < nOfc; j++) {
        nodes[i][j].display();
      }
    }

    canvas.endDraw();
    image(canvas, xpos, ypos);
  }

  void mousePressed(float mX, float mY) {
    if
    int x = round((mX - xpos - scl)/ (2 * scl));
    int y = round((mY - ypos - scl)/ (2 * scl));
    println("x: " + x);
    println("y: " + y);

    nodes[x][y].rotateClockwise();
  }
}
