class Button{
  int b_x, b_y, b_w, b_h;
  String b_name,b_usage;
  color col;
  Button(String name,String usage,int x,int y,int w,int h,color c){
    b_x = x;
    b_y = y;
    b_w = w;
    b_h = h;
    col = c;
    
    b_name = name;
    b_usage = usage;
    fill(col);
    rect(b_x,b_y,b_w,b_h);
    fill(0);
    text(b_name,x+5,y+30);
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
        if(money-100000>0){
          link("https://twitter.com/intent/tweet?&url=http://hirohirogeek.github.io/trade_game/trade_game.html&text=%E4%B8%80%E5%88%86%E9%96%93%E3%83%88%E3%83%AC%E3%83%BC%E3%83%80%E3%83%BC%EF%BC%81"+str(money-100000)+"%E5%86%86%E3%81%AE%E5%88%A9%E7%9B%8A%E3%82%92%E5%BE%97%E3%81%BE%E3%81%97%E3%81%9F%EF%BC%81");
          
        }else if(money-100000<0){
          link("https://twitter.com/intent/tweet?&url=http://hirohirogeek.github.io/trade_game/trade_game.html&text=%E4%B8%80%E5%88%86%E9%96%93%E3%83%88%E3%83%AC%E3%83%BC%E3%83%80%E3%83%BC%EF%BC%81"+str(abs(money-100000))+"%E5%86%86%E6%90%8D%E5%A4%B1%E3%81%97%E3%81%BE%E3%81%97%E3%81%9F%EF%BC%81"); 
          
        }else{
          link("https://twitter.com/intent/tweet?&url=http://hirohirogeek.github.io/trade_game/trade_game.html&text=%E4%B8%80%E5%88%86%E9%96%93%E3%83%88%E3%83%AC%E3%83%BC%E3%83%80%E3%83%BC%EF%BC%81%E3%83%97%E3%83%A9%E3%83%9E%E3%82%A4%E3%82%BC%E3%83%AD");     
        }
      }else if(b_usage=="RETRY"){
        scene = 0;
        initialize();
      }else if(b_usage=="START"){
        scene = 1;
      }else if(b_usage=="BUY"){
        Buy();
      }else if(b_usage=="SELL"){
        Sell();  
      }
    }
  }
}
