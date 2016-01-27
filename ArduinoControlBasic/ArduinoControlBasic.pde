//control for arduino setup 
//Button button;
import processing.serial.*;
Serial myPort ; 
String masterVal = "0,0,0,0,0,0,0,0,0,\n";
int widthGrid = 3;  
int heightGrid = 3;
Button[] button = new Button[widthGrid*heightGrid]; 
 
boolean[] clicked = new boolean[widthGrid*heightGrid]; 

void setup(){
  size(600,600);
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
   
  //button.render() ;
}

void draw(){
  background(255);
  for (int i=0; i<button.length; i++){
    button[i].render(button[i].checkMouse(), clicked[i]);
  }
  String valStr = "";
  try{
    for (int i=0; i<button.length-1; i++){
      if (clicked[i]){
        valStr += "1,";
      }else if (! clicked[i]){
        valStr += "0,";
      }
    }
    if (clicked[8]){
      valStr += "1";
    }else if (! clicked[8]){
      valStr += "0";
    }
    valStr += "$\n";
    //print(valStr);
    myPort.write(valStr);
  }catch(Exception e){
    //print("Exception: ");
    //e.printStackTrace();
  }
  delay(50);
}

void serialEvent(Serial myPort) {
  String val = myPort.readString() ;
  if (! val.equals(masterVal)) {
    masterVal = val ; 
    print("Value from Arduino: ");
    println(val); 
  }else{
  }
}


void mouseClicked(){
  
  for (int i=0; i<button.length; i++){
    //button[i].render(button[i].checkMouse(),clicked[i]);
    if (button[i].checkMouse()){ 
      clicked[i] = ! clicked[i];
      button[i].render(true,clicked[i]);
    }
    
  }  
}