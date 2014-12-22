class Ball {

  int bX;
  int bY;
  float bSpeedX = 0;
  float bSpeedY = 0;
  int bSize = 15;
  boolean gone = false;


  Ball(int x, int y) {
    bX = x;
    bY = y;
    bSpeedX = random(-10,10);
    bSpeedY = -7;

  }

  void move() {   
    bX+=bSpeedX;
    bY+=bSpeedY;
    
    if (bX<0 || bX>width){
      bSpeedX *= -1;
    }
    if (bY<0){
      bSpeedY *= -1;
    }
    
    float bottom = bY+bSize/2;
    float bl = bar.posY-10/2 ;
    float bLeft = bar.posX-bar.barSize/2;
    float bRight = bar.posX+bar.barSize/2;
    
    if (bottom >= bl && bX>bLeft && bX<bRight){
        bSpeedY *= -1;
  } 
  }
  
    void display() {
    fill(#FA8072);
    ellipse(bX,bY,bSize,bSize);
  
}}
