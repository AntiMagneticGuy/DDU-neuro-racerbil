//populationSize: Hvor mange "controllere" der genereres, controller = bil & hjerne & sensorer
int       populationSize  = 110;     

//CarSystem: Indholder en population af "controllere" 
CarSystem carSystem       = new CarSystem(populationSize);


PImage    trackImage;

void setup() {
  size(500, 600);
  trackImage = loadImage("track.png");
}

void draw() {
  clear();
  fill(255);
  rect(0,0,width,height);
  image(trackImage,0,80);  

  carSystem.updateAndDisplay();
  
    if (true){
     textSize(25);
     fill(0,0,255);
      text("Runder overlevet: " + carSystem.repeat, 10, height -100);
    }
    
    if (carSystem.CarControllerList.get(0).sensorSystem.fitness > 10){ // er en bil kørt over målstregen
      textSize(30);
     fill(0,0,0);
      text("En bil er kørt over stregen: ", 10, height -60);
      text("klik for at lave evolution: ", 10, height -30);
    }
    fill(0,0,0); // status
    textSize(20);
    text("Mutation variation: "+ carSystem.mutationSize, 250, 20);
    text("Generation: "+ int(carSystem.gen), 10, 20);
}

void mouseReleased(){ // kan kun evolutionere når en bil er kørt over stregen
   if (carSystem.CarControllerList.get(0).sensorSystem.fitness > 10){ 
      carSystem.nextGen();
   }
  
}
