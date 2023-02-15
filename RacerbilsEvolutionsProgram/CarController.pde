class CarController {
  //Forbinder - Sensorer & Hjerne & Bil
  float varians             = 2; //hvor stor er variansen på de tilfældige vægte og bias
  Car bil                    = new Car();
  NeuralNetwork hjerne       = new NeuralNetwork(varians); 
  SensorSystem  sensorSystem = new SensorSystem();
  int id;

  //int maks = 1; // to determine colors.
  //int min = -1;
  
  CarController(int _id){
    this.id = _id;

  }
  
      
  void update() {
    //1.)opdtarer bil 
    bil.update();
    //2.)opdaterer sensorer    
    sensorSystem.updateSensorsignals(bil.pos, bil.vel);
    //3.)hjernen beregner hvor meget der skal drejes
    float turnAngle = 0;
    float x1 = int(sensorSystem.leftSensorSignal);
    float x2 = int(sensorSystem.frontSensorSignal);
    float x3 = int(sensorSystem.rightSensorSignal);    
    turnAngle = hjerne.getOutput(x1, x2, x3);    
    //4.)bilen drejes
    bil.turnCar(turnAngle);
       
  }
  
  void display(){
    bil.displayCar();
    sensorSystem.displaySensors();
  }
  
  void mutate(CarController cc, float mutationSize){
     resetCar();
     //generation:
     //gen++;
     //mutationSize -= mutationSize - gen/20 > 0 ? gen/20 : 0; // decreases mutation size.
     
     for(int i=0; i < hjerne.weights.length -1; i++){
      hjerne.weights[i] = cc.hjerne.weights[i] + random(-mutationSize,mutationSize); // gør hjernen til næsten det samme.
    }
    for(int i=0; i < hjerne.biases.length -1; i++){
      hjerne.biases[i] = cc.hjerne.biases[i] + random(-mutationSize,mutationSize);
    } 
    
  }
  
  void resetCar(){
    bil = new Car();
    sensorSystem = new SensorSystem();
    
  }
  
}
