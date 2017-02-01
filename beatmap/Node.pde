class Node {
  PGraphics canvas;

  //position and orientation
  TimeLine timer;
  float angle;
  int ot = 0;
  float unitOfAngle = PI / 2;
  float rotateRate = 0.2;
  int xpos, ypos;

  Node(PGraphics _canvas, int _x, int _y) {
    canvas = _canvas;
    timer = new TimeLine(300);
    timer.setLinerRate(2);
    timer.set1();
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
    canvas.translate(margin + scl / 2, margin + scl / 2);
    canvas.translate(xpos * scl, ypos * scl);

    canvas.rotate(angle);
    canvas.noStroke();
    canvas.beginShape();
    canvas.vertex(scl/3, 0);
    canvas.vertex(-scl/4, scl/4);
    canvas.vertex(-scl/4, -scl/4);
    canvas.endShape(CLOSE);
    // canvas.stroke(0);
    // canvas.strokeWeight(3);
    // canvas.point(0, 0);
    canvas.popMatrix();

    //blink
    canvas.pushMatrix();
    canvas.translate(margin, margin);
    canvas.translate(xpos * scl, ypos * scl);

    canvas.noStroke();
    canvas.fill(_blink, 200 * (1 - timer.liner()));
    canvas.rect(0, 0, scl, scl);
    canvas.popMatrix();
  }
  void trigger() {
    timer.startTimer();
  }

  void rotateClockwise() {
    ot = ot + 1;
  }
  void rotateCounterclockwise() {
    ot = ot - 1;
  }
}
