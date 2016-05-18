public class UI {
  // mode 1 corresponds to a 3x3 grid of squares.
  // mode 2 corresponds to sending sequences to be played on LED array
  int widthGrid = 3 ;
  int heightGrid = 3; 
  int mode ;
  int onTime = 300 ;
  int offTime = 300 ;
  int controllerState ;
  FeelixControl controller ; 
  Button[] buttons = new Button[widthGrid*heightGrid]; 
  Button[] buttons2 = new Button[2]; 
  boolean[] clicked = new boolean[widthGrid* heightGrid]; 
  boolean[] clicked2 = new boolean[buttons2.length];
  ArrayList<int[]> sequences = new ArrayList<int[]>();
  Button buttonSwitchMode ;

  int increment2 = 0 ; 

  public UI(FeelixControl controller, int mode) {
    this.mode = mode; 
    this.controller = controller; 
    controllerState = controller.state;
  }

  public void uiSetup() {
    //println("got here");
    buttonSwitchMode = new Button(width/2 - 75, 10, 150, 80, "Switch\nModes");
    int[] sequence0 = {0,1,2,3};
    int[] sequence1 = {0, 1, 2, 3, 4, 5, 6, 7, 8} ; 

    sequences.add(sequence0);
    sequences.add(sequence1);

    // settings for mode 1  
    int boxWidth = (width - 4*10) / 3 ;
    int boxHeight = (height - 4*10 - 100) / 3;
    for (int x=0; x< widthGrid; x++) {
      for (int y=0; y < heightGrid; y++) {
        int pos = widthGrid*y + x; 
        buttons[pos] = new Button(10 + x*(boxWidth+10), 110+ y*(boxHeight+10), boxWidth, boxHeight, str(pos)); // assuming 600x600 grid 
        buttons[pos].render(false, false);
      }
    }
    // settings for mode 2 
    int boxWidth2 = 200; 
    int boxHeight2 = 100; 
    for (int i=0; i< buttons2.length; i++) { 
      buttons2[i] = new Button(width/2 - boxWidth2/2, 110 + i*(boxHeight2+10), boxWidth2, boxHeight2, "Play Sequence "+str(i+1));
    }


    if (mode == 1) {
      println("Mode 1 setup") ;
      for (int i=0; i < buttons.length; i++) {
        buttons[i].render(false, false);
      }
    } else if (mode == 2) { 
      for (int i=0; i<buttons2.length; i++) {
        buttons2[i].render(false, false) ;
      }
      //println("Not yet implemented");
    }
  }

  public void uiDraw() { 
    background(255);
    buttonSwitchMode.render(buttonSwitchMode.checkMouse(), false);
    if (mode == 1) {
      for (int i=0; i<buttons.length; i++) {
        buttons[i].render(buttons[i].checkMouse(), clicked[i]);
      }
      controller.sendSignal(this.onTime, this.offTime);
    } else if (mode == 2) {

      // Below we send a sequence bit by bit.
      //println(clicked2);
      for (int i=0; i<buttons2.length; i++) {
        buttons2[i].render(buttons2[i].checkMouse(), clicked2[i]) ; 
        if (clicked2[i]) {  

          int[] sequence_cur = sequences.get(i);
          //println(sequence_cur);
          if (increment2 == sequence_cur.length) {
            increment2 = 0 ;
          }
          //println(increment2);
          //println("\n");
          //println(increment2);
          //delay(100);
          int[] play = {0, 0, 0, 0, 0, 0, 0, 0, 0};
          if (sequence_cur[increment2] == 9) {
            controller.setState(play) ;    
            //sendSignal(onTime, offTime) ;
          } else {
            play[sequence_cur[increment2]] = 1 ; 
            //println(play);
            controller.setState(play) ; 
            //sendSignal(onTime, offTime) ;
          }

          controller.sendSignal(this.onTime, this.offTime);
          if (controllerState != controller.state) {
            controllerState = controller.state ; 
            if (controllerState == 0){
              increment2 += 1 ;
              println(increment2);
            }
          }
          //increment2 += 1; 
          //controller.playSequence(sequences.get(i),this.onTime,this.offTime);
        }
      }
      //println(increment2);
    }
  }

  void uiMouseClicked() {
    if (buttonSwitchMode.checkMouse()) {
      if (mode == 1) {
        mode = 2;
      } else if  (mode == 2) { 
        for (int i=0; i<clicked2.length; i++) {
          clicked2[i] = false;
        }
        int[] reset = {0, 0, 0, 0, 0, 0, 0, 0, 0};
        controller.setState(reset);
        mode = 1 ;
      }
    }
    if (mode == 1) { 
      for (int i=0; i<buttons.length; i++) {
        //buttons[i].render(buttons[i].checkMouse(),clicked[i]);
        if (buttons[i].checkMouse()) { 
          clicked[i] = ! clicked[i];
          buttons[i].render(true, clicked[i]);    
          if (controller.getStatei(i) == 1) {
            controller.setStatei(i, 0);
          } else if (controller.getStatei(i) == 0) {
            controller.setStatei(i, 1);
          }
        }
      }
      println(controller.getState());
      println("\n\n");
      //controller.updateState(clicked);
    } else if (mode ==2) {
      for (int i=0; i<buttons2.length; i++) { 
        if (buttons2[i].checkMouse()) {
          clicked2[i] = ! clicked2[i]; 
          if (clicked2[i]) { // need to set the rest to false
            for (int j=0; j<buttons2.length; j++) {
              //print("in second loop");
              if (i != j) {
                clicked2[j] = false;
              }
            }
            //controller.playSequence(sequences.get(i),this.onTime,this.offTime); 
            break;
          } else {
          }
        }
      }
    }
  }
}