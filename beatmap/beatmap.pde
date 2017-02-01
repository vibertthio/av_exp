//constant
color _bk = color (50, 50, 50);
color _gbk = color (80, 80, 80);
color _blink = color (142, 68, 173);
int scl = 40;
int margin = scl / 2;
int gap = 50;
int nOfc = 6;
int len = nOfc * scl + margin * 2;

ArrayList<Map> maps;

void setup() {
  size(1080, 720);
  background(_bk);
  maps = new ArrayList<Map>();
  for (int i = 0; i < 6; i++) {
    maps.add(new Map( ((1+i%3) * gap + len * (i%3)),
                       (1+i/3) * gap + len * (i/3)));
  }
  // map = new Map(gap, gap);
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
