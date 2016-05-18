/**
 * This sketch connects to the serial port specified and 
 * sends 48 bit packets (split as 6 bytes) that contain the
 * ON/OFF bit matrix to control the jacket. 
 */

import processing.serial.*;


Serial ser;         // The serial port:
int inByte = -1;    // Incoming serial data

//Actuator Update
long lastUpdate = 0, t= 0;
int updateRate = 100; // in milliseconds

void serial_setup() {
  //Params
  int baud = 56700;
  int port = 15;
  
  // List all the available serial ports:
  printArray(Serial.list());
  
  //Connect to <port> and <baud> 
  String portName = Serial.list()[port];
  println("Connecting to port: "+ portName);
  ser = new Serial(this, portName, baud);
  println("Connection establiashed at baud:"+ nf(baud));

}

void serialEvent(Serial myPort) {
  inByte = myPort.read();
}

void sendPacket(int duration, int actuator){
  String s = '#'+nf(actuator)+' '+nf(duration)+'$';
  print(s);
  ser.write(s);
  ser.read();
}

byte fromBits(boolean[] bits) {
  int b = 0;
  for (int i = 0; i < 8; i++) {
    b = b << 1;
    if (bits[i]) {
      b |= 1;
    }
  }
  return byte(b);
}

//UpdateAllVotes
void sendActuators(Actuator[] actuators){ 
  //Get list of bytes in bit form
  String[] list = updateActuators(actuators);
  
  //Write bytes to serial
  for(int i = 0; i < 6; i++){
    //print(unbinary(list[i]));
    ser.write(unbinary(list[i]));
  }
  
  //Wait for acknowledge (read a byte)
  ser.read();
}



//****MAIN*****//
void readFromSerial(){
  while (ser.available() > 0) {
      print(":");
      print(ser.read());
    }
}

void updateSerial(){
  t = millis();
  if (t-lastUpdate > updateRate) {
    sendActuators(actuators);
    lastUpdate = t;
  }
}