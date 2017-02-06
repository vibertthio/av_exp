class Tab {
  float alpha;
  boolean mouseOver = false;
  boolean active = false;
  int pos;
  Map map;
  PGraphics canvas;
  color col;

  float padding = scl * 0.125;
  float w = scl * 0.75;
  float h = scl * 0.33;

  Tab(Map _m, int _p, color _c) {
    map = _m;
    canvas = map.canvas;
    pos = _p;
    col = _c;
  }

  void display() {
    float al = active? 200 : ((mouseOver)?100:50);
    alpha = alpha + 0.2 * (al - alpha);

    canvas.pushMatrix();
    canvas.noStroke();
    canvas.fill(col, alpha);
    canvas.translate(margin + pos * scl, 0);
    canvas.rect(padding, 0, w, h);
    canvas.popMatrix();
  }

  void trigger() {
    active = !active;
  }
  void activate() {
    active = true;
  }
  void deactivate() {
    active = false;
  }

}

class SideTab extends Tab {
  SideTab(Map _m, int _p, color _c) {
    super(_m, _p, _c);
  }
  void display() {
    float al = active? 200 : ((mouseOver)?100:50);
    alpha = alpha + 0.2 * (al - alpha);

    canvas.pushMatrix();
    canvas.noStroke();
    canvas.fill(col, alpha);
    canvas.translate(0, margin + pos * scl);
    canvas.rect(0, padding, h, w);
    canvas.popMatrix();
  }
}
