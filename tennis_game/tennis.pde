Ball b1;
Player tp;
Button tweet;
int pre_fc;

int score = 0;
int tennis_game_scene = 0;
int TIME;
int start_frame;
int FRAME_RATE = 20;

void setup(){
  size(400,400);
  b1 = new Ball(1);
  tp = new Player();
  frameRate(FRAME_RATE);
}

void draw(){
  if(tennis_game_scene == 0){
    background(0);
    fill(255);
    textSize(32);
    text("TENNIS GAME !!",30, height/2 );
    textSize(16);
    text("PRESS ENTER",30,height/2 + 20);
    start_key();
  }else if(tennis_game_scene == 1){
    tennis_main();
  }else if(tennis_game_scene == 2){
    result(); 
  }
  
}

void tennis_main(){
  if(TIME==0)tennis_game_scene = 2;
  if((frameCount-start_frame)%FRAME_RATE==0)TIME -= 1;
  
  background(0);
  
  // field_draw
  fill(0,255,0);
  rect(0,350,400,50);
  
  fill(255);
  textSize(64);
  text(score, 20,50);
  textSize(32);
  text(TIME+" seconds left", 20,80);
  
  
  tp.p_draw();
  
  tennis_key_move();
   
  if(frameCount>=20){
    b1.ball_move();
    b1.bounce();
    b1.ball_draw();
  }else{
    fill(255);
    text("NOW LOADING...",20,20);  
  }
}

void result(){
  noStroke();
  fill(255,255,100,100);
  rect(50,50,300,300);
  fill(0);
  text("RESULT",70,80);
  tweet = new Button("TWEET","LINK",70,200,60,30);
  result_key();  
}
