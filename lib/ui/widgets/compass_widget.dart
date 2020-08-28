import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathfinder/bloc/compass_bloc.dart';
import 'package:pathfinder/util/geo_util.dart';

class CompassWidget extends StatefulWidget {
  @override
  State<CompassWidget> createState() => _CompassWidgetState();
}

class _CompassWidgetState extends State<CompassWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompassBloc, CompassState>(
      builder: (context, state) => Padding(
        padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(alignment: Alignment.center, children: [
              _rotatingNeedle(state.bearing, Colors.red),
              if ((state.azimuth ?? -1.0) >= 0) _rotatingNeedle(state.azimuth, Colors.black),
              _bearingValue(state)
            ]),
          ],
        ),
      ),
    );
  }

  Widget _rotatingNeedle(double bearing, Color color) => Transform.rotate(
      angle: -GeoUtil.toRadians(bearing),
      child: Container(
        width: 280.0,
        height: 280.0,
        alignment: Alignment.topCenter,
        child: Icon(
          Icons.arrow_drop_up,
          size: 64.0,
          color: color,
        ),
      ));

  Widget _bearingValue(CompassState state) => Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 2.0, color: Colors.black),
      ),
      width: 200.0,
      height: 200.0,
      alignment: Alignment.center,
      child: Text(
        GeoUtil.formatBearing(state.bearing),
        style: TextStyle(fontSize: 40.0, height: 0.75),
      ));
}
