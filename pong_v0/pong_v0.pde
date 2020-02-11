import processing.sound.*;
//import gifAnimation.*;
int state ; //Estado del programa
Menu m1 = new Menu();
int selection; //Selección del usuario.
boolean pause; //Si está en pausa o no.
int px,py;
int vx,vy;
int jx,jy;
int jx2,jy2;
int starting; //Estado para controlar si comienza una nueva ronda.
boolean[] keys = new boolean[4];
int padLength = 60;
int padWidth = 10;
int points1 = 0;
int points2 = 0;
SoundFile piSound,poSound,bounceSound,loseSound,winSound;
//PImage img;
SinOsc sin;

//GifMaker ficherogif;
void setup(){
 size(700,500);
 fill(128);
 noStroke();
 state = 0;
 pause = false;
 selection = 1;
 //img = loadImage("instrucciones.png");
 initSounds();
 starting = 0;
 sin = new SinOsc(this);
 //ficherogif = new GifMaker ( this , "funcionamiento.gif" ) ;
 //ficherogif.setRepeat(0) ;
}


void draw(){
  background(0);
  
  //Estado de comienzo. Muestra el menú.
  if(state == 0){
    textSize(60);
    fill(200);
    //image(img, 100, 10,img.width/2, img.height/2);
    //text("Click to start", width/4.5, height/2);
    m1.drawMenu(selection,true);
    return;
  }
  //Estado de final de partida. Muestra el menú.
  else if(state == 2){
    String message =  "Jugador 1";
    if(points1 != 7) message = "Jugador 2";
    textSize(60);
    fill(200);
    text(message + " gana", width/4.5, height/3);
    m1.drawMenu(selection,false);
    return;
  }
  //Dibujo de los distintos elementos
  rectMode(CORNER);
  fill(200);
  textSize(60);
  drawLine();
  fill(200);
  text(points2, (width/8)*3 - 20, height /5); 
  text(points1, (width/8)*5 - 20, height /5); 
  rect(jx,jy,padWidth,padLength);
  rect(jx2,jy2,padWidth,padLength);
  fill(230);
  updatePads(); 
  updateBall();
  bounceOnWall();
  bounceOnPad();
  ballGoaled();
  ellipse(px,py,20,20);
  //ficherogif.addFrame();
  //Si está en pausa mostramos "Pausa"
  if(pause){
    textSize(100);
    fill(200,100,100);
    text("Pausa", (width/6)*2 - 25, height/2);
    textSize(60);
  }
  // Bloque para esperas entre rondas.
  if(starting > 1){
    starting = 1;
  }else if(starting == 1){
    sin.play(300, 0.05);
    delay(1000);
    sin.stop();
    starting = 0;
  }
}


// Dibuja línea intermedia
void drawLine(){
  fill(100);
  for(int i = 1; i <= 16 ; i = i + 2){
    rect((width/2) - 2,(height/16)*i,5,height/16);
  }
}


/**
 FUNCIONES PARA EL CONTROL DEL REBOTE DE LA PELOTA EN EL JUEGO.
*/

// Comprueba si ha entrado la pelota en "porteria"
void ballGoaled(){
 if(px >= width){
     points2++;
     anotherRound(1);
     loseSound.play();
  }
  else if(px <= 0){
    points1++;
    anotherRound(-1);
    loseSound.play();
  } 
}
// Comprueba si rebota en una pared
void bounceOnWall(){
  if((py > height -1 && vy > 0) || (py < 1 && vy < 0) ){
    vy=-vy; 
    if((int)vy == 0) vy = 1;
    bounceSound.play();
  }
}

// Comprueba si rebota en la pala de algún jugador.
void bounceOnPad(){
  if((vx > 0)&&(px + 5 >= jx && px + 5 <= jx+padWidth) && (py >= jy-9 && py <= (jy+padLength+9))){
    vx=-vx + 1*(-vx/abs(vx));
    //Corner bounce control //<>//
    if(py+5-(jy+padLength)>0){
      vy = vy + 1;
    }else if((py-jy-5)<0){
      vy = vy - 1;
    }else{
      if(keys[2]){ 
        vy = (vy)==0? -1 :abs(vy)*-1;
      }
      else if(keys[3]){
        vy = (vy)==0? 1 : abs(vy);
      }
    }
    piSound.play();

  }
  if((vx < 0)&&(px - 5 <= jx2+padWidth && px - 5 >= jx2) && (py >= jy2-9 && py <= (jy2+padLength+9))){
    
    vx=-vx + 1*(-vx/abs(vx));
    
    //Corner bounce control
    if(py+5-(jy2+padLength)>0){
      vy = vy + 1;
    }else if((py-jy2-5)<0){
      vy = vy - 1;
    }else{
      if(keys[0]) vy = (vy)==0? -1 :abs(vy)*-1;
      else if(keys[1]) vy = (vy)==0? 1 : abs(vy);
    }
    poSound.play();
  }
}


