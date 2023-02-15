import java.util.Comparator;

class carComparator implements Comparator {

 int compare(Object car1, Object car2) {
   
   Integer fit1 = ((CarController) car1).sensorSystem.fitness;
   Integer fit2 = ((CarController) car2).sensorSystem.fitness;
   return fit2.compareTo(fit1);
  // String str1 = ((A) o1).getStr();
   //String str2 = ((A) o2).getStr();
   //return str1.compareTo(str2);
 }
}
