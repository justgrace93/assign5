class Brick {

  int aSpeed = 1;
  int aSize = 10;
  int aScore = 10;
  int aX;
  int aY;
  boolean die = false; 

  Brick(int x, int y) {
    aX = x;
    aY = y;
  }

  void display() {
    fill(122 ,197 ,205);
    rect(aX, aY, 30,30,3);
  }

  void move() {
   
  }

  
}
