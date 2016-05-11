/**
 * Started with example: Pixelate by Hernando Barragan.  
 * Edits by Rodrigo Ceballos for the Haptic Jacket project at NYUAD
 * Takes a video file prixelates and converts to greyscale
 * then thresholds the output and bounds it to a shape
 */
 


void setup() {
  size(720, 360); 
  //Set-up scripts
  draw_jacket_setup();
  video_processing_setup();
  //serial_setup();
}

// Display values from video
void draw() {
  process_video();
  updateDraw();
  //updateSerial();
  //readFromSerial();
}