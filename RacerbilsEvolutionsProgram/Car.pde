class Car {  
  //Bil - indeholder position & hastighed & "tegning"
  PVector pos = new PVector(60, 232);
  PVector vel = new PVector(0, 5);
  
  void turnCar(float turnAngle){
    vel.rotate(turnAngle);
  }

  void checkBounds(){ // checker om bilen er kørt ud af mappet
    if (pos.x > width || pos.x < 0){
      pos.x = pos.x > width ? width-3 : 3;
    }
    if (pos.y > height || pos.y < 0){
      pos.y = pos.y > height ? height-3 : 3;
    }
    
  }


  void displayCar(boolean best) {
    checkBounds();
    stroke(100);
    fill(100);
    ellipse(pos.x, pos.y, 10, 10);
  }
  
  void update() {
    pos.add(vel);
  }
  
}
