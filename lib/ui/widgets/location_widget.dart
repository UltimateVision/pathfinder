import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathfinder/bloc/geolocation_bloc.dart';
import 'package:pathfinder/util/geo_util.dart';

class LocationWidget extends StatefulWidget {
  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeolocationBloc, GeolocationState>(
      builder: (context, state) => Column(
        children: [
          Text("Lat: ${GeoUtil.formatLatitude(state.position.latitude)}", style: TextStyle(fontSize: 16.0)),
          Text("Lon: ${GeoUtil.formatLongitude(state.position.longitude)}", style: TextStyle(fontSize: 16.0)),
        ],
      ),
    );
  }
}
