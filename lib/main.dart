import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sensor_compass/flutter_sensor_compass.dart';
import 'package:pathfinder/bloc/compass_bloc.dart';
import 'package:pathfinder/ui/pages/compass_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: BlocProvider(create: (context) => CompassBloc(CompassState(0.0, 0.0)), child: CompassPage()),
    );
  }
}

//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//  double _degreesNorth = 0;
//  bool _isRunning = false;
//
//  StreamSubscription _compassSubscription;
//
//  void _incrementCounter() {
//    setState(() {
//      // This call to setState tells the Flutter framework that something has
//      // changed in this State, which causes it to rerun the build method below
//      // so that the display can reflect the updated values. If we changed
//      // _counter without calling setState(), then the build method would not be
//      // called again, and so nothing would appear to happen.
//      _counter++;
//    });
//  }
//
//  void _startCompass() async {
//    bool _isAvailable = await Compass().isCompassAvailable();
//    if (_isAvailable) {
//      _isRunning = true;
//      _compassSubscription = Compass().compassUpdates(interval: Duration(milliseconds: 200)).listen((value) {
//        setState(() {
//          _degreesNorth = value;
//        });
//      });
//    } else {
//      print("Compass not available");
//    }
//  }
//
//  void _stopCompass() {
//    _compassSubscription.cancel();
//    _isRunning = false;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'Bearing north:',
//            ),
//            Text(
//              '$_degreesNorth',
//              style: Theme.of(context).textTheme.headline4,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _isRunning ? _stopCompass : _startCompass,
//        tooltip: _isRunning ? 'Stop compass' : 'Start compass',
//        child: Icon(Icons.av_timer),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//}
