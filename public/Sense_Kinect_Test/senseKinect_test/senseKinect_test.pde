

import org.openkinect.processing.*;



//Kinect Library Object
Kinect2 kinect2;


float minThresh = 480;
float maxThresh = 830;
PImage img;
float dist = 80;
color trackColor;
float threshold = 20;
float distThreshold = 20;


ArrayList<Blob> blobs = new ArrayList<Blob>();




void setup() {
  size(1200, 800);
  
  //Kinect Setup
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();
  img = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);

  
  
  randomSeed(0);
  background(255);
  stroke(255);
  strokeWeight(.1);
  noFill();

}
void draw() {

    img.loadPixels();
    
    //blobs.clear();
    
    int[] depth = kinect2.getRawDepth();
    
    //float sumX = 0;
    //float sumY = 0;
    //float totalPixels = 0;


    for (int x = 0; x < kinect2.depthWidth; x++) {
       for (int y = 0; y < kinect2.depthHeight; y++) {
         int offset = x + y * kinect2.depthWidth; 
         int d = depth[offset];
        
         color currentColor = img.pixels[offset];
         float r1 = red(currentColor);
         float g1 = green(currentColor);
         float b1 = blue(currentColor);
         float r2 = red(trackColor);
         float g2 = green(trackColor);
         float b2 = blue(trackColor);
         
         float c = distSq(r1, g1, b1, r2, g2, b2); 
         
         if (d > minThresh && d < maxThresh && x > 100) {
           img.pixels[offset] = color(255, 0, 0);
           
           //sumX += x;
           //sumY += y;
           //totalPixels ++;
         } else {
           img.pixels[offset] = color(0);
         }

    img.updatePixels();
    //image(img, 0, 0, width, height); //display depth image


    //float avgX = sumX / totalPixels;
    //float avgY = sumY / totalPixels;
    
    //float davgX = map(avgX, 0, 300, 0, 1200);
    //float davgY = map(avgY, 0, 600, 0, 800);
      
      
      if (d < threshold*threshold) {
        
        boolean found = false;
        for (Blob b : blobs) {
          if (b.isNear(x, y)) {
              b.add(x,y);
              found = true;
              break;
            }
          }
        
        if (!found) {
          Blob b = new Blob(x,y);
          blobs.add(b);
        }
      }
    }
  }
  
  for (Blob b : blobs) {
    if (b.size() >100) {
      b.show();
    }
  }
}

float distSq(float x1, float y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return d;
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}

//void keyPressed() {
//  if (key == 'x') {
//    background(255);
//    history.clear();
//  }
//  if (key == 's') {
//    saveFrame( "sense/savedimages/action-######.tiff");
//  }
//  if (key == 'a') {
//    distThreshold++;
//  } else if (key == 'z') {
//    distThreshold--;
//  }
//  println(distThreshold);
//}
