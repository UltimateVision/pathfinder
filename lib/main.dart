import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pathfinder/bloc/compass_bloc.dart';
import 'package:pathfinder/bloc/geolocation_bloc.dart';
import 'package:pathfinder/ui/pages/compass_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CompassBloc(CompassState(0.0, 0.0))),
        BlocProvider(
            create: (context) =>
                GeolocationBloc(GeolocationState(Position(latitude: 0.0, longitude: 0.0, altitude: 0.0)))),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: CompassPage(),
      ),
    );
  }
}
