class Ball{
  float b_x; float b_y;
  int b_state;
  int b_frame_count;
  float START_X = 350;
  float START_Y = 250;
  float dx = -10; float dy = -5;
  float g = 2; 
  float r = 5; float friction = 0.85;
  
  Ball(int state){
    b_x = START_X;
    b_y = START_Y;
    b_state = state;
  }
  
  void ball_move(){
    dy = dy + g;
    b_x = b_x + dx;
    b_y = b_y + dy;
    
  }
  
  void ball_draw(){
    noStroke();
    fill(255,255,0);
    ellipse(b_x, b_y, r*2, r*2); 
    stroke(1);
  }
  
  void bounce(){
  float xMin = r;
  float xMax = width - r;
  float yMin = r;
  float yMax = height -50 - r;
  if(b_x < xMin || b_x > xMax){
    dx=-dx*friction;
    if(abs(dx) < 1)dx=0;
    if(b_x < xMin) b_x = xMin-(b_x-xMin);
    if(b_x > xMax) b_x = xMax-(b_x-xMax);
  }  
  if(b_y < yMin || b_y > yMax){
    dy=-dy*friction;
    if(abs(dy) < g) dy = 0;
    if(b_y < yMin) b_y = yMin-(b_y-yMin);
    if(b_y > yMax) b_y = yMax-(b_y-yMax);
  }
  
  }  
   
}

class Player{
  float x = 100; float y = 340;
  float START_X = 50; float START_Y = 325;
  
  
  void p_draw(){
    fill(255,0,0);
    rect(x-15, y-60, 30, 70);
  }
  
  void hit(float re){
    if(b1.b_x<(x+40) && b1.b_x>(x-40)){
      if(b1.b_y>(y-70) && b1.b_y<(y+20)){
      b1.dx = -re*b1.dx;
      b1.b_frame_count = frameCount;
      b1.dy = -18;
      score += 1;
      }
    }
  }
  
}

class Button{
  int b_x, b_y, b_w, b_h;
  String b_name,b_usage;
  Button(String name,String usage,int x,int y,int w,int h){
    b_x = x;
    b_y = y;
    b_w = w;
    b_h = h;
    
    b_name = name;
    b_usage = usage;
    fill(SKY);
    rect(b_x,b_y,b_w,b_h);
    fill(0);
    text(b_name,x+5,y+20);
  }
  void b_draw(){
    fill(GREEN);
    rect(b_x,b_y,b_w,b_h);
    fill(0);
    text(b_name,b_x+5,b_y+20);
  }
    
  
  
  void b_pressed(){
    if(mouseX>b_x && mouseX<b_x+b_w && mouseY>b_y && mouseY<b_y+b_h && mousePressed==true){
      println("button was pressed");
      if(b_usage=="LINK"){
        link("https://twitter.com/intent/tweet?&url=http://hirohirogeek.github.io/tennis_game/processing.html&text=%E5%A3%81%E6%89%93%E3%81%A1%E3%82%B2%E3%83%BC%E3%83%A0%EF%BC%81%EF%BC%81%E3%82%B9%E3%82%B3%E3%82%A2"+str(score)+"%E7%82%B9");
      }
    }
  }
}
