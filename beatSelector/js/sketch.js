var scl = 25;1
var grids = [];
var cols;
var rows;

var touched = false;
var c_pressed;
var r_pressed;
var c_dragged;
var r_dragged;

var bpm = 180;

var pressedIndex = -1;
var numberOfSquares = 4;
var squares = [];

//sound
// var osc = new soundEngine();

function setup() {
  var canvas = createCanvas(windowWidth / 3, windowWidth / 3);
  background(80);
  canvas.parent('sketch-holder');

  cols = floor(width / scl);
  rows = floor(height / scl);
  console.log(cols);
  console.log(rows);

  init();
  drawFrame()
  display();

}

function draw() {
  background(80);
  display();

  for (var i = 0; i < numberOfSquares; i++) {
    if (touched && pressedIndex == i) {
      drawFrame();
    }
    else {
      squares[i].display();
    }
  }
}

function init() {
  for (var i = 0; i < cols; i++) {
    grids[i] = [];
    for (var j = 0; j < rows; j++) {
      grids[i][j] = floor(random(255));
    }
  }

  for (var i = 0; i < numberOfSquares; i++) {
    squares[i] = new Square(0, 0, 0, 0, i);
    // squares[i].updateG1rid();
  }
}
function update() {
  for (var i = 0; i < cols; i++) {
    for (var j = 0; j < rows; j++) {
      grids[i][j] = floor(random(255));
    }
  }
}
function updateSquares() {
  for (var i = 0; i < numberOfSquares; i++) {
    squares[i].update();
  }
}
function display() {
  for (var i = 0; i < cols; i++) {
    for (var j = 0; j < rows; j++) {
      noStroke();
      fill(210, 82, 127, grids[i][j]);
      rect(i*scl, j*scl, scl, scl);
    }
  }
}
function drawFrame() {
  noFill();
  stroke(247, 202, 24);
  strokeWeight(3);

  if (mouseX < width && mouseY < height) {
    if (mouseX > c_pressed * scl) {
      c_dragged = floor(mouseX / scl);
    }
    if (mouseY > r_pressed * scl) {
      r_dragged = floor(mouseY / scl);
    }
  }

  rect(c_pressed * scl,
       r_pressed * scl,
       ( c_dragged - c_pressed + 1 ) * scl,
       ( r_dragged - r_pressed + 1 ) * scl );
}
function bpm2limit(b) {
  return floor(60000 / b);
}
function touchStarted() {
  touched = true;
  if (mouseX < width && mouseY < height) {
    c_pressed = floor( mouseX / scl);
    r_pressed = floor( mouseY / scl);
  }
}
function touchEnded() {
  touched = false;
  if (keyPressed) {
    if (pressedIndex > -1 && pressedIndex < numberOfSquares) {
      squares[pressedIndex] = new Square ( c_pressed,
                                           r_pressed,
                                           c_dragged,
                                           r_dragged,
                                           pressedIndex);
      // squares[pressedIndex].updateGrid();
    }
  }
}
function keyPressed() {
  var k = key.charCodeAt(0);
  if ( k >= 49 && k <= 52 ) {
    pressedIndex = k-49;
  }
  else {
    pressedIndex = -1;
  }

  if ( k == 53 ) {
    console.log("trigger");
    test.trigger(80, 1);
  }
}
function keyReleased() {
  var k = key.charCodeAt(0);
  if ( k >= 49 && k <= 52 ) {
    pressedIndex = -1;
  }
}

//sound functions
function midi(sq) {
  var midi = floor(map(sq.getValue(), 0, 255, 55, 80));
  return midi;
}
function amp(sq) {
  var amp = map(sq.getValue(), 0, 255, 0.3, 1);
  return amp;
}
function m2f (midi) {
  return 440 * pow(2, (midi - 69) / 12);
}
