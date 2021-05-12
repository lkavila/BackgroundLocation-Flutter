import 'package:get/get.dart';

class CounterController extends GetxController{
  int conter=0;

  increment(){
    conter++;
    update();
  }

}