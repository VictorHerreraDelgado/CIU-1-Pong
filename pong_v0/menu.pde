class Menu{
  
  public Menu(){};
  
  void drawMenu(int selection,boolean start){
    rectMode(CENTER);
    drawWindow(start);
    drawOptions(selection);
    drawSelBal(selection);
  }
  
  void drawOptions(int selection){
    int sel1 = 0;
    int sel2 = 0;
    if(selection == 1) sel1 = 100;
    else if(selection == 2) sel2 = 100;
    
    textSize(40);
    
    fill(100 - sel1,100,200);
    rect(width/2,height/4 * 2.3,width/3,50);
    fill(255 - sel1,200,200);
    text("Jugar",width/3 + 70,height/4 * 2.4);
    
    fill(100 - sel2,100,200);
    rect(width/2,height/4 * 3,width/3,50);
    fill(255 - sel2,200,200);
    text("Salir",width/3 + 75,height/4 * 3.1);
  
  }
  
  void drawWindow(boolean start){
    if (start){
      fill(255,200,200);
      rect(width/2,height/2,width/2,height/4 *3);
      fill(100,100,200);
      text("PONG",width/3 + 30,height/3);
    }else{
      fill(255,200,200);
      rect(width/2,height/3*2,width/2,height/3 + 50 );
    }
  }
  
  void drawSelBal(int selection){
    float pos = height/4 * 2.3;
    if(selection == 2) pos =height/4 * 3;
    ellipseMode(CENTER);
    fill(100,100,200);
    ellipse(width/4 + 25,pos,30,30);
    fill(255,200,200);
    ellipse(width/4 + 25,pos,10,10);
  }
  
}
