var scl = 25;1
var grids = [];
var cols;
var rows;

var touched = false;
var c_pressed;
var r_pressed;
var c_dragged;
var r_dragged;

var metro;
var bpm = 180;
var beat;

var pressedIndex = -1;
var numberOfSquares = 4;
var squares = [];

//sound
var osc = new soundEngine();

function setup() {
  var canvas = createCanvas(windowWidth, windowWidth);
  background(80);
  canvas.parent('sketch-holder');

  cols = floor(width / scl);
  rows = floor(height / scl);
  console.log(cols);
  console.log(rows);

  metro = new Metro(true, bpm2limit(bpm));
  beat = metro.frameCount();
  init();
  drawFrame()
  display();
}

function draw() {
  background(80);
  display();

  var next = false;
  if (metro.frameCount() > beat) {
    beat = beat + 1;
    next = true;
    // update()1;
    console.log("beat:" + str(beat));


  }

  for (var i = 0; i < numberOfSquares; i++) {
    if (touched && pressedIndex == i) {
      drawFrame();
    }
    else {
      if (next) {
        squares[i].update();
      }
      squares[i].display();
    }
  }

  if (next) {
    var midi1 = map(squares[0].getValue(), 0, 255, 55, 80);
    var amp1 = map(squares[1].getValue(), 0, 255, 0.3, 1);

    if (pressedIndex != 0 && pressedIndex != 1) {
      osc.trigger(midi1, amp1);
    }

    var midi2 = map(squares[2].getValue(), 0, 255, 55, 80);
    var amp2 = map(squares[3].getValue(), 0, 255, 0.3, 1);

    if (pressedIndex != 2 && pressedIndex != 3) {
      osc.trigger(midi1, amp1);
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
