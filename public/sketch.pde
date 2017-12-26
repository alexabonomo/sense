
void updateValues(accelx,accely) {
  console.log("in processing",accelx,accely);
  accelGlobalX = accelx;
  accelGlobalY = accely;

}

ArrayList history = new ArrayList();
float dist = 80;
float accelGlobalX;
float accelGlobalY;



void setup() {
  size(4000,2200);
  randomSeed(0);
  background(255);
  stroke(0);
  strokeWeight(.1);
  noFill();
}
void draw() {



float x = accelGlobalX;
float y = accelGlobalY;

pushStyle();  // Start a new style
strokeWeight(3);
ellipse((x+random(-10,10)),(y+random(-10,10))/2,30,30);
line(y, x, y+100, x);
popStyle();  // Restore original style

pushStyle();
strokeWeight(10);
point(y-100,x);
popStyle();

pushStyle();
strokeWeight(.1);
PVector d = new PVector( x, y, 0);
history.add(0, d);
popStyle();

for (int p=0; p<history.size (); p++) {
  PVector v = (PVector) history.get(p);
  float join = p/history.size() + d.dist(v)/dist;
  if (join < random(4.0)) {

    line(d.x, d.y, v.x, v.y);

    }

  }

}


void keyPressed() {
  if (key == 'x') {
    background(255);
    history.clear();
  }
  if (key == 's') {
    saveFrame( "sense/savedimages/action-######.tiff");
  }
}
