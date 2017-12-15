
void updateValues(accelx,accely) {
  console.log("in processing",accelx,accely);
}


ArrayList history = new ArrayList();
float dist = 80;
float x = accelx;
float y = accely;

void setup() {
  size(1000, 1000);
  randomSeed(0);
  background(255);
  stroke(0, 150);
  strokeWeight(.1);
  noFill();
}
void draw() {

PVector d = new PVector(x, y, 0);
history.add(0, d);

for (int p=0; p<history.size (); p++) {
  PVector v = (PVector) history.get(p);
  float join = p/history.size() + d.dist(v)/dist;
  if (join < random(0.9)) {

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
    saveFrame( "######.tiff");
  }
}
