class Particle {
  PVector pos;
  PVector vec;
  PVector acc;
  PVector prevPos;
  float mass = 1;
  float maxspeed = 4;


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
    stroke(0, 5);
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
