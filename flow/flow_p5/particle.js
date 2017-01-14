function Particle(x, y) {
  if (x&&y) {
    this.pos = createVector(x, y);
  }
  else {
    this.pos = createVector(random(width), random(height));
  }
  
  this.vel = p5.Vector.random2D(0, 0);
  // this.vel = createVector(0, 0);
  this.acc = createVector(0, 0);
  this.maxspeed = 4;
  this.prevPos = this.pos.copy();
  this.mass = 1.5;

  this.update = function() {
    this.updatePrev();
    this.vel.add(this.acc);
    this.vel.limit(this.maxspeed);
    this.pos.add(this.vel);
    this.acc.mult(0);
  }

  this.applyForce = function( force ) {
    // this.acc = force;
    this.acc.add(force);
  }

  this.show = function() {
    stroke('rgba('+ str(r) +','+ str(g) +','+ str(b) +',0.02)');
    // strokeWeight(3);
    // point(this.pos.x, this.pos.y);
    line(this.pos.x, this.pos.y, this.prevPos.x, this.prevPos.y);
    // this.updatePrev();
  }

  this.follow = function( flowField ) {
    var col = constrain ( floor ( this.pos.x / scl ), 0, cols - 1);
    var row = constrain ( floor ( this.pos.y / scl ), 0, rows - 1);
    var index = col + row * cols;
    var ff = p5.Vector.div( flowField[index], this.mass);
    this.applyForce( ff );
  }

  this.updatePrev = function() {
    this.prevPos = this.pos.copy();
  }

  this.edges = function() {
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

    this.updatePrev();
  }

}
