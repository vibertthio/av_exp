//oscP5
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress other;

//midi output
import themidibus.*;
MidiBus midi;

//slider
import controlP5.*;
ControlP5 cp5;

//constant
color _bk = color (50, 50, 50);
color _gbk = color (80, 80, 80);
color _blink = color (142, 68, 173);
color _normal = color (255, 255, 255);
color _active = color (82, 179, 217);

final int TIMES = 0;
final int VELOCITY = 1;
final int PITCH = 2;
final int OCTAVE = 3;
final int ROTATE = 0;
final int RANDOM = 1;


color[] _colorOfTabs = {
  color (27, 163, 156),
  color (246, 36, 89),
  color (249, 191, 59),
};
color[] _colorOfStabs = {
  color (211, 84, 0),
  color (137, 196, 244),
  color (236,100,75),
};

//state
boolean activating = false;

int scl = 40;
int margin = scl / 2;
int gap = 50;
int nOfc = 4;
int len = nOfc * scl + margin * 2;

// int[] otDefault = {
//   0, 0, 0, 0, 0, 1,
//   1, 2, 2, 2, 2, 2,
//   0, 0, 0, 0, 0, 1,
//   1, 2, 2, 2, 2, 2,
//   0, 0, 0, 0, 0, 1,
//   1, 2, 2, 2, 2, 2,
// };
int[] otDefault = {
  0, 0, 0, 1,
  1, 2, 2, 2,
  0, 0, 0, 1,
  1, 2, 2, 2,
};
int[] midiNotes = {
  36,
  38,
  44,
  39,
  45,
  49,
};
int[] channels = {
  1,
  1,
  1,
  2,
  2,
  3,
};

ArrayList<Map> maps;

void setup() {
  // size(1080, 720);
  size(800, 550);
  background(_bk);

  //oscP5
  oscP5 = new OscP5(this, 12000);
  other = new NetAddress("127.0.0.1", 12002);

  //midi
  MidiBus.list();
  midi = new MidiBus(this, "Virtual MIDI Port", "p5 Port");
  // midi = new MidiBus(this, 0, 2);

  //controlP5
  cp5 = new ControlP5(this);

  //maps
  maps = new ArrayList<Map>();
  for (int i = 0; i < 6; i++) {
    maps.add(new Map( i,
                      ((1+i%3) * gap + len * (i%3)),
                      (1+i/3) * gap + len * (i/3)));
  }
}
void draw() {
  background(_bk);

  for (int i = 0, n = maps.size(); i < n; i++) {
    Map map = maps.get(i);
    map.mouseSensed(mouseX, mouseY);
    map.update();
    map.display();
  }

  showfr();
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

int beat = 0;
void rawMidi(byte[] data) { // You can also use rawMidi(byte[] data, String bus_name)
  // println("clock(" + (int)(data[0] & 0xFF) + ")");
  if ((int)(data[0] & 0xFF) == 248) {
    if (beat % 24 == 0) {
      for (int i = 0; i < 6; i++) {
        maps.get(i).toNext();
      }
    }
    else {
      for (int i = 0; i < 6; i++) {
        maps.get(i).sendClock(beat);
      }
    }
    beat = (beat + 1);
  }
}
void showfr() {
  fill(255);
  text( "frameRate: " + str(frameRate),10, 20);
}
