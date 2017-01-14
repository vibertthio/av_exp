int cols;
int rows;
float scl = 15;
float inc_x = 0.09;
float inc_y = 0.09;
float inc_z = 0.01;
int angleVar = 3;
float magOfForce = 0.35;
float zoff = 0;

ArrayList<Particle> particles;
int maxNOfP = 4096;
PVector[] flowField;
float[] noiseField;
int nOfP = 3000;


void setup() {
  size(1920, 1080);
  // blendMode(ADD);
  background(0);
  cols = floor(width / scl);
  rows = floor(height / scl);
  flowField = new PVector[ rows * cols ];
  noiseField = new float[ rows * cols ];
  particles = new ArrayList<Particle>();
  for (int i = 0; i < nOfP; i++) {
    particles.add( new Particle() );
  }
}


void draw() {
  // fill(0, 5);
  // rect(0, 0, width, height);

  float yoff = 0;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      xoff += inc_x;
      float r = noise(xoff, yoff, zoff) * 2 * PI * angleVar;
      PVector v = PVector.fromAngle(r).setMag(magOfForce);
      int index = x + y * cols;
      flowField[index] = v;
      noiseField[index] = noise(xoff, yoff, zoff);
    }
    yoff += inc_y;
  }
  zoff += inc_z;

  // println(particles.size());
  for (int i = 0; i < particles.size(); i++) {
    particles.get(i).edges();
    particles.get(i).follow(flowField);
    particles.get(i).display();
    particles.get(i).update();
  }

}

void mouseDragged() {

  for(int i = 0; i < maxNOfP / 400; i++) {
    particles.add( new Particle(mouseX, mouseY) );
    if (particles.size() > maxNOfP) {
      particles.remove(0);
    }
  }
}





////////////////
// int cols;
// int rows;
// float scl = 20;
// float inc_x = 0.09;
// float inc_y = 0.09;
// float inc_z = 0.005;
// int angleVar = 2;
// float magOfForce = 0.5;
// float zoff = 0;
//
// // Particle[] particles;
// ArrayList<Particle> particles;
// PVector[] flowField;
// int nOfP = 0;
//
//
// void setup() {
//   size(1000, 800);
//   background(255);
//   cols = floor(width / scl);
//   rows = floor(height / scl);
//   flowField = new PVector[ rows * cols ];
//   // particles = new Particle[nOfP];
//   particles = new ArrayList<Particle>();
//   for (int i = 0; i < nOfP; i++) {
//     // particles[i] = new Particle();
//     particles.add( new Particle() );
//   }
// }
//
//
// void draw() {
//   background(255);
//   float yoff = 0;
//   for (int y = 0; y < rows; y++) {
//     float xoff = 0;
//     for (int x = 0; x < cols; x++) {
//       xoff += inc_x;
//       float r = noise(xoff, yoff, zoff) * 2 * PI * angleVar;
//       PVector v = PVector.fromAngle(r).setMag(magOfForce);
//       int index = x + y * cols;
//       flowField[index] = v;
//       pushMatrix();
//       stroke(0, 50);
//       translate( x * scl, y * scl);
//       rotate(v.heading());
//       line(0, 0, scl, 0);
//       popMatrix();
//     }
//     yoff += inc_y;
//   }
//   zoff += inc_z;
//
//   // for (int i = 0; i < particles.length; i++) {
//   //   particles[i].edges();
//   //   particles[i].follow(flowField);
//   //   particles[i].display();
//   //   particles[i].update();
//   // }
//
// }
//
// void mouseDragged() {
//   particles.add( new Particle(mouseX, mouseY) );
// }
