//Peace Okoko
//Programming Nature
//09/22/2020
//Keri-Ann
//Lab 3
class CellWalker {
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector force;

  //For the time
  boolean hitSource;
  float count;
  float topspeed, mass;


  CellWalker(float m, float x, float y) {
    //Constructor - initialization + Define initial location
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(-0.001, 0.01);
    topspeed=5;
    mass=m;

    //To count how long it takes
    count = 0;
    hitSource = false;
   
  }
  void update() {
    velocity.add(acceleration);
    velocity.limit(topspeed);
    position.add(velocity);
    acceleration.mult(0);
  }
  void applyForce(PVector force) {
    PVector f=force.get();
    f.div(mass);
    acceleration.add(f);
  }
  void step(PVector s) {
    float r = random(1);
    // A 1/3 of moving randomly in -x direction
    if (r <= 0.3 ) {   
      PVector k= new PVector(random(-5,5), random(-5,5));
      applyForce(k);

      //1/3 chance of moving towards source
    } else if (r <= 0.6) {
      PVector dir = s.copy();
      dir.sub(position);
      dir.normalize();
      acceleration=dir;

      update();
      //1/3 chnace of moving to ECM
    } else {
      PVector l=new PVector(0.00000001, 0.00000001);
      applyForce(l);
     
    }
  }

  //Test if it has hit the source
  void testHit(PVector s) {
    float dist = dist(s.x, s.y, position.x, position.y);
    time = millis();
    if (dist < 25 && hitSource == false) {

      println(time/1000);
      hitSource = true;
    } else {
      count++;
    }
  }

  boolean isInside(PVector l) {
    float dist = dist(l.x, l.y, position.x, position.y);
    if (dist < 25)
    {
      return true;
    } else {
      return false;
    }
  }

  void drag() {
    
    float speed=velocity.mag();
    float c=0.1;
    float dragMagnitude=c*speed*speed;
    PVector drag=velocity.get();
    drag.mult(-1);
    drag .normalize();
   //Finalizing the forces
    drag.mult(dragMagnitude);
    applyForce(drag);
    
  }


  void display() {
    
    //display as a stroke - point
    fill(random(255), random(255), random(255));
    ellipse(position.x, position.y, mass*10, mass*10);
    
  }
  void checkEdges() {
    
    //Bounces when edges are reached 
    if (position.x>width) {
      position.x=width;
      position.x*=-1;
    } else if (position.x< 0) {
      velocity.x*=-1;
      position.x=0;
    }
    if (position.y>height) {
      velocity.y*=-1;
      position.y=height;
      
    }
  }
}
