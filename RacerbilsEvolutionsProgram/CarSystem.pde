class CarSystem {
  //CarSystem - 
  //Her kan man lave en generisk alogoritme, der skaber en optimal "hjerne" til de forhåndenværende betingelser
  
  ArrayList<CarController> CarControllerList  = new ArrayList<CarController>();
  int repeat = 0; // har én af de bedste biler overlevet til næste runde? Hvis ja, hvor mange gange i træk?.
  int popSize = 0; //population Size
  float mutationSize = 0.5; // hvor meget de muterer. Går ned hver generation.
  float gen = 1; //generationen

  CarSystem(int populationSize) {
    popSize = populationSize;
    for (int i=0; i<populationSize; i++) { 
      CarController controller = new CarController(i);
      CarControllerList.add(controller);
    }
  }

  void updateAndDisplay() {
    // sorterer:
    CarControllerList.sort(new carComparator());
    //finder minimum og maksimum værdi (af fitness):
    int maks = CarControllerList.get(0).sensorSystem.fitness > 1 ? CarControllerList.get(0).sensorSystem.fitness : 1;
    int min = CarControllerList.get(CarControllerList.size()-1).sensorSystem.fitness < -1 ? CarControllerList.get(CarControllerList.size()-1).sensorSystem.fitness : -1;
    
    //1.) Opdaterer sensorer og bilpositioner
    for (CarController controller : CarControllerList) {
      controller.update();
      controller.sensorSystem.maks = maks;
      controller.sensorSystem.min = min;
      
    }

    //2.) Tegner tilsidst - så sensorer kun ser banen og ikke andre biler!
    CarController cc = CarControllerList.get(0);
    for (CarController controller : CarControllerList) {
      if (!controller.sensorSystem.best)
      {
      controller.display();
      }
      else{
       cc = controller;
       //println("best:", cc.id);
      }
    }
    if (gen > 1){
    cc.display();
    }
  }
  
  //CarSystem nextGen(){
     void nextGen(){
    // sort list
    CarControllerList.sort(new carComparator());
    // top 10 survives, is used to mutate the rest.
    // also resets position.
    println("Fittest car ", " id: "+ CarControllerList.get(0).id + ", score: "+ CarControllerList.get(0).sensorSystem.fitness);
    
   
   for (int i = 0; i < CarControllerList.size(); i++) {
     CarController cc = CarControllerList.get(i);
     if (i == 0){
       repeat = cc.id == 0 ? 1+repeat : 0; // var denne vil også den bedste sidste gang?
       //cc.sensorSystem.best = true; // colors blue if leading
       cc.resetCar();
     }
     else if (i < 10){
       cc.resetCar();
       cc.sensorSystem.best = false;
     }
     else if (i >= 10){
       cc.mutate(CarControllerList.get(i%10), mutationSize);
       cc.sensorSystem.best = false;
     }
     cc.id = i;
    
   }
   CarControllerList.get(0).sensorSystem.best = true;
   // println(gen/20,": ",mutationSize);
   // println((mutationSize - gen));
     gen++;
     mutationSize -= (mutationSize - (gen/100)) > 0 ? gen/100 : 0; // decreases mutation size.
  }
  
}
