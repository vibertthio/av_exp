import oscP5.*;
import netP5.*;

float scl = 50;
int w_frame = 900;
int h_frame = 900;
Grid grid;
int cols;
int rows;

//force field
ForceField ff;


//oscP5
OscP5 oscP5;
NetAddress other;

ArrayList<Particle> particles;
int nOfP = 4;

//colors
color cg = color(210, 82, 127);
color cf = color(247, 202, 24);
color ck = color(68, 108, 179);
void setup() {
  frameRate(100);
  size(900, 900);
  cols = int(w_frame / scl);
  rows = int(h_frame / scl);
  grid = new Grid( cols, rows, scl);
  ff = new ForceField( cols, rows, scl);
  particles = new ArrayList<Particle>();

  //oscP5
  oscP5 = new OscP5(this, 12000);
  other = new NetAddress("127.0.0.1", 12002);
}

void draw() {
  background(255);
  grid.display();
  ff.update();

  for( int i = 0, n = particles.size(); i < n; i++) {
    Particle p = particles.get(i);
    p.edges();
    p.follow(ff.flowField);
    p.display();
    p.update();
    if(p.updatePosInGrid()) {
      if ( grid.blink(p.row, p.col) ) {
        p.sendOSC();
      }
    }
  }
}

void mouseClicked() {
  grid.update();
}
void keyPressed() {
  if ( key == 'n' && particles.size() < nOfP) {
    particles.add( new Particle(mouseX, mouseY, particles.size()) );
  }
  if ( key == 'r' ) {
    for ( int i = 0, n = particles.size(); i < n; i++) {
      particles.remove(0);
    }
  }
}
void startOSC() {
  OscMessage msg = new OscMessage("/start");
  oscP5.send(msg, other);
}
void endOSC() {
  OscMessage msg = new OscMessage("/end");
  oscP5.send(msg, other);
}
