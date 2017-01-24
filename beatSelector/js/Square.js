function Square(c_s, r_s, c_e, r_e, _id) {
  this.xpos = 0;
  this.ypos = 0;
  this.id = _id;

  this.grid = [];
  this.c_start = c_s;
  this.r_start = r_s;
  this.c_end = c_e;
  this.r_end = r_e;

  this.cols = max(c_e, c_s) - min(c_e, c_s) + 1;
  this.rows = max(r_e, r_s) - min(r_e, r_s) + 1;



  this.timer = new TimeLine(200);
  this.timer.setLinerRate(4);

  this.update = function() {
    this.timer.startTimer();
    if ( this.xpos < this.cols - 1 ) {
      this.xpos = this.xpos + 1;
    }
    else if ( this.ypos < this.rows - 1 ) {
      this.xpos = 0;
      this.ypos = this.ypos + 1;
    }
    else {
      this.xpos = 0;
      this.ypos = 0;
    }

    // TODO
    //tirgger sound

  }

  this.updateGrid = function() {
    for (var i = 0; i < this.cols; i++) {
      this.grid[i] = [];
      for (var j = 0; j < this.rows; j++) {
        this.grid[i][j] = grids[this.c_start + i][this.r_start + j];
      }
    }
  }

  this.updateGrid();

  this.display = function() {
    noFill();
    stroke(255);
    strokeWeight(3);
    rect(this.c_start * scl,
         this.r_start * scl,
         (this.c_end + 1 - this.c_start) * scl,
         (this.r_end + 1 - this.r_start) * scl);
    noStroke();
    fill(255, 200 * (1 - this.timer.liner()));
    push();1
    translate((this.c_start + this.xpos + 0.5) * scl,
              (this.r_start + this.ypos + 0.5) * scl);
    ellipse(0, 0, scl / 1.33, scl / 1.33);
    pop();

  }
  this.getValue = function() {
    return this.grid[this.xpos][this.ypos];
  }

}
