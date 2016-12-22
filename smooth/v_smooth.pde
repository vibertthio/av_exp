class v_smooth {
  float x;
  float y;
  float z;
  float x_end;
  float y_end;
  float z_end;
  float accel;

  v_smooth(float _x, float _y, float _a) {
    x = _x;
    y = _y;
    x_end = _x;
    y_end = _y;
    accel = _a;
  }

  v_smooth(float _x, float _y) {
    x = _x;
    y = _y;
    x_end = _x;
    y_end = _y;
    accel = 0.1;
  }

  void update() {
    x = x + accel * ( x_end - x ) ;
    y = y + accel * ( y_end - y ) ;
    z = z + accel * ( z_end - z ) ;
  }

  void update(float _x, float _y) {
    x_end = _x;
    y_end = _y;
  }

  void update(float _x, float _y, float _z) {
    x_end = _x;
    y_end = _y;
    z_end = _z;
  }

  float getX() { return x; }
  float getY() { return y; }
  float getZ() { return z; }

  void setAccel(float _a) {
    accel = _a;
  }


}
