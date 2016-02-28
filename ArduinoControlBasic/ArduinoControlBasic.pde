//control for arduino setup 
//Button button;
import processing.serial.*;
Serial myPort ; 
DisposeHandler dh ; 


String masterVal = "0,0,0,0,0,0,0,0,0$\n";
String offVal = "0,0,0,0,0,0,0,0,0$\n";

int onTime = 500 ;
int offTime = 1000 ;  

boolean on_called = false;  
 

int state;
long lastSend;
long curTime; 
int widthGrid = 3;  
int heightGrid = 3;
Button[] button = new Button[widthGrid*heightGrid]; 
 
boolean[] clicked = new boolean[widthGrid*heightGrid]; 

void setup(){
  size(600,600);
  dh = new DisposeHandler(this) ; 
  //button[0] = new Button(10,10,150,150,"Button 1");
  //button[1] = new Button(200,200,150,150,"Button 2");
  for (int x=0; x< widthGrid ; x++){
    for (int y=0; y < heightGrid ; y++){
      int pos = widthGrid*y + x; 
      button[pos] = new Button(10 + x*(160), 10+ y*(160), 150, 150, str(pos));
      button[pos].render(false,false);
    }
  }

  String portName = "/dev/cu.usbserial-AL00U150";
  printArray(Serial.list());
  try{
    myPort = new Serial(this, portName, 9600);
    myPort.bufferUntil('\n');
  }catch(Exception e){
    print("Exception: ");
    e.printStackTrace();
  }
  lastSend = 0;
  curTime = millis() ; 
  state = 0;
  //button.render() ;
}

void draw(){
  
  //println(off_called, on_called) ;
  background(255);
  
  //Read Buttons
  for (int i=0; i<button.length; i++){
    button[i].render(button[i].checkMouse(), clicked[i]);
  }
  
  switch(state){
    
    //Actuators are OFF
    case 0:
    if (millis() - lastSend > offTime){
       // Turn ON
       myPort.write(masterVal) ;
       //Now ON
       state = 1;
       lastSend = millis();
       println(masterVal);
    }
      
    case 1:
    if (millis() - lastSend > onTime){
      // turn OFF
      myPort.write(offVal);
      state = 0;
      lastSend = millis();
      print("OFF");
    }
  }
}


void delayDean(int delay){
  long timeCur = millis()  ;
  while (millis() - timeCur < delay){   
  }
}


void serialEvent(Serial myPort) {
  String val = myPort.readString() ;
  print("Value from Arduino: ");
  println(val); 
  //if (! val.equals(masterVal)) {
  //  masterVal = val ; 
  //  print("Value from Arduino: ");
  //  println(val); 
  //}else{
  //}
}


void mouseClicked(){
  
  for (int i=0; i<button.length; i++){
    //button[i].render(button[i].checkMouse(),clicked[i]);
    if (button[i].checkMouse()){ 
      clicked[i] = ! clicked[i];
      button[i].render(true,clicked[i]);
    }
    
  }
  masterVal = "";
  try{
    for (int i=0; i<button.length-1; i++){
      if (clicked[i]){
        masterVal += "1,";
      }else if (! clicked[i]){
        masterVal += "0,";
      }
    }
    if (clicked[8]){
      masterVal += "1";
    }else if (! clicked[8]){
      masterVal += "0";
    }
    masterVal += "$\n";
    curTime = millis() ; 
    
  }catch(Exception e){
    //print("Exception: ");
    //e.printStackTrace();
  }
}