import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class PositionRepository{

  Future<LatLng> getMyCurrentLocation();

  void stopUpdates(); 

  void startUpdates(); 

}