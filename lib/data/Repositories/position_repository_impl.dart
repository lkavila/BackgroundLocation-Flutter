import 'package:background_processes/data/localDataSource/device_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:background_processes/Domain/Repositories/postition_repository.dart';

class PositionRepositoryImpl extends PositionRepository{
  DeviceLocation _deviceLocation = new DeviceLocation();

  @override
  Future<LatLng> getMyCurrentLocation(){
    
    return _deviceLocation.getMyCurrentLocation();//this will not work, need the real deviceLocation instance
  }

  @override
  void stopUpdates(){
    _deviceLocation.stopUpdates();
  }

  @override
  void startUpdates(){
    _deviceLocation.startUpdates(); //this will not work, need the real deviceLocation instance
  }

}