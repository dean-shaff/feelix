int numPins = 9;
//int pins[] = {8,7,5,3,2,0,9,10,11}; // correct sequence !
int pins[] = {11,10,9,0,1,2,3,5,8};
char incomingBytes[] = {0,0,0,0,0,0,0,0,0} ; 
char curState[] = {0,0,0,0,0,0,0,0,0};
void setup() {
  for (int i=0; i<numPins; i++){
    pinMode(pins[i],OUTPUT);
  }
  Serial.begin(9600);
}

void loop() {
//  Serial.println(Serial.available());
//  Serial.print("Incoming Bytes: ");
//  for (int i=0; i < numPins-1; i++){
//    Serial.print(incomingBytes[i],DEC);
//  }
//  Serial.println(incomingBytes[8],DEC);
  if (Serial.available() > 0){
    Serial.readBytesUntil(10,incomingBytes,9);
    Serial.print("I received: ");
    for (int i=0; i < numPins-1; i++){
      Serial.print(incomingBytes[i],DEC);
    }
    Serial.println(incomingBytes[8],DEC);

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
}
