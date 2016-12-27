class ForceField {
  int cols;
  int rows;
  float scl;
  float inc_x = 0.09;
  float inc_y = 0.09;
  float inc_z = 0.005;

  int angleVar = 2;
  float magOfForce = 1;
  float zoff = 0;

  PVector[] flowField;

  ForceField(int _c, int _r, float _scl) {
    cols = _c;
    rows = _r;
    scl = _scl;
    flowField = new PVector[ rows * cols ];
  }

  void update() {
    float yoff = 0;
    for (int y = 0; y < rows; y++) {
      float xoff = 0;
      for (int x = 0; x < cols; x++) {
        xoff += inc_x;
        float r = noise(xoff, yoff, zoff) * 2 * PI * angleVar;
        PVector v = PVector.fromAngle(r).setMag(magOfForce);
        int index = x + y * cols;
        flowField[index] = v;
      }
      yoff += inc_y;
    }
    zoff += inc_z;
  }

  void display() {
    float yoff = 0;
    for (int y = 0; y < rows; y++) {
      float xoff = 0;
      for (int x = 0; x < cols; x++) {
        int index = x + y * cols;
        pushMatrix();
        stroke(0, 50);
        translate( x * scl, y * scl);
        rotate(flowField[index].heading());
        line(0, 0, scl, 0);
        popMatrix();
      }
    }
  }






}
