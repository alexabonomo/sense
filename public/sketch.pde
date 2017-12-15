ArrayList history = new ArrayList();
float dist = 80;
float accelx;
float accelx;

void setup() {
  size(2000, 2000);
  randomSeed(0);
  background(255);
  stroke(0, 150);
  strokeWeight(.1);
  noFill();
}
void draw() {


PVector d = new PVector(accelx, accely, 0);
history.add(0, d);

for (int p=0; p<history.size (); p++) {
  PVector v = (PVector) history.get(p);
  float join = p/history.size() + d.dist(v)/dist;
  if (join < random(0.9) && mouseButton == LEFT) {

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
