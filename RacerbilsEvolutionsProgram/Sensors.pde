class SensorSystem {
  //SensorSystem - alle bilens sensorer - ogå dem der ikke bruges af "hjernen"
  
  //fitnes
  int fitness = 0;
  int goalPlus = 300; // goal points
  
  String[] goals = new String[3]; // red green blue 
  Boolean gotGoal = false;
  boolean leading = false;
  
  //prevent spinning:
  
  
  //wall detectors
  float sensorMag = 50;
  float sensorAngle = PI*2/8;
  
  PVector anchorPos           = new PVector();
  
  PVector sensorVectorFront   = new PVector(0, sensorMag);
  PVector sensorVectorLeft    = new PVector(0, sensorMag);
  PVector sensorVectorRight   = new PVector(0, sensorMag);

  boolean frontSensorSignal   = false;
  boolean leftSensorSignal    = false;
  boolean rightSensorSignal   = false;

  //crash detection
  int whiteSensorFrameCount    = 0; //udenfor banen

  //clockwise rotation detection
  PVector centerToCarVector     = new PVector();
  float   lastRotationAngle   = -1;
  float   clockWiseRotationFrameCounter  = 0;

  //lapTime calculation
  boolean lastGreenDetection;
  int     lastTimeInFrames      = 0;
  int     lapTimeInFrames       = 10000;

  // car coloring:
  int maks = 100;
  int min = -1;
  boolean best = false;

  void displaySensors() {
    strokeWeight(0.5);
    if (frontSensorSignal) { 
      fill(255, 0, 0);
      ellipse(anchorPos.x+sensorVectorFront.x, anchorPos.y+sensorVectorFront.y, 8, 8);
    }
    if (leftSensorSignal) { 
      fill(255, 0, 0);
      ellipse( anchorPos.x+sensorVectorLeft.x, anchorPos.y+sensorVectorLeft.y, 8, 8);
    }
    if (rightSensorSignal) { 
      fill(255, 0, 0);
      ellipse( anchorPos.x+sensorVectorRight.x, anchorPos.y+sensorVectorRight.y, 8, 8);
    }
    line(anchorPos.x, anchorPos.y, anchorPos.x+sensorVectorFront.x, anchorPos.y+sensorVectorFront.y);
    line(anchorPos.x, anchorPos.y, anchorPos.x+sensorVectorLeft.x, anchorPos.y+sensorVectorLeft.y);
    line(anchorPos.x, anchorPos.y, anchorPos.x+sensorVectorRight.x, anchorPos.y+sensorVectorRight.y);


    // determine car color
    if (!best && !leading){
    float colorVal = map(fitness, -105, maks, 0, 255);
    strokeWeight(2);
    fill(255-colorVal, colorVal, 0);
   // fill(0, clockWiseRotationFrameCounter, 0); //color car
    ellipse(anchorPos.x, anchorPos.y, 10, 10);
    }
    else if (best){
      strokeWeight(3);
      fill(0, 0, 255);
      ellipse(anchorPos.x, anchorPos.y, 15, 15);
      //println("colorbest");
    }
    else{
      strokeWeight(3);
      fill(64,224,208);
      ellipse(anchorPos.x, anchorPos.y, 15, 15);
    }
  }


  void updateSensorsignals(PVector pos, PVector vel) {
    //Collision detectors
    frontSensorSignal = get(int(pos.x+sensorVectorFront.x), int(pos.y+sensorVectorFront.y))==-1?true:false;
    leftSensorSignal = get(int(pos.x+sensorVectorLeft.x), int(pos.y+sensorVectorLeft.y))==-1?true:false;
    rightSensorSignal = get(int(pos.x+sensorVectorRight.x), int(pos.y+sensorVectorRight.y))==-1?true:false;  
    //Crash detector
    colorMode(RGB);
    color color_car_position = get(int(pos.x), int(pos.y));
    
    
    
    if (color_car_position ==-1) {
      //whiteSensorFrameCount = whiteSensorFrameCount+1;
      fitness -= fitness < -100 ? 0 : 0.5; // lower limit
    }
    //Laptime calculation
    boolean currentlyOnColor =false;
    if (red(color_car_position)==0 && blue(color_car_position)==0 && green(color_car_position)>240) {//den grønne målstreg er detekteret
    goals[1] = "green";
      currentlyOnColor = true;
    }
 
    if (red(color_car_position)==0 && blue(color_car_position)>240 && green(color_car_position)==0) {//den blå målstreg er detekteret
    goals[2] = "blue";
      currentlyOnColor = true;
    }
 
    if (red(color_car_position)>240 && blue(color_car_position)==0 && green(color_car_position)==0) {//den røde målstreg er detekteret
    goals[0] = "red";
      currentlyOnColor = true;
    }
    
    //if (lastGreenDetection && !currentlyOnColor) {  //sidst grønt - nu ikke -vi har passeret målstregen 
    //  lapTimeInFrames = frameCount - lastTimeInFrames; //LAPTIME BEREGNES - frames nu - frames sidst
    //  lastTimeInFrames = frameCount;
   //   
   // }
    
    if (!currentlyOnColor){ // win
      if (goals[0] == "red" && goals[1] == "green" && goals[2] == "blue"){
      lapTimeInFrames = frameCount - lastTimeInFrames; //LAPTIME BEREGNES - frames nu - frames sidst
      lastTimeInFrames = frameCount;
        float lapTimePunish = map(lapTimeInFrames, 0, 1000, 0, 100) < 200 ? map(lapTimeInFrames, 0, 1000, 0, 100) : 200; // limit to punishment
        fitness += goalPlus - int(lapTimePunish);
        //println(int(lapTimePunish));
        //println(this.fitness);
        for (int i = 0; i < 3; i++){
         goals[i] = "";
        }
        
    
      }
      
    }
    
    //count clockWiseRotationFrameCounter
    centerToCarVector.set((height/2)-pos.x, (width/2)-pos.y);    
    float currentRotationAngle =  centerToCarVector.heading();
    float deltaHeading   =  lastRotationAngle - centerToCarVector.heading();
    clockWiseRotationFrameCounter  =  deltaHeading>0 ? clockWiseRotationFrameCounter + 1 : clockWiseRotationFrameCounter -1;
    lastRotationAngle = currentRotationAngle;
    
    updateSensorVectors(vel);
    
    anchorPos.set(pos.x,pos.y);
  }

  void updateSensorVectors(PVector vel) {
    if (vel.mag()!=0) {
      sensorVectorFront.set(vel);
      sensorVectorFront.normalize();
      sensorVectorFront.mult(sensorMag);
    }
    sensorVectorLeft.set(sensorVectorFront);
    sensorVectorLeft.rotate(-sensorAngle);
    sensorVectorRight.set(sensorVectorFront);
    sensorVectorRight.rotate(sensorAngle);
  }
}
