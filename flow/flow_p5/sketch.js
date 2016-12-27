var cols;
var rows;
var scl = 20;
var inc_x = 0.09;
var inc_y = 0.09;
var inc_z = 0.005;
var angleVar = 2;
var fr;
var zoff = 0;

var particles = [];
var flowField = [];
var nOfP = 500;
var magOfForce = 0.5;

function setup() {
  createCanvas(1000, 800);
  cols = floor(width / scl);
  rows = floor(height / scl);
  print("cols:" + cols);
  print("rows:" + rows);
  fr = createP('');
  background(255);
  for (var i = 0; i < nOfP; i++) {
    particles[i] = new Particle();
  }
}


function draw() {
  // background(255);

  var yoff = 0;
  for (var y = 0; y < rows; y++) {
    var xoff = 0;
    for (var x = 0; x < cols; x++) {
      xoff += inc_x;
      var r = noise(xoff, yoff, zoff) * 2 * PI * angleVar;
      var v = p5.Vector.fromAngle(r).setMag(magOfForce);
      var index = x + y * cols;
      flowField[index] = v;
      // push();
      // stroke(0, 50);
      // translate( x * scl, y * scl);
      // rotate(v.heading());
      // line(0, 0, scl, 0);
      // pop();
    }
    yoff += inc_y;
  }
  zoff += inc_z;

  for (var i = 0; i < particles.length; i++) {
    particles[i].show();
    particles[i].follow(flowField);
    particles[i].update();
    particles[i].edges();
  }

  fr.html(floor(frameRate()));
}