/**
 FUNCIONES PARA LA ACTUALIZACIÓN DE VARIABLES.
*/

//Actualiza la pelota en relación a su velocidad.
void updateBall(){
 if(vx > 150) vx = vx/10;
  px=int(px + (vx/abs(vx))*min(abs(vx),11));
  py=int(py+vy); 
}

//Actualiza las palas en función de lo pulsado por los jugadores.
void updatePads(){
  if(keys[0] && jy2 >= 0) jy2 = jy2 - 6 ; 
    else if(keys[1] && jy2 <= height - padLength) jy2 = jy2 + 6;
    
    if(keys[2]&& jy >= 0) jy = jy - 6;
    else if(keys[3]&& jy <= height - padLength) jy = jy + 6;
}



/**
 INICIALIZACIÓN DE ELEMENTOS DEL PROGRAMA.
*/

// Inicialización de sonidos
void initSounds(){
 piSound = new SoundFile(this,"alexPi.mp3");
 poSound = new SoundFile(this,"alexPo.mp3");
 bounceSound = new SoundFile(this,"NFF-bounce-02.wav");
 loseSound  = new SoundFile(this,"NFF-lose.wav");
 winSound = new SoundFile(this,"NFF-cool-success.wav");
 bounceSound.amp(0.05);
 loseSound.amp(0.1); 
 winSound.amp(0.1);
}

//Inicialización de pelota
void initBall(){
 px=width/2;
 py= height/2;
 vx= round((random(-5,5) + 1));
 if(vx == 0) vx = 1;
 vy= round(random(5)); 
}

//Inicialización de las palas
void initPads(){
 jx=(int)(width*0.9);
 jx2 =(int)(width-width*0.9); 
 jy= height/2;
 jy2=height/2; 
}


/**
 FUNCIONES PARA EL CONTROL DEL ESTADO DEL PROGRAMA/JUEGO.
*/
//Ejecuta otra ronda del juego o finaliza si llega a 7.
void anotherRound(int side){
   if(points1 == 7 || points2 == 7){
     selection = 1;
     state = 2;
     winSound.play();
   }
   px=width/2;
   py=height/2;
   vx=round(random((5)))*side + 1*side;
   vy=round(random(10)) - 5;
   starting = 2;
}

//Reinicia los valores para una nueva partida
void restartValues(){
 initBall();
 points1 = 0; points2 = 0;
 initPads();
 starting = 2;
}

// Pausa o reanuda el juego.
void pause(){
  {
   if(pause){
     pause = false;
     loop();
   }
   else{
     pause = true;
     noLoop();
     
     redraw();
     textSize(60);
   }
  }
}

/**
 FUNCIONES PARA EL CONTROL DEL TECLADO.
*/
void keyPressed() {
  if(keyCode == UP ) {
    keys[2] = true;
    selection = 1;
  }
  if(keyCode == DOWN ) {
    keys[3] = true;
    selection = 2;
  }
  //Controla la opción elegida por el usuario.
  if(keyCode == ENTER){
    if(state == 0 || state==2){
      if(selection == 1){
        restartValues();
        state = 1;
      }else exit();
    }
  }
  if(key == 'w' || key == 'W' ) keys[0] = true;
  if(key == 's' || key == 'S' ) keys[1] = true;
  //if(key == 'g' || key == 'G' ) ficherogif.finish();
  if((key == 'p' || key == 'P')&& state == 1) noLoop();
}
 
void keyReleased() {
  if(keyCode == UP ) keys[2] = false;
  if(keyCode == DOWN ) keys[3] = false;
  if(key == 'w' || key == 'W' ) keys[0] = false;
  if(key == 's' || key == 'S' ) keys[1] = false;
  if((key == 'p' || key == 'P') && state == 1) pause();
}
