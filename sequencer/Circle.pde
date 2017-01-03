class Circle {
  float x;
  float y;
  float x_e;
  float y_e;
  float x_s = width / 2;
  float y_s = height / 2;
  float acc = 0.1;

  boolean move;

  float radius = 50;
  float sz = 100;
  TimeLine appear;
  TimeLine timer;
  color cb = color(245, 215, 110);
  color co = color(255, 255, 255);

  Circle(float _x, float _y) {
    x = x_s;
    y = y_s;
    x_e = _x;
    y_e = _y;
    move = true;
    appear = new TimeLine(2000);
    appear.startTimer();
    timer = new TimeLine(500);
    timer.elapsedTime = 0;
  }

  void update() {
    if ( dist(x, y, x_e, y_e) > 0.1 && move ) {
      x = x + acc * ( x_e - x );
      y = y + acc * ( y_e - y );
    }
    else {
      move = false;
    }
  }

  void display() {
    noStroke();
    if ( !move ) {
      fill(lerpColor(cb, co, timer.liner()));
    }
    else {
      fill(co, 255 * appear.liner());
    }
    ellipse(x, y, radius, radius);
  }
  // void display() {
  //   imageMode(CENTER);
  //   if ( !move ) {
  //     tint(lerpColor(cb, co, timer.liner()));
  //   }
  //   else {
  //     tint(co, 255 * appear.liner());
  //   }
  //   image(img, x, y, sz, sz);
  // }

  void trigger() {
    sendOSC();
    timer.startTimer();
  }

  void sendOSC() {
    OscMessage msg = new OscMessage("/circle");
    msg.add(x);
    msg.add(y);
    oscP5.send(msg, other);
  }


}
