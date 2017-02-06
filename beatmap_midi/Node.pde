class Node {
  Map map;

  PGraphics canvas;

  //position and orientation
  TimeLine timerOfColor;
  TimeLine timerOfDisplay;

  float angle;
  int ot;
  float unitOfAngle = PI / 2;
  float rotateRate = 0.4;
  int xpos, ypos;

  float mainAlpha = 255;
  float fadeRate = 0.1;

  //TIMES
  int nOftiming = 1;
  int timingCount = 0;

  //VELOCITY
  int vel = 1; //64 per unit


  //PITCH
  int pitch;
  int midiNote;

  //state
  boolean active = false;
  boolean triggering = false;

  Node(Map _m, int _x, int _y) {
    map = _m;
    pitch = floor(random(0, map.pitchStep.length));
    canvas = map.canvas;
    xpos = _x;
    ypos = _y;
    angle = 0;
    ot = floor(random(4));

    timerOfColor = new TimeLine(300);
    timerOfColor.setLinerRate(2);
    timerOfColor.set1();

    timerOfDisplay = new TimeLine(300);
    timerOfDisplay.setLinerRate(2);
    timerOfDisplay.set1();
  }
  Node(Map _m, int _x, int _y, int _midi) {
    map = _m;
    midiNote = _midi;
    canvas = map.canvas;
    xpos = _x;
    ypos = _y;
    angle = 0;
    ot = floor(random(4));

    timerOfColor = new TimeLine(300);
    timerOfColor.setLinerRate(2);
    timerOfColor.set1();

    timerOfDisplay = new TimeLine(300);
    timerOfDisplay.setLinerRate(2);
    timerOfDisplay.set1();
  }

  void update() {
    float al;
    if (map.tabs[TIMES].active ||
        map.tabs[VELOCITY].active ||
        map.tabs[PITCH].active )
        { al = 0; }
    else { al = 255; }

    angle = angle + rotateRate * (ot * unitOfAngle - angle);
    mainAlpha = mainAlpha + fadeRate * (al - mainAlpha);
  }
  void display() {
    if (map.tabs[TIMES].active) {
      timingDisplay();
    }
    else if (map.tabs[VELOCITY].active) {
      velocityDisplay();
    }
    else if (map.tabs[PITCH].active) {
      pitchDisplay();
    }
    shapeDisplay();
    blinkDisplay();
  }
  void shapeDisplay() {
    canvas.pushMatrix();
    if (active) { canvas.fill(_active, mainAlpha); }
    else { canvas.fill(_normal, mainAlpha); }

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
  void timingDisplay() {
    canvas.pushMatrix();
    if (active) { canvas.fill(_active, 255 - mainAlpha); }
    else { canvas.fill(_normal, 255 - mainAlpha); }

    canvas.translate(margin + scl / 2, margin + scl / 2);
    canvas.translate(xpos * scl, ypos * scl);
    canvas.noStroke();

    switch(nOftiming) {
      case 1 :
        canvas.ellipse(0, 0, scl / 2, scl / 2);
        break;
      case 2 :
        canvas.ellipse(scl / 5, 0, scl / 3, scl / 3);
        canvas.ellipse(-1 * scl / 5, 0, scl / 3, scl / 3);
        break;
      case 3 :
        canvas.ellipse(scl / 5, 0, scl / 4, scl / 4);
        canvas.ellipse(-1 * scl / 5, scl / 5, scl / 4, scl / 4);
        canvas.ellipse(-1 * scl / 5, -1 * scl / 5, scl / 4, scl / 4);
        break;
      case 4 :
        canvas.ellipse(scl / 5, scl / 5, scl / 4, scl / 4);
        canvas.ellipse(scl / 5, -1 * scl / 5, scl / 4, scl / 4);
        canvas.ellipse(-1 * scl / 5, scl / 5, scl / 4, scl / 4);
        canvas.ellipse(-1 * scl / 5, -1 * scl / 5, scl / 4, scl / 4);
        break;
      default :
        canvas.ellipse(0, 0, scl / 2, scl / 2);
        break;
    }

    canvas.popMatrix();
  }
  void velocityDisplay() {
    canvas.pushMatrix();
    if (active) { canvas.fill(_active, 255 - mainAlpha); }
    else { canvas.fill(_normal, 255 - mainAlpha); }
    canvas.translate(margin + scl / 4, margin + scl);
    canvas.translate(xpos * scl, ypos * scl);
    canvas.noStroke();
    canvas.rect(0, 0, scl / 2, -1 * map(getVelocity(), 0, 255, 0, scl),
                scl / 5, scl / 5, 0, 0);
    canvas.popMatrix();
  }
  void pitchDisplay() {
    canvas.pushMatrix();
    if (active) { canvas.fill(_active, 255 - mainAlpha); }
    else { canvas.fill(_normal, 255 - mainAlpha); }
    canvas.translate(margin + scl / 4, margin + scl);
    canvas.translate(xpos * scl, ypos * scl);
    canvas.rect(0, 0, scl / 2, -1 * map(pitch, 0, float(map.pitchStep.length), 0, float(scl)));
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
    if (active) {
      timingCount++;
      sendOSC();
      sendMIDI();
    }
  }

  void sendClock(int b) {
    if (triggering && active) {
      if (timingCount == nOftiming) {
        timingCount = 0;
        triggering = false;
      }
      else if (b % (24 / nOftiming) == 0) {
        timingCount++;
        sendOSC();
        sendMIDI();
      }
    }
  }

  void sendOSC() {
    OscMessage msg = new OscMessage("/m" + str(map.id));
    oscP5.send(msg, other);
  }
  void sendMIDI() {
    int ch = 0;
    int pit = getPitch();
    int vel = getVelocity();

    midi.sendNoteOn(ch, pit, vel); // Send a Midi noteOn
    delay(10);
    midi.sendNoteOff(ch, pit, vel); // Send a Midi nodeOff
  }
  //parameter adjustment
  void setTiming() {
    nOftiming = (nOftiming % 4) + 1;
  }
  void setTiming(int i) {
    nOftiming = i % 4 + 1;
  }
  void setVelocity() {
    vel = (vel % 7) + 1;
  }
  void setVelocity(int i) {
    vel = i % 7 + 1;
  }
  int getVelocity() {
    return vel * 32;
  }
  void setPitch() {
    pitch = (pitch + 1) % map.pitchStep.length;
  }
  void setPitch(int i) {
    pitch = i % map.pitchStep.length;
  }
  int getPitch() {
    return map.pitchStep[pitch];
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
