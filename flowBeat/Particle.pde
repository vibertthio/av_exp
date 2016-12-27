class Particle {
  int id = -1;
  PVector pos;
  PVector vec;
  PVector acc;
  PVector prevPos;
  float mass = 1;
  float maxspeed = 3;

  int row;
  int col;


  Particle() {
    pos = new PVector( random(width), random(height));
    prevPos = pos.copy();
    vec = PVector.random2D();
    acc = new PVector(0, 0);
  }
  Particle(float x, float y, int _id) {
    id = _id;
    pos = new PVector( x, y);
    prevPos = pos.copy();
    vec = PVector.random2D();
    acc = new PVector(0, 0);
  }

  void update() {
    updatePrev();
    vec.add(acc);
    vec.limit(maxspeed);
    pos.add(vec);
    acc.mult(0);
  }
  void display() {
    stroke(ck);
    strokeWeight(4);
    // fill(cf);
    noFill();
    ellipse(this.pos.x, this.pos.y, 50, 50);
  }
  void follow( PVector[] ff ) {
    int col = constrain ( floor ( this.pos.x / scl ), 0, cols - 1);
    int row = constrain ( floor ( this.pos.y / scl ), 0, rows - 1);
    int index = col + row * cols;
    applyForce( PVector.div( ff[index], mass));
  }
  void updatePrev() {
    prevPos = pos.copy();
  }
  boolean updatePosInGrid() {
    int _c = constrain ( floor ( this.pos.x / scl ), 0, cols - 1);
    int _r = constrain ( floor ( this.pos.y / scl ), 0, rows - 1);
    boolean ret = false;
    if ( (col != _c) || (row != _r) ) {
      // sendOSC(_r, _c);
      ret = true;
    }
    col = _c;
    row = _r;
    return ret;
  }
  void applyForce( PVector force ) {
    acc.add(force);
  }
  void edges() {
    if ( this.pos.x > width ) {
      this.pos.x = 0;
    }
    else if ( this.pos.x < 0 ) {
      this.pos.x = width;
    }
    else if ( this.pos.y > height ) {
      this.pos.y = 0;
    }
    else if ( this.pos.y < 0 ) {
      this.pos.y = height;
    }
    else {
      //no cross monitor
      return;
    }

    updatePrev();
  }
  void sendOSC(int c, int r) {
    OscMessage msg = new OscMessage("/p" + str (id));
    msg.add( grid.get(r, c) );
    oscP5.send(msg, other);
  }

  void sendOSC() {
    OscMessage msg = new OscMessage("/p" + str (id));
    msg.add( grid.get(row, col) );
    oscP5.send(msg, other);
  }
}
