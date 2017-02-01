class Node {
  PGraphics canvas;
  Metro metro;
  
  //position and orientation
  float angle;
  int ot = 0;
  float unitOfAngle = PI / 2;
  float rotateRate = 0.2;
  int xpos, ypos;


  Node(PGraphics _canvas, int _x, int _y) {
    canvas = _canvas;
    xpos = _x;
    ypos = _y;
    angle = 0;
  }

  void update() {
    angle = angle + rotateRate * (ot * unitOfAngle - angle);
  }

  void display() {
    canvas.pushMatrix();
    canvas.fill(255);
    canvas.translate(scl/2, scl/2);
    canvas.translate((2*xpos + 1) * scl, (2*ypos + 1) * scl);

    canvas.rotate(angle);
    canvas.noStroke();
    canvas.beginShape();
    canvas.vertex(scl/4, 0);
    canvas.vertex(-scl/4, scl/4);
    canvas.vertex(-scl/4, -scl/4);
    canvas.endShape(CLOSE);
    // canvas.stroke(0);
    // canvas.strokeWeight(3);
    // canvas.point(0, 0);
    canvas.popMatrix();

  }

  void rotateClockwise() {
    ot = ot + 1;
  }
  void rotateCounterclockwise() {
    ot = ot - 1;
  }
}
