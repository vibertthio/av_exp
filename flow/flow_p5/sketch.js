var cols;
var rows;
var scl = 15;
var inc_x = 0.09;
var inc_y = 0.09;
var inc_z = 0.01;
var angleVar = 2;
var fr;
var zoff = 0;

var particles = [];
var flowField = [];
var nOfP = 1024;
var magOfForce = 0.5;
var maxNOfP = 2048;

var s_w = screen.width;
var s_h = screen.height;

var r;
var g;
var b;

function setup() {
  createCanvas(s_w, s_h);
  cols = floor(width / scl);
  rows = floor(height / scl);
  print("cols:" + cols);
  print("rows:" + rows);
  fr = createP('');
  background(0);
  for (var i = 0; i < nOfP; i++) {
    particles[i] = new Particle();
  }
}


function draw() {
  // background(0);

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

  setColor();
  for (var i = 0; i < particles.length; i++) {
    particles[i].show();
    particles[i].follow(flowField);
    particles[i].update();
    particles[i].edges();
  }

  fr.html(floor(frameRate()));
}

function mouseDragged() {
  for(var i = 0; i < maxNOfP / 200; i++) {
    console.log(i);
    particles.splice(0, 0, new Particle(mouseX, mouseY));
    if (particles.length > maxNOfP) {
      particles.pop();
    }
  }
}

function setColor() {
  // console.log("r" + str(r));
  // console.log("g" + str(g));
  // console.log("b" + str(b));
  var rate = 6.5;
  var offset = 3.7;
  var scale = 30;
  r = floor((noise(0, 100, zoff) * rate + offset) * scale);
  g = floor((noise(300, 100, zoff) * rate + offset) * scale);
  b = floor((noise(300, 500, zoff) * rate + offset) * scale);
}
