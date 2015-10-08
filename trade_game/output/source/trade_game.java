import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class trade_game extends PApplet {



int scene = 0;
int nokori_time = 60;
int time = 0;
int kabuka = 1000;
int money = 100000;
int kabuka_d = 0;
int moti_kabu = 0;

String mes;
int mes_flag = 0;
int mes_time = 0;
int mes_color;

int[][] plot_points = new int[60][2];
int[] moti_kabu_prop = new int[10];

PFont myFont;

Button st;
Button buy;
Button sell;
Button tweet;
Button retry;

public void setup(){
  size(400,400);
  frameRate(20);
  
  //myFont = createFont("font01.ttf", 32);
  //textFont(myFont);
}

public void draw(){
  if(scene==0)St();
  if(scene==1)Kabu_main();
  if(scene==2)End();
}

public void St(){
  background(0);
  textSize(36);
  fill(255);
  text("\u4e00\u5206\u9593\u30c8\u30ec\u30fc\u30c0\u30fc",50,180);
  textSize(16);
  text("Copyright(C)2015 hirogeek",30,380);
  st = new Button("START","START",160,230,80,40,GREEN);
}

public void Kabu_main(){
  background(0);
  
  //
  if(frameCount%20==0){
    time+=1;
    nokori_time -=1;
    kabuka_d = PApplet.parseInt(random(-100,100));
    kabuka+= kabuka_d;
    if(kabuka<100){
      kabuka = 100;
      kabuka_d = 0;
    }
    plot_points[time-1][0] = 20+time*5; 
    plot_points[time-1][1] = 210 - PApplet.parseInt(PApplet.parseFloat(kabuka)/PApplet.parseFloat(10));
    
  }
  
  
  fill(255);
  textSize(32);
  text("MONEY:"+str(money)+"\u5186",20,320);
  text("\u6301\u3061\u682a\u6570:"+str(moti_kabu),20,360);
  text("\u6b8b\u308a\u6642\u9593:"+str(nokori_time)+"\u79d2",20,30);
  text("\u682a\u4fa1:"+str(kabuka)+"\u5186/1\u682a",20,60);
  
  //plot
  fill(255);
  noStroke();
  rect(20,110,2,100);
  rect(20,210,300,2);
  for(int i=0; i<time; i++){
    ellipse(plot_points[i][0],plot_points[i][1],5,5);
  }
  stroke(1);
  
  buy = new Button("10\u682a\u8cb7\u3046","BUY",20,230,150,50,RED);
  sell = new Button("10\u682a\u58f2\u308b","SELL",180,230,150,50,BLUE);
  
  //moti_kabu_properies
  fill(255);
  textSize(16);
  for(int i=0; i<moti_kabu/10; i++){
    text(moti_kabu_prop[i]+"x10",320,100+i*30);
  }
  
  
  //kabuka_no_henka
  if(kabuka_d>0){
    fill(0,0,255); //BLUE
    text("+"+kabuka_d,20,90); 
  }else if(kabuka_d<0){
    fill(255,0,0);
    text(kabuka_d,20,90);
  }
  
  //message
  if(mes_flag==1){
    textSize(16);
    fill(mes_color);
    text(mes,20,380);
    if(mes_time+2 == time)mes_flag=0;
  }
  
  if(nokori_time==0)scene = 2; //End
}

public void End(){
  textSize(16);
  fill(255,255,100,100);
  rect(20,50,360,300);
  fill(0);
  text("RESULT",70,80);
  text("MONEY:"+str(money)+"\u5186",70,100);
  textSize(24);
  
  if(money-100000>0){
    fill(BLUE);
    text(money-100000+"\u5186\u306e\u5229\u76ca\u3092\u5f97\u307e\u3057\u305f",70,150);
  }else if(money-100000<0){
    fill(RED);
    text(abs(money-100000)+"\u5186\u640d\u5931\u3057\u307e\u3057\u305f",70,150);  
  }
  textSize(16);
  tweet = new Button("\u7d50\u679c\u3092tweet","LINK",70,210,150,35,SKY);
  retry = new Button("\u3082\u3046\u3044\u3061\u3069","RETRY",70,250,100,35,GREEN);
}

public void Buy(){
  if(money<kabuka*10){
    mes_flag = 1;
    mes_time = time;
    mes = "MONEY\u304c\u305f\u308a\u307e\u305b\u3093";
    mes_color = YELLOW;
  }else if(moti_kabu==100){
    mes_flag = 1;
    mes_time = time;
    mes = "\u3053\u308c\u4ee5\u4e0a\u682a\u3092\u6301\u3066\u307e\u305b\u3093";
    mes_color = YELLOW;
  }else{
    moti_kabu += 10;
    money -= kabuka*10;
    mes_flag = 1;
    mes_time = time;
    mes = "10\u682a\u8cb7\u3044\u307e\u3057\u305f";
    mes_color = RED;
    moti_kabu_prop[(moti_kabu/10)-1] = kabuka;
  }
}

public void Sell(){
  if(moti_kabu<10){
    mes_flag = 1;
    mes_time = time;
    mes = "\u6301\u3061\u682a\u304c\u3042\u308a\u307e\u305b\u3093";
    mes_color = YELLOW;
  }else{
    moti_kabu -= 10;
    money += kabuka*10;
    mes_flag = 1;
    mes_time = time;
    mes = "10\u682a\u58f2\u308a\u307e\u3057\u305f";
    mes_color = BLUE;
  }
}

public void initialize(){
  scene = 0;
  nokori_time = 60;
  time = 0;
  kabuka = 1000;
  money = 100000;
  moti_kabu = 0;
  mes_flag = 0;
}


class Button{
  int b_x, b_y, b_w, b_h;
  String b_name,b_usage;
  int col;
  Button(String name,String usage,int x,int y,int w,int h,int c){
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
  public void b_draw(){
    fill(GREEN);
    rect(b_x,b_y,b_w,b_h);
    fill(0);
    text(b_name,b_x+5,b_y+20);
  }
    
  
  
  public void b_pressed(){
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
int RED    = color(255,0,0);
int GREEN  = color(0,255,0);
int BLUE   = color(0,0,255);
int YELLOW = color(255,255,0);
int SKY    = color(0,255,255);

int L_RED  = color (255,0,0,150);
public void mousePressed(){
  if(mouseButton==LEFT){
    switch(scene){
    case 0:
      st.b_pressed();
      break;
    case 1:
      buy.b_pressed();
      sell.b_pressed();  
      break;
    case 2:
      tweet.b_pressed();
      retry.b_pressed();  
      break;
  }  
}
}
public void setup(){
  size(400,400);
  background(255);
}

public void draw(){
  
}

public void mouseClicked(){
  background(255);
  fill(255,0,0);
  noStroke();
  for(int i=0;i<1000;i++){
    ellipse(random(400),random(400),4,4);
  }
}

public void setup(){
  size(200,200);  
}

public void draw(){
  background(0);
  fill(255);
  rect(10,10,180,180);  
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "trade_game" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
