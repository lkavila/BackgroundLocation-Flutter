import 'dart:async';
import 'package:background_processes/GetX/PositionController.dart';
import 'package:background_processes/utils/convertir_tiempo_distancia.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:background_location/background_location.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final _position = Get.put(PositionController());

  double lat = 10.90352;
  double lon = -74.79463;
  LatLng iniciallatLng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        GetBuilder<PositionController>(builder: (context) {
          if (_position.running) {
            return Align(
              alignment: Alignment.center,
              child: StreamBuilder<Location>(
                stream: _position.deviceLocation.currentLocationStream.stream,
                builder: (context, locationData) {
                  if (locationData.data != null) {
                    lat = locationData.data.latitude;
                    lon = locationData.data.longitude;
                    _goToTheLake();
                    double velocidad;
                    if (locationData.data.speed <= 1) {
                      velocidad = 0;
                    } else {
                      velocidad = locationData.data.speed;
                    }

                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.98,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: Color.fromRGBO(131, 110, 251, 0.95),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '  latitud: ' +
                                    locationData.data.latitude.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                '  longitud: ' +
                                    locationData.data.longitude.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                '  velocidad: ' +
                                    (velocidad * 3.6).toStringAsFixed(5) +
                                    ' km/h',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                '  velocidad promedio: ' +
                                    (_position.deviceLocation.velocidadProm *
                                            3.6)
                                        .toStringAsFixed(5) +
                                    ' km/h',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                '  distancia recorrida: ' +
                                    ConvertirTD.convertDistancia(
                                        _position.deviceLocation.distancia),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                '  tiempo: ' +
                                    ConvertirTD.convertirTiempo(
                                        _position.deviceLocation.tiempo),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          )),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            );
          } else {
            return Container(
              color: Colors.blue,
              child: Text("Dale Start"),
            );
          }
        }),
        GetBuilder<PositionController>(builder: (context) {
          return Align(
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      if (_position.running) {
                        _position.stop();
                      } else {
                        _position.start();
                      }
                    },
                    tooltip:
                        _position.running ? 'Process stop' : 'Process start',
                    child: _position.running
                        ? new Icon(
                            Icons.stop,
                            size: 30,
                          )
                        : new Icon(
                            Icons.play_arrow,
                            size: 40,
                          ),
                  ),
                  SizedBox(height: 10),
                  FloatingActionButton(
                      onPressed: _goToTheLake,
                      child: Icon(
                        Icons.search,
                        size: 30,
                      )),
                ],
              ));
        })
      ]),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition _kLake =
        new CameraPosition(target: LatLng(lat, lon), zoom: 16);
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
