import oscP5.*;
import netP5.*;

//Constants
int numberOfRedPoints = 16;
int maxNumberOfPoints = 1000;
int radiusOfWhitePoints = 1;
int radiusOfRedPoints = 3;
int radiusOfYellowPoints = 5;

//Variables
int[][] points;
int[] redPoints;
int numberOfPoints;
int currentPosition;
int nextPosition;

boolean drawing = false;
boolean moving = false;

TimeLine moveTimer;
TimeLine stopTimer;

//oscP5
OscP5 oscP5;
NetAddress other;

void setup() {
  frameRate(100);
  size(800, 800);
  points = new int[maxNumberOfPoints][2];
  redPoints = new int[numberOfRedPoints];
  numberOfPoints = 0;

  moveTimer = new TimeLine(300);
  stopTimer = new TimeLine(50);

  //oscP5
  oscP5 = new OscP5(this, 12000);
  other = new NetAddress("127.0.0.1", 12001);
}
void draw() {
  background(0);
  debug();
  if ( drawing ) {
    addPoint();
    display();
  }
  else {
    display();
    displayMovingPoint();
  }
}
void exit(){
  endOSC();
  super.exit();//let processing carry with it's regular exit routine
}

/*
START DRAWING*/
void mousePressed() {
  drawing = true;
  clearPoints();
  endOSC();
}
/*
END DRAWING*/
void mouseReleased() {
  drawing = false;
  currentPosition = 0;
  nextPosition = 1;
  updateRedPoints();
  moving = true;
  moveTimer.startTimer();
  startOSC();
}

//Other Function
void addPoint() {
  if ( numberOfPoints < maxNumberOfPoints ) {
    points[numberOfPoints][0] = mouseX;
    points[numberOfPoints][1] = mouseY;
    numberOfPoints++;
  }
}
void updateRedPoints() {
  float k = 1.0 / numberOfRedPoints;
  for (int i = 0; i < numberOfRedPoints; i++) {
    redPoints[i] = floor( lerp(0, numberOfPoints, i * k) );
  }
}
void clearPoints() {
  numberOfPoints = 0;
}
void display() {
  for (int i = 0; i < numberOfPoints; i++) {
    noStroke();
    fill(255);
    ellipse(points[i][0], points[i][1],
            2 * radiusOfWhitePoints, 2 * radiusOfWhitePoints);
  }

  if ( !drawing ) {
    for (int i = 0; i < numberOfRedPoints; i++) {
      noStroke();
      fill(255, 0, 0);
      ellipse(points[redPoints[i]][0],
              points[redPoints[i]][1],
              2 * radiusOfRedPoints,
              2 * radiusOfRedPoints);
    }


  }
}
void displayMovingPoint() {
  float x = points[redPoints[nextPosition]][0];
  float y = points[redPoints[nextPosition]][1];

  if ( moving ) {
    if ( moveTimer.liner() < 1 ) {
      x = lerp ( points[redPoints[currentPosition]][0],
                       points[redPoints[nextPosition]][0],
                       moveTimer.liner() );
      y = lerp ( points[redPoints[currentPosition]][1],
                       points[redPoints[nextPosition]][1],
                       moveTimer.liner() );
    }
    else {
      println("send signal!");
      sendOSC();
      stopTimer.startTimer();
      moving = false;
    }
  }
  else {
    if ( stopTimer.liner() == 1 ) {
      positionUpdate();
      moving = true;
      moveTimer.startTimer();
    }
  }

  noStroke();
  fill(255, 255, 0);
  ellipse(x, y,
         2 * radiusOfYellowPoints, 2 * radiusOfYellowPoints);
}

void positionUpdate() {
  currentPosition = ( currentPosition + 1 ) % numberOfRedPoints;
  nextPosition = ( currentPosition + 1 ) % numberOfRedPoints;
}
void sendOSC() {
  OscMessage msg = new OscMessage("/point");
  float x = map( points[redPoints[nextPosition]][0],
                 0, width, 0, 1);
  float y = map( points[redPoints[nextPosition]][1],
                 height, 0, 0, 1); //from low to high
  msg.add( x );
  msg.add( y );
  oscP5.send(msg, other);
}
void startOSC() {
  OscMessage msg = new OscMessage("/start");
  oscP5.send(msg, other);
}
void endOSC() {
  OscMessage msg = new OscMessage("/end");
  oscP5.send(msg, other);
}

void debug() {
  // println("moveTimer: state=" + str(moveTimer.state) + " liner=" + str(moveTimer.liner()));
  // println("stopTimer: state=" + str(stopTimer.state) + " liner=" + str(stopTimer.liner()));
  // println("currentPosition : " + str(currentPosition));
  // println("frameRate : " + str(frameRate));

  // println("red points index :");
  // printArray(redPoints);


}
