import processing.video.*;

int numPixelsWide, numPixelsHigh;
int blockSize = 3;
int pixel_voting_radius = 15; //in pixels

color movColors[];
color c;
String s;
float lumi;
//int threshold[] = {15, 85, 130, 245};
int vote_threshold = 230;
int norm_factor = 50;

int[] pixelMapping;
PVector pixel_pos;

int pixel_count = 0;
boolean seeRed = false;

Capture video;

//SETUP
void video_processing_setup() {
  //Establish pixelated size
  numPixelsWide = width / blockSize;
  numPixelsHigh = height / blockSize;
  //println(numPixelsWide);
  //println(numPixelsHigh);
  
  //Initialize color and pixel mapping arrays
  movColors = new color[numPixelsWide * numPixelsHigh]; 
  pixelMapping = new int[numPixelsWide * numPixelsHigh];

  //Generate Pixel Mapping to Actuators
  for (int j = 0; j < numPixelsHigh; j++) {
    for (int i = 0; i < numPixelsWide; i++) {
      pixelMapping[pixel_count] = findActuator(new PVector(i*blockSize, j*blockSize), actuators);
      pixel_count++;
    }
  }

  // This the default video input
  video = new Capture(this, width, height);

  // Start capturing the images from the camera
  video.start();
}

// Finds closest actuator to current pixel;
int findActuator(PVector pixelPos, Actuator[] actuators) {
  int closest = 0;
  float new_dist;
  float min_dist = pixelPos.dist(actuators[0].getMid());
  for (int i = 1; i < actuators.length; i++) {
    new_dist = pixelPos.dist(actuators[i].getMid());
    //print(new_dist);
    //print("=");
    if (new_dist < min_dist) {
      closest = i;
      min_dist = new_dist;
    }
  }
  if (min_dist < pixel_voting_radius) return closest; //Return closest actuator within pixel_voting_radius
  else return -1;                             //If no such closest actuator, return -1.
}



void process_pixel(int i, int j, int count) {
  //Get RGB color in hex string
  PVector pixel_pos = new PVector(i*blockSize,j*blockSize);
  
    c = video.get(i*blockSize, j*blockSize); 

    //Calulcate red from each color
    float redProp = 255*red(c)/(green(c)+blue(c)+norm_factor);       

    //Pixel votes on whether closest actuator should be on or off 
    //depending on luminance, if no closest actuator, don't vote.
    if (pixelMapping[count] != -1) {
      if(redProp > vote_threshold){
        actuators[pixelMapping[count]].vote(50);
      }
      else actuators[pixelMapping[count]].vote(0);
    }  
    
    if(seeRed){
      movColors[count] = color(redProp,redProp,redProp);
    }
    else{
      movColors[count] = c;
    }
 
  count++;
}


//****MAIN*****//
void process_video(){
  if (video.available()) {
    video.read();
    video.loadPixels();
    int count = 0;
    //println(pixelMapping);
    //Process each pixel
    for (int j = 0; j < numPixelsHigh; j++) {
      for (int i = 0; i < numPixelsWide; i++) {
        process_pixel(i,j,count);
        count++;
      }
    }
  }
}