import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  Geolocator _geolocator;
  LocationOptions _locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
  StreamSubscription<Position> _positionStream;

  GeolocationBloc(initialState) : super(initialState) {
    _geolocator = Geolocator();
  }

  @override
  Stream<GeolocationState> mapEventToState(GeolocationEvent event) async* {
    switch (event.type) {
      case GeolocationEventType.Start:
        GeolocationStatus geolocationStatus = await Geolocator().checkGeolocationPermissionStatus();
        if (geolocationStatus == GeolocationStatus.granted || geolocationStatus == GeolocationStatus.restricted) {
          _positionStream = _geolocator.getPositionStream(_locationOptions).listen((Position position) {
            add(PositionChangedEvent(position));
          });
        }
        yield GeolocationState(Position(), status: geolocationStatus);
        break;
      case GeolocationEventType.Stop:
        _positionStream?.cancel();
        yield state.copyWith(status: GeolocationStatus.disabled);
        break;
      case GeolocationEventType.PositionChanged:
        yield state.copyWith(position: (event as PositionChangedEvent).position);
    }
  }
}

class GeolocationState {
  final Position position;
  final GeolocationStatus status;

  GeolocationState(this.position, {this.status = GeolocationStatus.unknown});

  GeolocationState copyWith({Position position, GeolocationStatus status}) => GeolocationState(position ?? this.position, status: status ?? this.status);
}

enum GeolocationEventType { Start, Stop, PositionChanged }

class GeolocationEvent {
  final GeolocationEventType type;

  GeolocationEvent(this.type);
}

class PositionChangedEvent extends GeolocationEvent {
  final Position position;

  PositionChangedEvent(this.position) : super(GeolocationEventType.PositionChanged);
}
