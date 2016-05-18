int numPins = 14;
int pins[] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14} ;
char incomingBytes[] = {0}; 
int pinDesired = 0 ; 


void setup() {
  for (int i=0; i<numPins; i++){
    pinMode(pins[i],OUTPUT);
  }
  Serial.begin(9600);  

}

void loop() {
  if (Serial.available() > 0){
    Serial.readBytesUntil(10,incomingBytes,1) ;
    Serial.print("I received:");
    Serial.println(incomingBytes[0],DEC);
  }
  int pinDesired = incomingBytes[0] - 48; 
  Serial.print("I received:");
  Serial.println(pinDesired);
  for (int i=0; i<numPins; i++){
    if (pinDesired == i){
      digitalWrite(pins[i],HIGH);
    }
  }
  if (pinDesired == 15) {
    for (int i=0; i<numPins; i++){
      digitalWrite(pins[i],LOW); 
    }
  }
}
