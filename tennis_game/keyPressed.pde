void tennis_key_move(){
  if(keyPressed==true){
  if(key==CODED){
    switch(keyCode){
      case LEFT:
      tp.x -= 3;
      break;
      case RIGHT:
      tp.x += 3;
      break;
    }
    
    
  }
  if(key=='a' && frameCount-pre_fc >=5){
      tp.hit(1.1);
      
      println("key pressed");
      pre_fc = frameCount;
  }
  if(key=='s' && frameCount-pre_fc >=5){
      tp.hit(1.3);
      
      println("key pressed");
      pre_fc = frameCount;
    }
    
  }
  
}

void start_key(){
  if(keyPressed==true){
    if(key==ENTER || key==RETURN){
      
      println("key pressed");
      tennis_game_scene=1;
      TIME = 60;
      
    }
  }
}


