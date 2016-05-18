/**
 * Started with example: Pixelate by Hernando Barragan.  
 * Edits by Rodrigo Ceballos for the Haptic Jacket project at NYUAD
 * Takes a video file prixelates and converts to greyscale
 * then thresholds the output and bounds it to a shape
 */
import processing.serial.*;
Serial arduino ; 
FeelixControl controller ; 
String oldVal = "000000000";
String zeroValStr = "000000000";
int zeroCount = 0 ; 
//int ardyPin[] = {8,7,5,3,2,0,9,10,11};
int ardyPin[] = {11,10,9,0,1,2,3,5,8};
void setup() {
  size(640, 360); 
  //Set-up scripts
  String portName = "/dev/cu.usbmodem1411";
  arduino = new Serial(this, portName, 9600) ;
  draw_jacket_setup();
  video_processing_setup();
  controller = new FeelixControl(arduino,ardyPin);
  println("Controller set up") ;
  //serial_setup();
}

// Display values from video
void draw() {
  process_video();
  updateDraw();
  println(zeroCount) ; 
  String[] list = updateActuators(actuators);
  println(list[0]);
  if (list[0].equals(zeroValStr)){   
    //zeroCount ++ ; 
  }
  if (list[0].equals(oldVal) || list[0].equals(zeroValStr)){
    //zeroCount = 0 ;
  }else{
    zeroCount = 0;
    println(list[0]);
    oldVal = list[0];
    char[] newVal = list[0].toCharArray(); 
    for (int i=0; i<newVal.length; i++){
      int j = (int) newVal[i] - 48; 
      controller.setState(i,j) ; 
    }
  }
  if (zeroCount > 5){
    oldVal = zeroValStr ; 
    char[] newVal = oldVal.toCharArray(); 
    for (int i=0; i<newVal.length; i++){
      int j = (int) newVal[i] - 48; 
      controller.setState(i,j) ; 
    }
    zeroCount = 0 ;
  }
  controller.sendSignal(100,100);



  //updateSerial();
  //readFromSerial();
}