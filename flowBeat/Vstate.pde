class Vstate {
  int high_time;
  int low_time;
  int high_low_wait;
  int low_high_wait;

  int high_hold = 50;
  int low_hold  = 50;

  boolean state;
  boolean gate;

  boolean HIGH = true;
  boolean LOW  = false;

  Vstate (int _high_low_wait, int _low_high_wait) {
    high_time = millis() + _high_low_wait; //plus wait time to make it changable at the start
    low_time = millis() + _low_high_wait;
    high_low_wait = _high_low_wait;
    low_high_wait = _low_high_wait;
    state = LOW;
    gate = false;
  }

  Vstate (boolean _state, int _high_low_wait, int _low_high_wait) {
    if (!_state) {
      high_time = millis() + _high_low_wait; //plus wait time to make it changable at the start
      low_time = millis();
    }
    else {
      high_time = millis();
      low_time = millis() + _low_high_wait;
    }

    high_low_wait = _high_low_wait;
    low_high_wait = _low_high_wait;
    state = _state;
    gate = false;
  }

  void set( boolean signal ) {
    if ( signal ) { setHigh(); }
    else { setLow(); }
  }

  void setHigh() {
    if ( state == LOW ) {
      if ( millis() > low_time + low_high_wait ) {
        state = HIGH;
        gate = true;
        high_time = millis();
      }
    }
  }

  void setLow() {
    if ( state == HIGH ) {
      if ( millis() > high_time + high_low_wait ) {
        state = LOW;
        gate = true;
        low_time = millis();
      }
    }
  }

  boolean getGate() {
    boolean ret = gate;
    gate = false;
    return ret;
  }

  boolean getHoldGate() {
    if (state) {
      if ( millis() > high_time + high_hold ) {
        boolean ret = gate;
        gate = false;
        return ret;
      }
      else {
        return false;
      }
    }
    else {
      if ( millis() > low_time + low_hold ) {
        boolean ret = gate;
        gate = false;
        return ret;
      }

      else {
        return false;
      }
    }

  }

  boolean getState() {
    return state;
  }

  int highDuration() {
    return ( millis() - high_time );
  }

  int lowDuration() {
    return ( millis() - low_time );
  }
}
