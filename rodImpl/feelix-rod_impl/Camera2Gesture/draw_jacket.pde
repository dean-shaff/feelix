/**
 * This sketch draws the jacket shape and actuators 
 * it also changes the color of each actuator according to the 
 * pixel voting system defined in video processing.
 */

//Vertices for Front and Back of the jackets
PVector vertsF[];
PVector vertsB[];

//Actuator positions in cathesian
PVector[] actuatorPos;

//Actuator objects list
Actuator[] actuators;

int[] act_num = {3,3};
int actuator_count = act_num[0]*act_num[1];
int act_width = width/act_num[0];
int act_height = height/act_num[1];

void draw_jacket_setup() {

  actuator_count = act_num[0]*act_num[1];
  act_width = width/act_num[0];
  act_height = height/act_num[1];
  
  actuators = new Actuator[actuator_count]; 
  int count = 0;
  for (int i=0; i < act_num[0]; i++) {
    for (int j=0; j < act_num[1]; j++) {
      actuators[count] = new Actuator(new PVector(j*(act_width), i*(act_height)), count);
      count++;
    };
  };
  
  //Initialize actuator positions
  //actuators = new Actuator[]{
  //  //Chest left
  //  new Actuator(new PVector(0, 0), 0), 
  //  new Actuator(new PVector(360, 60), 1), 
  //  new Actuator(new PVector(600, 60), 2), 
  //  new Actuator(new PVector(0, 0), 3), 
  //  new Actuator(new PVector(360, 180), 4), 
  //  new Actuator(new PVector(600, 180), 5), 
  //  new Actuator(new PVector(0, 0), 6), 
  //  new Actuator(new PVector(360, 300), 7), 
  //  new Actuator(new PVector(600, 300), 8),  
  //};
}


//DRAW FUNCTIONS

//Draw Shape
//void drawShape(PVector[] verts) {
//  beginShape();
//  // You can set fill and stroke
//  noFill();
//  stroke(255);
//  for (int i=0; i<verts.length; i++) {
//    vertex(verts[i].x, verts[i].y);
//  }
//  endShape();
//}

//Draw all actuators
void drawActuators(Actuator[] actuators) {

  for (int i=0; i < actuators.length; i++) {
    actuators[i].drawActuator();
  }
}

// Class definition for an actuator object. 
// These are used to keep track of which actuators are on or off
// and drawing that information to the screen.
class Actuator {
  PVector pos;
  PVector mid_pos;
  int num;
  int w = act_width;
  int h = act_height;
  // Nearby pixels vote on the state of the actuator 
  // could easily increase resolution on count_votes.
  int votes = 0;
  boolean on;

  //Constructor
  Actuator(PVector initial_pos, int act_num) {
    pos = initial_pos;
    mid_pos = new PVector(pos.x+w/2,pos.y+h/2);
    num = act_num;
    on = false;
  }

  PVector getPos() {
    return pos;
  }
  
  PVector getMid(){
    return mid_pos;
  }

  //Draw actuator function 
  void drawActuator() {
    if (on) fill(255, 0, 0, 80); //On is red and a bit transparent
    else noFill();          //Off is white
    stroke(0);               //Black outline
    rect(pos.x, pos.y, w, h);

    fill(0);                 //text font

    text(num, mid_pos.x, mid_pos.y);
  }

  void vote(int i) {
    if (abs(votes) < 10) votes += i; //Higher response time
  }

  //Count votes and outputs actuator bit map to a boolean array (matrix send)
  boolean count_votes_bool() {
    if (votes > 0) {
      sendPacket(updateRate, num);
      on = true;
    } else on = false;
    votes = 0;
    return on;
    //Send Packet Here
  }

  //Count votes and outputs actuator bit map to string (packet send)
  String count_votes_string() {
    if (votes > 0) {
      votes = 0;
      on = true;
      return "1";
    } else {
      on = false;
      votes = 0;
      return "0";
    }
  }
}
String[] updateActuators(Actuator[] actuators) {
  String bitsString = "";
  int count = 0;

  //Create string equivalent to bit ON/OFF matrix for actuators 
  for (int i=0; i < actuators.length; i++) {
    bitsString += actuators[i].count_votes_string();
    count++;
    //Split every 8 for bytes
    if (count > 8) {
      bitsString += " ";
      count = 0;
    }
  }

  //Get list of bytes in bit form
  return split(bitsString, " ");
}

void drawSettings() {
  int w = 15;
  rect(w,height,0,0);
  fill(0,0,0);
  text(vote_threshold, 5, 5);
  text(str(seeRed), 5, 15);
}

//****MAIN*****//
void updateDraw() {
  //Draw Background
  background(0);
  noStroke();
  for (int j = 0; j < numPixelsHigh; j++) {
    for (int i = 0; i < numPixelsWide; i++) {
      fill(movColors[j*numPixelsWide + i]);
      rect(i*blockSize, j*blockSize, blockSize, blockSize);
    }
  }
  //println(actuators.length);
  //updateActuators(actuators);
  drawActuators(actuators);
}