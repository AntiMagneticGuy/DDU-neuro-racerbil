class CarSystem {
  //CarSystem - 
  //Her kan man lave en generisk alogoritme, der skaber en optimal "hjerne" til de forhåndenværende betingelser
  
  ArrayList<CarController> CarControllerList  = new ArrayList<CarController>();

  CarSystem(int populationSize) {
    for (int i=0; i<populationSize; i++) { 
      CarController controller = new CarController(i);
      CarControllerList.add(controller);
    }
  }

  void updateAndDisplay() {
    //1.) Opdaterer sensorer og bilpositioner
    for (CarController controller : CarControllerList) {
      controller.update();
    }

    //2.) Tegner tilsidst - så sensorer kun ser banen og ikke andre biler!
    for (CarController controller : CarControllerList) {
      controller.display();
    }
  }
  
  //CarSystem nextGen(){
     void nextGen(){
    // sort list
    
    // top 10 survives, is used to mutate the rest.
    // also resets position.
    println(CarControllerList.get(0).id);
    CarControllerList.sort(new carComparator());
    println(CarControllerList.get(0).id + ": "+ CarControllerList.get(0).sensorSystem.fitness);
    
   // for (CarController controller : CarControllerList) {
   //   controller.update();
   // }
    
    //return ;
  }
  
}
