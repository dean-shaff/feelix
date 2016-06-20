
//BLE stuff from RedBearLab

#include <SPI.h>
//#include <Nordic_nRF8001.h>
#include <RBL_nRF8001.h>
#include <EEPROM.h>
//#include <RBL_services.h>

#include <Wire.h>


int numPins = 9;
//int pins[] = {8,7,5,3,2,0,9,10,11}; // correct sequence !
//int pins[] = {11,10,9,0,1,2,3,5,8};
int pins[] = {13,10,9,0,1,2,3,5,8};
char incomingBytes[] = {0,0,0,0,0,0,0,0,0} ; 
char curState[] = {0,0,0,0,0,0,0,0,0};
void setup() {

  ble_set_name("Feelix Controller");
  ble_begin() ; 
  
  for (int i=0; i<numPins; i++){
    pinMode(pins[i],OUTPUT);
  }
  Serial.begin(9600);
  Serial.println("Serial monitoring begun");
}

void loop() {
  if (!ble_connected()){
//    Serial.println("BLE not connected");
  }
  while (ble_available()){
    byte cmd;
    cmd = ble_read();
    Serial.write(cmd) ; 
//    Serial.readBytesUntil(10,incomingBytes,9);
//    Serial.print("I received: ");
//    for (int i=0; i < numPins-1; i++){
//      Serial.print(incomingBytes[i],DEC);
//    }
//    Serial.println(incomingBytes[8],DEC);

  }
  for (int i = 0; i<numPins;i++){
    if (incomingBytes[i] != curState[i]){
      curState[i] = incomingBytes[i]; 
      if (curState[i] == 49){
        digitalWrite(pins[i],HIGH);
      }else if (curState[i] == 48){
        digitalWrite(pins[i],LOW);
      }
    }
  }
  ble_do_events();
}
