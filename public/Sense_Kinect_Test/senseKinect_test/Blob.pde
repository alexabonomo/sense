class Blob {
  
  float minx;
  float miny;
  float maxx;
  float maxy;
  ArrayList history = new ArrayList();
  
  
  Blob(float x, float y){
    minx = x;
    miny = y;
    maxx = x;
    maxy = y;
  }
  
  void show() {
    stroke(0);
    fill(255);
    strokeWeight(2);
    rectMode(CORNERS);
    rect(minx, miny, maxx, maxy);
    
    pushStyle();
    PVector d = new PVector((minx + maxx) / 2, (miny + maxy) / 2, 0);
    history.add(0, d);
    popStyle();
    
    for (int p=0; p<history.size (); p++) {
    
      PVector v = (PVector) history.get(p);
      float join = p/history.size() + d.dist(v)/dist;
      if (join < random(1.0)) {
        stroke(0);
        strokeWeight(.1);
        line(d.x, d.y, v.x, v.y);
        println(d.x, d.y, v.x, v.y);
      }
    }
  }
  
  void add(float x, float y){
    
    minx = min(minx,x);
    miny = min(miny,y);
    maxx = min(maxx,x);
    maxy = min(maxy,y);
     
  }
  
  float size() {
    return (maxx-minx)*(maxy-miny);
  }
  
  
  boolean isNear(float x, float y) {
    float cx = minx + maxx / 2; 
    float cy = miny + maxy / 2;
    
    //changed c from d bbecause d is already referenced in code
    float c = distSq(cx, cy, x, y); 
    if (c < distThreshold*distThreshold) {
      return true;
    } else {
      return false;
    }
  }  
}
