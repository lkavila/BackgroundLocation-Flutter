import 'package:background_processes/data/localDataSource/device_location.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:background_processes/Domain/UseCases/get_current_location.dart';
import 'package:background_processes/Domain/UseCases/start_updates.dart';
import 'package:background_processes/Domain/UseCases/stop_updates.dart';

class PositionController extends GetxController{
  bool running = false;
  DeviceLocation deviceLocation;
  int conter=0;
  Location location = new Location();
  bool _serviceEnabled;
  increment(){
    conter++;
    update();
  }

  start() async{
    print("starting");
    await requestGPS();
    deviceLocation = new DeviceLocation();
    running = true;
    update();
  }

  Future<LatLng> getCurrentLocation() async{
     return await deviceLocation.getMyCurrentLocation();
  }

 Future<void> requestGPS() async{
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
  }

  stop(){
    final StopUseCase stopUseCase = StopUpdates();
    stopUseCase.call();
    deviceLocation = null;
    running = false;
    update();
  }



}