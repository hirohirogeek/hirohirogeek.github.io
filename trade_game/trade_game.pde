/* @pjs font="font01.ttf"; */

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
color mes_color;

int[][] plot_points = new int[60][2];
int[] moti_kabu_prop = new int[10];

PFont myFont;

Button st;
Button buy;
Button sell;
Button tweet;
Button retry;

void setup(){
  size(400,400);
  frameRate(20);
  
  myFont = createFont("font01.ttf", 32);
  textFont(myFont);
}

void draw(){
  if(scene==0)St();
  if(scene==1)Kabu_main();
  if(scene==2)End();
}

void St(){
  background(0);
  textSize(36);
  fill(255);
  text("一分間トレーダー",50,180);
  textSize(16);
  text("Copyright(C)2015 hirogeek",30,380);
  st = new Button("START","START",160,230,80,40,GREEN);
}

void Kabu_main(){
  background(0);
  
  //
  if(frameCount%20==0){
    time+=1;
    nokori_time -=1;
    kabuka_d = int(random(-100,100));
    kabuka+= kabuka_d;
    if(kabuka<100){
      kabuka = 100;
      kabuka_d = 0;
    }
    plot_points[time-1][0] = 20+time*5; 
    plot_points[time-1][1] = 210 - int(float(kabuka)/float(10));
    
  }
  
  
  fill(255);
  textSize(32);
  text("MONEY:"+str(money)+"円",20,320);
  text("持ち株数:"+str(moti_kabu),20,360);
  text("残り時間:"+str(nokori_time)+"秒",20,30);
  text("株価:"+str(kabuka)+"円/1株",20,60);
  
  //plot
  fill(255);
  noStroke();
  rect(20,110,2,100);
  rect(20,210,300,2);
  for(int i=0; i<time; i++){
    ellipse(plot_points[i][0],plot_points[i][1],5,5);
  }
  stroke(1);
  
  buy = new Button("10株買う","BUY",20,230,150,50,RED);
  sell = new Button("10株売る","SELL",180,230,150,50,BLUE);
  
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

void End(){
  textSize(16);
  fill(255,255,100,100);
  rect(20,50,360,300);
  fill(0);
  text("RESULT",70,80);
  text("MONEY:"+str(money)+"円",70,100);
  textSize(24);
  
  if(money-100000>0){
    fill(BLUE);
    text(money-100000+"円の利益を得ました",70,150);
  }else if(money-100000<0){
    fill(RED);
    text(abs(money-100000)+"円損失しました",70,150);  
  }
  textSize(16);
  tweet = new Button("結果をtweet","LINK",70,210,150,35,SKY);
  retry = new Button("もういちど","RETRY",70,250,100,35,GREEN);
}

void Buy(){
  if(money<kabuka*10){
    mes_flag = 1;
    mes_time = time;
    mes = "MONEYがたりません";
    mes_color = YELLOW;
  }else if(moti_kabu==100){
    mes_flag = 1;
    mes_time = time;
    mes = "これ以上株を持てません";
    mes_color = YELLOW;
  }else{
    moti_kabu += 10;
    money -= kabuka*10;
    mes_flag = 1;
    mes_time = time;
    mes = "10株買いました";
    mes_color = RED;
    moti_kabu_prop[(moti_kabu/10)-1] = kabuka;
  }
}

void Sell(){
  if(moti_kabu<10){
    mes_flag = 1;
    mes_time = time;
    mes = "持ち株がありません";
    mes_color = YELLOW;
  }else{
    moti_kabu -= 10;
    money += kabuka*10;
    mes_flag = 1;
    mes_time = time;
    mes = "10株売りました";
    mes_color = BLUE;
  }
}

void initialize(){
  scene = 0;
  nokori_time = 60;
  time = 0;
  kabuka = 1000;
  money = 100000;
  moti_kabu = 0;
  mes_flag = 0;
}


