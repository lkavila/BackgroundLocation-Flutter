import 'dart:async';
import 'package:background_location/background_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeviceLocation {
 BackgroundLocation location = new BackgroundLocation();
 double distancia;
 double tiempo;
 List<double> veloPromedio;
 List<double> datos;
 double velocidadProm;
 StreamController<Location> currentLocationStream;


  DeviceLocation(){
  veloPromedio = [];
  velocidadProm = 0;
  distancia = 0;
  tiempo = 0;
  currentLocationStream =  StreamController<Location>.broadcast();
  startUpdates();
  }

 Future<LatLng> getMyCurrentLocation() async{
  Location value = await location.getCurrentLocation();
  return LatLng(value.latitude, value.longitude);
  }

  stopUpdates(){
    BackgroundLocation.stopLocationService();
  }

  startUpdates(){
    BackgroundLocation.getPermissions(
      onGranted: () {
        print("Permisos otorgados");
        BackgroundLocation.startLocationService();
        BackgroundLocation.setAndroidNotification(
          title: "Ha empezado su ruta",
                message: "Se van a ir guardando los datos de su recorrido aún en segundo plano",
                icon: "@mipmap/ic_launcher",
        );
        BackgroundLocation.getLocationUpdates((value){
            currentLocationStream.add(value);
            tiempo = tiempo + 0.5;
            if(value.speed>1){
              veloPromedio.add(value.speed);//la velocidad promedio solo se actualiza si la velocidad actual es mayor a 1m/s
              velocidadProm = veloPromedio.reduce((value, element) => value+element)/veloPromedio.length;
              distancia = distancia + value.speed;
              print(distancia);
            }    
        });

      },
      onDenied: () {
        // Show a message asking the user to reconsider or do something else
      },
    );
  }
/* callGetCurrentLocation(SendPort sendPort){
    location.hasPermission().then((value) {
      if (value == PermissionStatus.denied) {
        location.requestPermission().then((value) {
          if (value == PermissionStatus.granted) {
            getCurrentLocation(sendPort);
          }
        });
      } else if (value == PermissionStatus.granted) {
        getCurrentLocation(sendPort);
      }
    });
  }
  

Future<void>  requestPermission() async{
    location.hasPermission().then((value) async{
      print("asffsa");
      if (value == PermissionStatus.denied) {
        await location.requestPermission();
      }
    });
  }

 main(String args){
      print("getCurrentLocation");
      location.getLocation().then((value) {
        print(value.accuracy);
        //currentLocationStream.add(value);
        veloPromedio.add(value.speed);

        velocidadProm = veloPromedio.reduce((value, element) => value+element)/veloPromedio.length;
        tiempo = tiempo + 1;
        distancia = distancia + value.speed;
        print(distancia);
        datos.add(velocidadProm);
        datos.add(tiempo);
        datos.add(distancia);
    });
  }
 getCurrentLocation(String args) {
    Timer.periodic(new Duration(seconds: 1), (Timer t) {
      _counter++;
      String msg = 'notification ' + _counter.toString();      
      print('SEND: ' + msg);
    });
}
*/
}
