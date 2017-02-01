//constant
color _bk = color (50, 50, 50);
color _gbk = color (80, 80, 80);
int scl = 20;
Map map;

void setup() {
  size(500, 500);
  background(_bk);
  map = new Map(50, 50);
}

void draw() {
  background(_bk);
  map.update();
  map.display();
}

void mousePressed() {
  map.mousePressed(mouseX, mouseY);
}
