int outPin[9] = {4,5,6,7,8,9,10,11,12};

void setup() {
  for (int i=0; i< 9; i++){
    pinMode(outPin[i],OUTPUT);
  }
//  pinMode(12,OUTPUT);
}

void loop() {
  for (int i=0; i < 9; i++){
    digitalWrite(outPin[i],HIGH);
  }
  delay(1000);
  for (int i=0; i < 9; i++){
    digitalWrite(outPin[i],LOW);
  }
  delay(1000);
//    digitalWrite(12,HIGH);
//    delay(1000);
//    digitalWrite(12,LOW);
//    delay(1000); 
}
