public class FeelixControl {
  
  private int[] zeroVal = {0,0,0,0,0,0,0,0,0} ;
  private int[] curVal = {0,0,0,0,0,0,0,0,0} ;
  private String zeroValStr = "000000000";
  private String curValStr = "000000000";
  long lastSend =0; 
  long curTime = millis(); 
  Serial ardy ; 
  int[] ardyPins ; 
  int state = 0 ;
  
  public FeelixControl(Serial arduino, int[] pins){
    this.ardy = arduino;  
    this.ardyPins = pins ; 
  }
  
  public void setState(int[] valArray){
    if (valArray.length != curVal.length){
      println("Need to length 9 array"); 
    }
    for (int i=0; i<curVal.length; i++){
      curVal[i] = valArray[i]; 
    }
  }
  public void setState(boolean[] valArray){
    if (valArray.length != curVal.length){
      println("Need to length 9 array"); 
    }
    for (int i=0; i<curVal.length; i++){
      if (valArray[i]){
        this.curVal[i] = 1;
      }else if (! valArray[i]){
        this.curVal[i] = 0;
      }
    }
  }
  public void setState (int i, int val){ 
    // update the state one at a time. 
    this.curVal[i] = val ; 
  }
  
  public int getStatei (int i) {
   // get the state at position i  
    return this.curVal[i];
  }
  
  public int[] getState() {
   return this.curVal ; 
  }
  public void sendSignal(int onTime, int offTime){
    //println(state);
    //println(millis() - lastSend) ; 
    switch(state) {
      case 0:
        //println("OFF");
        if (millis() - lastSend > offTime) {
          // Turn ON
          writeVal(1);      
    
          lastSend = millis();
          //println("Send: ");
          //println(curVal);
    
          state = 1;
          delay(1);
        }
        break;
      case 1:
        //println("ON");
        if (millis() - lastSend > onTime) {
          // turn OFF
          writeVal(0) ;
   
          lastSend = millis();
          //println("Turn OFF");
          //println(zeroVal);
    
          state = 0;
        }
        break;
      default:
        println("ERROR SHOULDN'T PRINT");
      } 
  }
 
  public void writeVal(int onoff){  
    //println(curVal);
    if (onoff == 1){ // use curVal array
      String sendVal = ""; 
      for (int i=0; i<curVal.length; i++) {
        sendVal += String.valueOf(curVal[i]);
      }
      sendVal += "\n";
      this.ardy.write(sendVal);
      //println(sendVal);

    }else if (onoff == 0){
      String sendVal = ""; 
      for (int i=0; i<zeroVal.length; i++) {
        sendVal += String.valueOf(zeroVal[i]);
      }
      sendVal += "\n";
      this.ardy.write(sendVal);
      //println(sendVal);

    }
  }
  
  //public void playSequence(int[] sequence, int onTime, int offTime){ 
    ///*
    //sequence is an array of ints that correspond to the position of the 
    //leds. eg {1,2,3,4} will play leds 1, 2, 3, and 4 right after each other. 
    //9 is a special value: it corresponds to off. 
    //*/
    ////for (int i=0; i<sequence.le
    ////println(sequence);
    //for (int i=0; i<sequence.length;i++){
    //  //println(i);
    //  //this.lastSend = millis();
    //  //this.lastSend -= onTime; 
    //  int[] play = {0,0,0,0,0,0,0,0,0};
    //  if (sequence[i] == 9) {
    //    setState(play) ;    
    //    sendSignal(onTime, offTime) ;
    //  }else{
    //     //println("Hey");
    //    play[i] = 1 ; 
    //    setState(play) ; 
    //    sendSignal(onTime, offTime) ;
    //  } 
    //}
  //}
//    
    
}