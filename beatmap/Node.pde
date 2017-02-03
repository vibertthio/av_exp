class Node {
  Map map;

  PGraphics canvas;

  //position and orientation
  TimeLine timerOfColor;
  TimeLine timerOfTiming;

  float angle;
  int ot;
  float unitOfAngle = PI / 2;
  float rotateRate = 0.2;
  int xpos, ypos;

  int nOftiming = 1;
  int timingCount = 0;

  //state
  boolean active = false;
  boolean triggering = false;

  Node(Map _m, int _x, int _y) {
    map = _m;
    canvas = map.canvas;
    timerOfColor = new TimeLine(300);
    timerOfColor.setLinerRate(2);
    timerOfColor.set1();
    xpos = _x;
    ypos = _y;
    angle = 0;
    ot = floor(random(4));

    timerOfTiming = new TimeLine(map.timeUnit / nOftiming);
  }

  void update() {
    angle = angle + rotateRate * (ot * unitOfAngle - angle);
    if (active) {
      if (triggering) {
        if (timingCount == nOftiming) {
          timingCount = 0;
          triggering = false;
        }
        else if (timerOfTiming.liner() == 1) {
          timingCount++;
          sendOSC();
          timerOfTiming.startTimer();
        }
      }
    }
  }
  void display() {
    shapeDisplay();
    blinkDisplay();
  }
  void shapeDisplay() {
    canvas.pushMatrix();
    if (active) { canvas.fill(_active); }
    else { canvas.fill(_normal); }

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
  }
  void blinkDisplay() {
    //blink
    canvas.pushMatrix();
    canvas.translate(margin, margin);
    canvas.translate(xpos * scl, ypos * scl);

    canvas.noStroke();
    canvas.fill(_blink, 200 * (1 - timerOfColor.liner()));
    canvas.rect(0, 0, scl, scl);
    canvas.popMatrix();
  }

  //signal
  void activate() {
    active = !active;
  }
  void trigger() {
    timingCount = 0;
    triggering = true;
    timerOfColor.startTimer();
    timerOfTiming.startTimer();
    if (active) {
      timingCount++;
      sendOSC();
    }
  }
  void sendOSC() {
    OscMessage msg = new OscMessage("/m" + str(map.id));
    oscP5.send(msg, other);
  }

  //parameter adjustment
  void setTiming() {
    nOftiming = (nOftiming % 4) + 1;
    println("timing: " + nOftiming);
    timerOfTiming.limit = map.timeUnit / nOftiming;
  }
  void setTiming(int i) {
    nOftiming = i;
    timerOfTiming.limit = map.timeUnit / nOftiming;
  }



  //utility
  void setOt(int _o) {
    ot = _o;
  }
  void rotateClockwise() {
    ot = ot + 1;
  }
  void rotateCounterclockwise() {
    ot = ot - 1;
  }



}
