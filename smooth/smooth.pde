color cb = color(210, 77, 87);
color cc = color(255, 204, 0);
color cs = color(255, 255, 255);
v_smooth smoother;

void setup() {
  size(800, 500);
  background(cb);
  smoother = new v_smooth(400, 250);
}

void draw() {
  // background(cb);
  noStroke();
  fill(cb, 50);
  rect(0, 0, width, height);
  smoother.update();
  // stroke(cs);
  fill(cc);
  ellipse(smoother.getX(), smoother.getY(), 20, 20);
}


void mousePressed() {
  smoother.update(mouseX, mouseY);
}

// void mouseDragged() {
//   smoother.update(mouseX, mouseY);
// }
