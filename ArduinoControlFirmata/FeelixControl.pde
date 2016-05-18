import cc.arduino.*;
import org.firmata.*;

public class FeelixControl {
  
  private String masterValStr = "0,0,0,0,0,0,0,0,0";
  private String curValStr = "0,0,0,0,0,0,0,0,0";
  int[] zeroVal = {0,0,0,0,0,0,0,0,0} ;
  int[] curVal = {0,0,0,0,0,0,0,0,0} ;
  long lastSend =0; 
  long curTime =millis(); 
  Arduino ardy ; 
  int[] ardyPins ; 
  public FeelixControl(Arduino arduino, int[] pins){
    this.ardy = arduino;  
    this.ardyPins = pins ; 
  }
  
  public void updateState(int[] valArray){
    if (valArray.length != masterVal.length){
      println("Need to length 9 array"); 
    }
    for (int i=0; i<curVal.length; i++){
      curVal[i] = valArray[i]; 
    }
  }
  
  public void sendSignal(int onTime, int offTime){
      switch(state) {
        case 0:
          //println("OFF");
          if (millis() - lastSend > offTime) {
            // Turn ON
            writeVal();      
      
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
            writeVal() ;
      
      
            lastSend = millis();
            println("Turn OFF");
      
            state = 0;
          }
          break;
        default:
          println("ERROR SHOULDN'T PRINT");
        } 
    
  }
  
  
  public void writeVal(){  
    for (int i=0; i<curVal.length; i++){
      if (curVal[i] == 1){
        ardy.digitalWrite(ardyPins[i],Arduino.HIGH);
      }else if (curVal[i] == 0){
        ardy.digitalWrite(ardyPins[i],Arduino.LOW);
      }
    }
  }
  
  public void delayDean(int delay){
    long timeCur = millis()  ;
    while (millis() - timeCur < delay) {
      //do nothing. 
    }
  }
  
  
  
}