import processing.sound.*;
int state = 0;
int px,py;
float vx,vy;
int jx,jy;
int jx2,jy2;
boolean[] keys = new boolean[4];
int padLength = 60;
int padWidth = 10;
int points1 = 0;
int points2 = 0;
SoundFile piSound,poSound,bounceSound,loseSound;
PImage img;
int[] oldjy = new int[5];

void setup(){
 size(700,500);
 fill(128);
 noStroke();
 img = loadImage("instrucciones.png");
 initSounds();
 restartValues();
}

void draw(){
  
  
  background(0);
  
  fill(200);
  textSize(60);
  drawLine();
  fill(200);
  text(points2, (width/8)*3 - 20, height /5); 
  text(points1, (width/8)*5 - 20, height /5); 
  rect(jx,jy,padWidth,padLength);
  rect(jx2,jy2,padWidth,padLength);
  
  
  if(state == 0){
    textSize(60);
    fill(200);
    image(img, 100, 10,img.width/2, img.height/2);
    text("Click to start", width/4.5, height/2);
    return;
  }
  else if(state == 2){
    String message =  "Player1";
    if(points1 != 7) message = "Player2";
    textSize(60);
    fill(200);
    text(message + " wins!", width/4.5, height/3);
    text("Click to restart", width/4.5, height/2);
    return;
  }
  fill(230);
  updatePads(); 
  updateBall();
  System.out.println("vy = "+ vy + "  vx = " + vx);
  bounceOnWall();
  bounceOnPad();
  ballGoaled();
  ellipse(px,py,20,20);
}



void keyPressed() {
  if(keyCode == UP ) keys[2] = true;
  if(keyCode == DOWN ) keys[3] = true;
  if(key == 'w' || key == 'W' ) keys[0] = true;
  if(key == 's' || key == 'S' ) keys[1] = true;
}
 
void keyReleased() {
  if(keyCode == UP ) keys[2] = false;
  if(keyCode == DOWN ) keys[3] = false;
  if(key == 'w' || key == 'W' ) keys[0] = false;
  if(key == 's' || key == 'S' ) keys[1] = false;
}

void anotherRound(int side){
   if(points1 == 7 || points2 == 7) state =2;
   px=width/2;
   py=height/2;
   vx=random((5))*side + 1*side;
   vy=random(5);
}

void mouseClicked(){
  if(state == 0 ) state = 1;
  else if(state == 2){
    restartValues();
    state = 1;
  }
}


void ballGoaled(){
 if(px > width){
     points2++;
     anotherRound(1);
     loseSound.play();
  }
  else if(px < 0){
    points1++;
    anotherRound(-1);
    loseSound.play();
  } 
}

void bounceOnWall(){
  if((py > height -1 && vy > 0) || (py < 1 && vy < 0) ){
    vy=-vy; 
    if((int)vy == 0) vy = 1;
    bounceSound.play();
  }
}

void bounceOnPad(){
  if((vx > 0)&&(px >= jx && px <= jx+padWidth) && (py >= jy-9 && py <= (jy+padLength+9))){
    vx=-vx*1.1;

    
    
    //Corner bounce control
    if(py+5-(jy+padLength)>0){
      vy = vy + 1;
    }else if((py-jy-5)<0){
      vy = vy - 1;
    }else{
      if(keys[2]){ 
        vy = ((int)vy)==0? -1 :abs(vy)*-1;
      }
      else if(keys[3]){
        vy = ((int)vy)==0? 1 : abs(vy);
      }
    }
    piSound.play();
  }
  if((vx < 0)&&(px <= jx2+padWidth && px >= jx2) && (py >= jy2-9 && py <= (jy2+padLength+9))){
    
    vx=-vx*1.1;
    
    //Corner bounce control
    if(py+5-(jy2+padLength)>0){
      vy = vy + 1;
    }else if((py-jy2-5)<0){
      vy = vy - 1;
    }else{
      if(keys[0]) vy = ((int)vy)==0? -1 :abs(vy)*-1;
      else if(keys[1]) vy = ((int)vy)==0? 1 : abs(vy);
    }
    poSound.play();
  }
}


void updateBall(){
 if(vx > 150) vx = vx/10;
  px=int(px + (vx/abs(vx))*min(abs(vx),11));
  py=int(py+vy); 
}

void updatePads(){
  if(keys[0] && jy2 >= 0) jy2 = jy2 - 6 ; 
    else if(keys[1] && jy2 <= height - padLength) jy2 = jy2 + 6;
    
    if(keys[2]&& jy >= 0) jy = jy - 6;
    else if(keys[3]&& jy <= height - padLength) jy = jy + 6;
}

void restartValues(){
 initBall();
 points1 = 0; points2 = 0;
 initPads();  
}

void initSounds(){
 piSound = new SoundFile(this,"alexPi.mp3");
 poSound = new SoundFile(this,"alexPo.mp3");
 bounceSound = new SoundFile(this,"NFF-bounce-02.wav");
 loseSound  = new SoundFile(this,"NFF-lose.wav");
 bounceSound.amp(0.05);
 loseSound.amp(0.1); 
}

void initBall(){
 px=width/2;
 py= height/2;
 vx=random(5)+1;
 vy= random(5); 
}

void initPads(){
 jx=(int)(width*0.9);
 jx2 =(int)(width-width*0.9); 
 jy= height/2;
 jy2=height/2; 
}

void drawLine(){
  fill(100);
  for(int i = 1; i <= 16 ; i = i + 2){
    rect((width/2) - 2,(height/16)*i,5,height/16);
  }
}
