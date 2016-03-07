class Button{
  float x_pos ;
  float y_pos ;
  float x_size ; 
  float y_size ; 
  String name ; 
  //boolean clicked ; 
  public Button(float x_pos, float y_pos, float x_size, float y_size, String name){
    this.x_pos = x_pos ;
    this.y_pos = y_pos ;
    this.x_size = x_size ;
    this.y_size = y_size ;
    this.name = name ; 
    //padX = 0.1*x_size ;
    //padY = 0.1*y_size ;
  }
  
  void renderCont(){
    rect(x_pos,y_pos,x_size,y_size);
    fill(120,120,120);
    textSize(24);
    textAlign(CENTER);
    text(name, x_pos+(x_size/2.), y_pos+(y_size/2.));
    
  }
  void render(boolean mouseOver, boolean clicked){
    if (mouseOver){
      strokeWeight(3);
    }
    else if (! mouseOver){
      strokeWeight(1);
    }
    if (clicked){
      fill(150);
    }
    else if (! clicked){
      fill(255); 
    }
    //fill(255);
    rect(x_pos,y_pos,x_size,y_size);
    fill(0);
    textSize(24);
    textAlign(CENTER);
    text(name, x_pos+(x_size/2.), y_pos+(y_size/2.));
  }
  
  boolean checkMouse(){
    if (mouseX < x_pos + x_size && mouseX > x_pos &&
        mouseY < y_pos + y_size && mouseY > y_pos){
          return true;  
        }
    else{
      return false;
    }
  }
  //void setClicked(boolean click){
  //  clicked = click; 
  //}
  
  //boolean getClicked(){
  //  return clicked ;  
  //}
  
  
}