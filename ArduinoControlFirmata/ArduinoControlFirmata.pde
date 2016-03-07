import cc.arduino.*;
import org.firmata.*;
import processing.serial.*;

Arduino arduino;

//control for arduino setup 
//Button button;
import processing.serial.*;

int[] offVal = {0,0,0,0,0,0,0,0,0} ; 
int[] masterVal =  {0,0,0,0,0,0,0,0,0} ;
int[] ardyPin = {4,5,6,7,8,9,10,11,12};

int onTime = 10 ;
int offTime = 10 ;  

boolean on_called = false;  

int state = 0;
long lastSend;
long curTime; 
int widthGrid = 3;  
int heightGrid = 3;
Button[] button = new Button[widthGrid*heightGrid]; 

boolean[] clicked = new boolean[widthGrid*heightGrid]; 

void setup() {
  size(600, 600);

  //button[0] = new Button(10,10,150,150,"Button 1");
  //button[1] = new Button(200,200,150,150,"Button 2");
  for (int x=0; x< widthGrid; x++) {
    for (int y=0; y < heightGrid; y++) {
      int pos = widthGrid*y + x; 
      button[pos] = new Button(10 + x*(160), 10+ y*(160), 150, 150, str(pos));
      button[pos].render(false, false);
    }
  }

  String portName = "/dev/cu.usbserial-AL00U150";
  printArray(Serial.list());
  try {
    arduino = new Arduino(this, portName, 57600);
  }
  catch(Exception e) {
    print("Exception: ");
    e.printStackTrace();
  }
  lastSend = 0;
  curTime = millis() ; 
  //state = 0;
  //button.render() ;
}

void draw() {

  //println(off_called, on_called) ;
  background(255);

  //Read Buttons
  for (int i=0; i<button.length; i++) {
    button[i].render(button[i].checkMouse(), clicked[i]);
  }
  //println("STATE:" + state);
  switch(state) {
  case 0:
    //println("OFF");
    if (millis() - lastSend > offTime) {
      // Turn ON
      writeVal(masterVal);      

      lastSend = millis();
      print("Send: ");
      println(masterVal);

      state = 1;
      delay(1);
    }
    break;
  case 1:
    //println("ON");
    if (millis() - lastSend > onTime) {
      // turn OFF
      writeVal(offVal) ;


      lastSend = millis();
      println("Turn OFF");

      state = 0;
    }
    break;
  default:
    println("ERROR SHOULDN'T PRINT");
  }
}


void delayDean(int delay) {
  long timeCur = millis()  ;
  while (millis() - timeCur < delay) {
  }
}

void writeVal(int[] valArray){
  for (int i=0; i<valArray.length; i++){
    if (valArray[i] == 1){
      arduino.digitalWrite(ardyPin[i],Arduino.HIGH);
    }else if (valArray[i] == 0){
      arduino.digitalWrite(ardyPin[i],Arduino.LOW);
    }
  }
}

void mouseClicked() {

  for (int i=0; i<button.length; i++) {
    //button[i].render(button[i].checkMouse(),clicked[i]);
    if (button[i].checkMouse()) { 
      clicked[i] = ! clicked[i];
      button[i].render(true, clicked[i]);
      if (masterVal[i] == 1){
        masterVal[i] = 0;
      }else if (masterVal[i] == 0){
        masterVal[i] = 1; 
      }
    }
  }
}