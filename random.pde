void setup(){
  size(400,400);
  background(255);
}

void draw(){
  
}

void mouseClicked(){
  background(255);
  fill(255,0,0);
  noStroke();
  for(int i=0;i<1000;i++){
    ellipse(random(400),random(400),2,2);
  }
}
