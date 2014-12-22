class Bar {
  int speedL = 10;
  int speedR = 10;
  int barSize = 100;
  int posX;
  int posY;
  int life;

  Bar(int x, int y,  int l) {
    this.posX = x;
    this.posY = y;
    life = l;
  } 

  void display() {
    fill(255);
    rect(posX, posY, barSize, barSize/10);
}

void move(){
posX = mouseX;
}
  }


