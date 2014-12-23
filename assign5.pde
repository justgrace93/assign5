Bar bar;
Ball[] bList;
Brick[] aList;

//Game Status
final int GAME_START   = 0;
final int GAME_PLAYING = 1;
final int GAME_PAUSE   = 2;
final int GAME_WIN     = 3;
final int GAME_LOSE    = 4;
int status;              
int point;               
int countBallFrame;    
int ballNum;    
int brickCount = 50;


final int LIFE_THREE = 0;
final int LIFE_TWO   = 1;
final int LIFE_ONE   = 2;
final int LIFE_NONE  = 3;
int lifeState;



void setup() {

  status = GAME_START;
  bList = new Ball[2];
  aList = new Brick[100];

  size(640, 480);
  background(0, 0, 0);
  rectMode(CENTER);

  bar = new Bar(width/2, height-50, 3);

  reset();
}

void draw() {
  background(50, 50, 50);
  noStroke();

  switch(status) {

  case GAME_START:
  printText("BYE BRICK GAME", "Press ENTER to Start ", 240, 60, 20 );

  break;

  case GAME_PLAYING:
    background(50, 50, 50);

    drawLife();
    bar.display(); 
    drawBrick();
    drawBall();
    bar.move();
    ballStick();
   
    checkBrickDead();
    checkBallOut();
 
    ifWin();
 
    countBallFrame+=1;
    break;

  case GAME_PAUSE:
 printText("PAUSE", "Press ENTER to Resume", 240, 60, 20 );
    break;

  case GAME_WIN:
 printText("WINNER", "CONGRATS", 240, 60, 20 );//put score in
    break;

  case GAME_LOSE:
 printText("WHOOPS", "You are DEAD!!!", 240, 60, 20 );
    break;
  }

}

void keyPressed() {
  statusCtrl();
}


void brickMaker(int brickTotal, int brickCol) {
  int ix = 130;
  int iy = 50;
  int spacingX = 40;
  int spacingY = 40;

 for (int i = 0; i <= brickTotal-1; i++){
 
 int x = ix + int(i%brickCol)*spacingX;
 int y = iy + int(i/brickCol)*spacingY;
      
      aList[i]= new Brick(x ,y);
      
    }
}


void drawLife() {
  fill(#FA8072);
  text("LIFE:", 36, 466);
  
int x = 78; 
int y = 459;
int spacing = 25; 
int endCircle = 128; 

switch (lifeState){
  case LIFE_THREE:
   endCircle = 128;
   break;
  case LIFE_TWO:
   endCircle = 103;
   break;
  case LIFE_ONE:
   endCircle = 78;
   break;
  case LIFE_NONE:
   endCircle = 0;
   status = GAME_LOSE;
   break;
}

while(x <= endCircle) { 
ellipse(x, y , 15, 15); 
x = x + spacing; 
} 
  
}

void drawBall() {
  for (int i=0; i<bList.length-1; i++) {
    Ball ball = bList[i];
    if (ball!=null ) { // Check Array isn't empty and ball still exist
      ball.move();     
      ball.display();  
      if (ball.bY > height+1) {
        removeBall(ball);
        
      }
    }
  }
}


void drawBrick() {
  for (int i=0; i<aList.length-1; i++) {
    Brick brick = aList[i];
    if (brick!=null && !brick.die) { // Check Array isn't empty and brick still exist
     
      brick.display(); 

    }
  }
}

  
void mouseClicked(){
for (int i=0; i<bList.length-1;i++){
 Ball ball = bList[i];
if (countBallFrame>30) {
      bList[ballNum]= new Ball(bar.posX, bar.posY-7);
      if (ballNum< bList.length-2 ) {
        ballNum+=1;
      } else {
        ballNum = 0;
    } 
   }
    countBallFrame = 0;
}}

void checkBallOut(){
for (int i=0; i<bList.length-1;i++){
  Ball ball = bList[i];
  if (ball!=null && !ball.gone &&bList[i].bY >= height){
  lifeState ++;
}
}
}

void checkBrickDead() {
  for (int i=0; i<bList.length-1; i++) {
    Ball ball = bList[i];
    for (int j=0; j<aList.length-1; j++) {
      Brick brick = aList[j];
      if (ball != null && brick != null  && !brick.die // Check Array isn't empty and ball / brick still exist
 
    && bList[i].bX -5 <= aList[j].aX + aList[j].aSize+3 
    && bList[i].bX +5 >= aList[j].aX  -6
    && bList[i].bY -5 <= aList[j].aY + aList[j].aSize +2
    && bList[i].bY +5 >= aList[j].aY  -2  ) {
      
        
        removeBrick(aList[j]);
        brickCount--;
        ball.bSpeedX *= -1;
        ball.bSpeedY *= -1;


      }
      }
    
  }
}

void ifWin(){

if (brickCount == 0){
  status=GAME_WIN;
}}


void printText(String A, String B, int numOfY, int SizeA, int SizeB){

textAlign(CENTER);
fill(#FA8072);

textSize(SizeA); 
text(A ,width/2, numOfY); 

textSize(SizeB);
text(B, width/2, numOfY+40);

}


void removeBall(Ball obj) {
  obj.gone = true;
  obj.bX = 2000;
  obj.bY = 2000;
}


void removeBrick(Brick obj) {
  obj.die = true;
  obj.aX = 1000;
  obj.aY = 1000;
}


void reset() {
  for (int i=0; i<bList.length-1; i++) {
    bList[i] = null;
  }

  for (int i=0; i<aList.length-1; i++) {
    aList[i] = null;
  }

  point = 0;
  countBallFrame = 30;
  ballNum = 0;
  brickCount = 50;
 
 
  brickMaker(50,10);

  bar.posX = width/2;
  bar.posY = 460;
  
}


void statusCtrl() {
  if (key == ENTER) {
    switch(status) {

    case GAME_START:
      status = GAME_PLAYING;
      lifeState = LIFE_THREE;
      break;
    case GAME_PLAYING:
      status = GAME_PAUSE;
      break;
    case GAME_PAUSE:
      status = GAME_PLAYING;
      break;
    case GAME_WIN:
      reset();
      status = GAME_START;
      break;
    case GAME_LOSE:
      reset();
      status = GAME_START;
      break;  


    }
  }
}

void ballStick(){
  for (int i=0; i<bList.length-1; i++) {
    Ball ball = bList[i];
  if (ball==null||ball.gone){
  fill(#FA8072);
  ellipse(mouseX,height-35,15,15);
  }}}


