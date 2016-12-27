Vstate vstate;
int hlw = 3000;
int lhw = 0;
void setup() {
  size(100, 100);
  background(0);
  vstate = new Vstate(true, hlw, lhw);
}


void draw() {
  println("============");
  println("high_low_wait : " + hlw);
  println("low_high_wait : " + lhw);

  println("time : " + String.format("%.2f", float(millis())/1000) + "(sec)");
  if ( vstate.getState() ) {
    background(255);
  }
  else {
    background(0);
  }
}

void keyPressed() {
  if (key == '1') {
    vstate.set(true);
  }
  if (key == '2') {
    vstate.set(false);
  }
}
