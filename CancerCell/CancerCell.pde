//Peace Okoko
//Programming Nature
//09/22/2020
//Keri-Ann
//Lab 3


CellWalker[] c;

PVector source;
float time;


void setup() {
  
  size(1200, 600);
  // Create a walker object
  c = new CellWalker [25];
  for (int i = 0; i < c.length; i++) {
    c[i] = new CellWalker(random(0.5,1), 600, random(height));
    fill(random (55),random(55),random(55));
  }
 
  
  source=new PVector(50,300);
  
  background(255);
}

void draw() {
 background(255);
  
 
  for (int i = 0; i < c.length; i++) {
    
    
    //Introducing and applying friction

    float a=0.0001;
    PVector friction= c[i].velocity.get();
    friction.mult(-1);
    friction.normalize();
    friction.mult(a);
    fill(255, 0, 0);
    
    //Apply drag
    if (c[i].isInside(source)) {
    c[i].drag();
    
    }
    c[i].applyForce(friction);
    
    c[i].step(source);
    c[i].update();
    c[i].testHit(source);
    c[i].display();
    c[i].checkEdges();
    
  }
  
  fill(255, 0, 0);
    ellipse(source.x,source.y, 50,50);
  
}
