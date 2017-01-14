class Particle {
  PVector pos;
  PVector vec;
  PVector acc;
  PVector prevPos;
  float mass = 1;
  float maxspeed = 4;
  color col;


  Particle() {
    pos = new PVector( random(width), random(height));
    prevPos = pos.copy();
    vec = PVector.random2D();
    acc = new PVector(0, 0);
  }

  Particle(float x, float y) {
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
    float rate = 6.5;
    float offset = 3.7;
    int scale = 30;
    // int r = floor((noiseField[5] * 6 + 5.70074) * 15 * ( 1 + noiseField[5]));
    // int g = floor((noiseField[cols] * 6 + 5.70074) * 15 * ( 1 + noiseField[cols]));
    // int b = floor((noiseField[(cols - 1)*(rows - 1)] * 6 + 5.70074) * 15 * ( 1 + noiseField[(cols - 1)*(rows - 1)]));
    int r = floor((noiseField[5] * rate + offset) * scale);
    int g = floor((noiseField[cols] * rate + offset) * scale);
    int b = floor((noiseField[(cols - 1)*(rows - 1)] * rate + offset) * scale);

    println("r:" + r);
    println("g:" + g);
    println("b:" + b);

    col = color(r, g, b);

    stroke(col, 5);
    strokeWeight(1);

    // point(this.pos.x, this.pos.y);
    line(this.pos.x, this.pos.y, this.prevPos.x, this.prevPos.y);
    // this.updatePrev();
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
}
