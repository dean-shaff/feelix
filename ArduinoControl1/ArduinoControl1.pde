import cc.arduino.*;
import org.firmata.*;
import processing.serial.*;

FeelixControl controller ; 
Serial arduino; 
UI ui ; 

int mode = 2; 
//int[] ardyPin = {4,5,6,7,8,9,10,11,12};
//int[] ardyPin = {8,7,5,3,2,1,0,10,11} ;
int ardyPin[] = {8,7,5,3,2,0,9,10,11};
//int[] ardyPin = 5,3,2,1,0,
//int[] ardyPin = {3,4,5,6,7,8,9,10,11};

void setup(){
  size(600,700); 
  println("Canvas drawn");
  // setup arduino port 
  //String portName = "/dev/cu.usbserial-AL00U150"; 
  String portName = "/dev/cu.usbmodem1411";
  arduino = new Serial(this, portName, 9600) ;
  //arduino = new Arduino(this, portName, 57600);
  println("Arduino up and running!");
  // setup controller
  controller = new FeelixControl(arduino,ardyPin) ;
  println("Controller setup!");
  // setup UI 
  //for (int i=0; i<ardyPin.length;i++){  
  //  arduino.digitalWrite(ardyPin[i],Arduino.HIGH);
  //  println("Wrote to high!");
  //}
  //delay(3000);
  //for (int i=0; i<ardyPin.length;i++){  
  //  arduino.digitalWrite(ardyPin[i],Arduino.LOW);
  //  println("Wrote to low!");
  //}
  ui = new UI(controller, mode);
  ui.uiSetup();
}

void draw(){
  ui.uiDraw();
}

void mouseClicked(){
  ui.uiMouseClicked(); 
}