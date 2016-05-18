import feelixcontrol.*; 

UI ui ;
FeelixControl controller ; 
//int[] pins = {3,4,5,6,7,8,9,10,11};
//int[] ardyPin = {4,5,6,7,8,9,10,11,12};
int[] ardyPin = {8,5,3,2,1,0,9,10,11} ;
int mode = 2 ;
void setup(){
   size(400,400);
   String portName =  "/dev/cu.usbmodem1421";
   controller = new FeelixControl(this,portName,57600,ardyPin);
   println("Made controller!");
   ui = new UI(controller, mode);
   ui.uiSetup();
}

void draw(){
  ui.uiDraw();
}

void mouseClicked(){
  ui.uiMouseClicked(); 
}