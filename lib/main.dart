import 'package:background_processes/GetX/conterController.dart';
import 'package:background_processes/presentation/mapa.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    home: MapSample()
    )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final position = Get.put(CounterController());
  Future<void> _run() async {

    final isolate = await FlutterIsolate.spawn(isolate1, "hello");
    Timer(Duration(seconds: 99), () {
      print("Pausing Isolate 1");
      isolate.pause();
    });
    Timer(Duration(seconds: 100), () {
      print("Killing Isolate 1");
      isolate.kill();
    });
  }
static void isolate1(String arg) {
  getTemporaryDirectory().then((dir) {
    print("isolate2 temporary directory: $dir");
  });
  
  Timer.periodic(
      Duration(seconds: 1), (timer) { 
        
      position.increment();
        print(position.conter);
        print("Timer Running From Isolate 2");
      });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body:Center(child:

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  ElevatedButton(
                    child: Text('Run'),
                    onPressed: _run,
                  ),
                 /* Builder(builder: (context){
                    if(position!=null){
                    return GetX<CounterController>(
                      builder: (context){
                          return  Text("Segundos: ${position.conter}");
                      }
                  );
                    }else{
                      
                      return Text("position is null");
                    }
                  }),
                  */

                  /*GetBuilder<CounterController>(
                      builder: (context){
                        print("aaaaaaaaaaaaaaaaa");
                          return  Text("Segundos: ${position.conter}");
                      }
                  ),*/

                    ],
                  

                ),
          

        )
        
      
    );
  }
}