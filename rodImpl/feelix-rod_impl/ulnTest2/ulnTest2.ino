int numPins = 9 ; 
int outPin[numPins] = {4,5,6,7,8,9,10,11,12};
int vals[numPins] = {0,0,0,0,0,0,0,0,0};
String str ; 

void setup() {
  Serial.begin(9600);
  for (int i=0; i< numPins; i++){
    pinMode(outPin[i],OUTPUT);
  }
  printVals();
  Serial.setTimeout(50);
//  pinMode(12,OUTPUT);
}

void loop() {

  if (Serial.available() > 0) {
    for (int i=0; i < numPins; i++){
      vals[i] = Serial.parseInt(); 
    }
    if (Serial.read() == '$'){
      printVals();
      for (int i=0; i<numPins;i++){
        digitalWrite(outPin[i],vals[i]);
      } 
    }
  }
}

void printVals(){
    for (int i=0; i<numPins; i++){
      Serial.print(vals[i]);
      Serial.print(',');
    }
    Serial.print('\n');
}

