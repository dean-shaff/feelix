/*
  Blink
  Turns on an LED on for one second, then off for one second, repeatedly.

  Most Arduinos have an on-board LED you can control. On the Uno and
  Leonardo, it is attached to digital pin 13. If you're unsure what
  pin the on-board LED is connected to on your Arduino model, check
  the documentation at http://www.arduino.cc

  This example code is in the public domain.

  modified 8 May 2014
  by Scott Fitzgerald
 */
int numPins = 9 ; 
int pins[9] = {3,4,5,6,7,8,9,10,11};

// the setup function runs once when you press reset or power the board
void setup() {
  // initialize digital pin 13 as an output.
  for (int i=0; i< numPins; i++){
    pinMode(pins[i], OUTPUT);
  }

}

// the loop function runs over and over again forever
void loop() {
   for (int i=0; i< numPins; i++){
    digitalWrite(pins[i], HIGH);
  }
  delay(1000);    
  for (int i=0; i< numPins; i++){
    digitalWrite(pins[i], LOW);
  }

  delay(1000);              // wait for a second
}
