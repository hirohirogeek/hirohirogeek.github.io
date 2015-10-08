void mousePressed(){
  if(mouseButton==LEFT){
    if(scene==0){
      st.b_pressed();
    }else if(scene==1){
      buy.b_pressed();
      sell.b_pressed();  
    }else if(scene==2){
    
      tweet.b_pressed();
      retry.b_pressed();  
      
  }  
}
}
