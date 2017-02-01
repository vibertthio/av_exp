//oscP5
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress other;

//constant
color _bk = color (50, 50, 50);
color _gbk = color (80, 80, 80);
color _blink = color (142, 68, 173);
color _normal = color (255, 255, 255);
color _active = color (82, 179, 217);

//state
boolean activating = false;

int scl = 40;
int margin = scl / 2;
int gap = 50;
int nOfc = 6;
int len = nOfc * scl + margin * 2;

int[] otDefault= {
  0, 0, 0, 0, 0, 1,
  1, 2, 2, 2, 2, 2,
  0, 0, 0, 0, 0, 1,
  1, 2, 2, 2, 2, 2,
  0, 0, 0, 0, 0, 1,
  1, 2, 2, 2, 2, 2,
};

ArrayList<Map> maps;

void setup() {
  size(1080, 720);
  background(_bk);
  maps = new ArrayList<Map>();
  for (int i = 0; i < 6; i++) {
    maps.add(new Map( i,
                      ((1+i%3) * gap + len * (i%3)),
                      (1+i/3) * gap + len * (i/3)));
  }

  //oscP5
  oscP5 = new OscP5(this, 12000);
  other = new NetAddress("127.0.0.1", 12002);
}

void draw() {
  background(_bk);

  for (int i = 0, n = maps.size(); i < n; i++) {
    Map map = maps.get(i);
    map.mouseSensed(mouseX, mouseY);
    map.update();
    map.display();
  }
}

void mousePressed() {
  for (int i = 0, n = maps.size(); i < n; i++) {
    Map map = maps.get(i);
    map.mousePressed();
  }
}
void keyPressed() {
  if (key == 't') {
    activating = true;
  }
}
void keyReleased() {
  if (key == 't') {
    activating = false;
  }
}
