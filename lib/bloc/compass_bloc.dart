import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_sensor_compass/flutter_sensor_compass.dart';

class CompassBloc extends Bloc<CompassEvent, CompassState> {
  StreamSubscription _compassSubscription;
  Compass _compass;

  CompassBloc(initialState) : super(initialState) {
    _compass = Compass();
  }

  @override
  Stream<CompassState> mapEventToState(CompassEvent event) async* {
    switch (event.runtimeType) {
      case StartCompass:
        bool hasStarted = await _startCompass();
        yield CompassState(0.0, 0.0, isRunning: hasStarted);
        break;
      case StopCompass:
        _compassSubscription?.cancel();
        yield state.copyWith(isRunning: false);
        break;
      case BearingChanged:
        yield state.copyWith(bearing: (event as BearingChanged).bearing);
        break;
    }
  }

  Future<bool> _startCompass() async {
    bool isAvailable = await _compass.isCompassAvailable();
    if (isAvailable) {
      _compassSubscription = _compass.compassUpdates(interval: Duration(milliseconds: 500)).listen((value) {
        add(BearingChanged(value));
      });
    }

    return isAvailable;
  }

  @override
  Future<void> close() async {
    _compassSubscription?.cancel();
    super.close();
  }
}

class CompassState {
  final double bearing;
  final double azimuth;
  final bool isRunning;

  CompassState(this.bearing, this.azimuth, { this.isRunning = false });

  CompassState copyWith({double bearing, double azimuth, bool isRunning}) =>
      CompassState(bearing ?? this.bearing, azimuth ?? this.azimuth, isRunning: isRunning ?? this.isRunning);
}

abstract class CompassEvent {}

class StartCompass extends CompassEvent {}

class StopCompass extends CompassEvent {}

class BearingChanged extends CompassEvent {
  final double bearing;

  BearingChanged(this.bearing);
}


