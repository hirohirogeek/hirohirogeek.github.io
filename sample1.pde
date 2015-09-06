void setup(){
 size(300,300); 
}

void draw(){
  background(255);
  noStroke();
  fill(0,mouseX,mouseY);
  ellipse(width/2,height/2,mouseX,mouseY);
}
