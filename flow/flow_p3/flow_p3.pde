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
//   float yoff = 0;
//   for (int y = 0; y < rows; y++) {
//     float xoff = 0;
//     for (int x = 0; x < cols; x++) {
//       xoff += inc_x;
//       float r = noise(xoff, yoff, zoff) * 2 * PI * angleVar;
//       PVector v = PVector.fromAngle(r).setMag(magOfForce);
//       int index = x + y * cols;
//       flowField[index] = v;
//       // push();
//       // stroke(0, 50);
//       // translate( x * scl, y * scl);
//       // rotate(v.heading());
//       // line(0, 0, scl, 0);
//       // pop();
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
//   println(particles.size());
//   for (int i = 0; i < particles.size(); i++) {
//     particles.get(i).edges();
//     particles.get(i).follow(flowField);
//     particles.get(i).display();
//     particles.get(i).update();
//   }
//
// }
//
// void mouseDragged() {
//   particles.add( new Particle(mouseX, mouseY) );
// }





////////////////
int cols;
int rows;
float scl = 20;
float inc_x = 0.09;
float inc_y = 0.09;
float inc_z = 0.005;
int angleVar = 2;
float magOfForce = 0.5;
float zoff = 0;

// Particle[] particles;
ArrayList<Particle> particles;
PVector[] flowField;
int nOfP = 0;


void setup() {
  size(1000, 800);
  background(255);
  cols = floor(width / scl);
  rows = floor(height / scl);
  flowField = new PVector[ rows * cols ];
  // particles = new Particle[nOfP];
  particles = new ArrayList<Particle>();
  for (int i = 0; i < nOfP; i++) {
    // particles[i] = new Particle();
    particles.add( new Particle() );
  }
}


void draw() {
  background(255);
  float yoff = 0;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      xoff += inc_x;
      float r = noise(xoff, yoff, zoff) * 2 * PI * angleVar;
      PVector v = PVector.fromAngle(r).setMag(magOfForce);
      int index = x + y * cols;
      flowField[index] = v;
      pushMatrix();
      stroke(0, 50);
      translate( x * scl, y * scl);
      rotate(v.heading());
      line(0, 0, scl, 0);
      popMatrix();
    }
    yoff += inc_y;
  }
  zoff += inc_z;

  // for (int i = 0; i < particles.length; i++) {
  //   particles[i].edges();
  //   particles[i].follow(flowField);
  //   particles[i].display();
  //   particles[i].update();
  // }

}

void mouseDragged() {
  particles.add( new Particle(mouseX, mouseY) );
}
