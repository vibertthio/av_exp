//Constants
int numberOfRedPoints = 16;
int maxNumberOfPoints = 1000;
int radiusOfWhitePoints = 1;
int radiusOfRedPoints = 3;
int radiusOfYellowPoints = 2;

//Variables
int[][] points;
int numberOfPoints;
boolean drawing = false;

void setup() {
  frameRate(40);
  size(800, 800);
  points = new int[maxNumberOfPoints][2];
  numberOfPoints = 0;
}

void draw() {
  background(0);
  //recording and drawing
  if ( drawing ) {
    addPoint();
    display();
  }
  //looping
  else {
    display();
  }
}


/*
START DRAWING*/
void mousePressed() {
  drawing = true;
  clearPoints();
}

/*
END DRAWING*/
void mouseReleased() {
  drawing = false;
}

//Other Function
void addPoint() {
  if ( numberOfPoints < maxNumberOfPoints ) {
    points[numberOfPoints][0] = mouseX;
    points[numberOfPoints][1] = mouseY;
    numberOfPoints++;
  }
}
void clearPoints() {
  numberOfPoints = 0;
}
void display() {
  for (int i = 0, n = numberOfPoints; i < n; i++) {
    noStroke();
    fill(255);
    ellipse(points[i][0], points[i][1],
            2 * radiusOfWhitePoints, 2 * radiusOfWhitePoints);
  }

  if ( !drawing ) {
    float k = 1.0 / numberOfRedPoints;
    for (int i = 0, n = numberOfRedPoints; i < n; i++) {
      int index = floor( lerp(0, numberOfPoints, i * k) );
      noStroke();
      fill(255, 0, 0);
      ellipse(points[index][0], points[index][1],
              2 * radiusOfRedPoints, 2 * radiusOfRedPoints);
    }
  }
}
