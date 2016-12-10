class Circle {
  float x;
  float y;
  float z;
  float x_center;
  float radius;
  float angle;

  float sz;
  float speed;

  color col;
  TimeLine timer;

  Circle(float _x, float _y, float _sz) {
    x = _x;
    y = _y;
    sz = _sz;
    radius = 50 + random(100);
    x_center = x - radius;
    angle = 0;
    col = color(40 + random(200),
                40 + random(200),
                40 + random(200));
    timer = new TimeLine(1500 + int(random(500)));
    timer.startTimer();
  }

  void update() {
    //move in Circle
    x = x_center + radius * cos ( angle );
    z = radius * sin ( angle );
    angle = ( angle + 0.01 ) % (2 * PI);

    if ( !timer.state ) {
      timer.startTimer();
      pd.sendFloat("period", timer.limit);
    }
  }

  void display() {
    pushMatrix();
    translate(x, y, z);
    // ellipseMode(CENTER);
    // fill(col, 50);
    // ellipse(0, 0, sz * 2, sz * 2);
    imageMode(CENTER);
    tint(col, 40*timer.liner());
    image(img, 0, 0, sz * 4, sz * 4);
    popMatrix();
  }


}
