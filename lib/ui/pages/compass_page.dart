import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathfinder/bloc/compass_bloc.dart';

class CompassPage extends StatefulWidget {
  @override
  State<CompassPage> createState() => _CompassPageState();
}

class _CompassPageState extends State<CompassPage> {
  CompassBloc _compassBloc;

  @override
  void initState() {
    super.initState();
    _compassBloc = BlocProvider.of<CompassBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompassBloc, CompassState>(
        builder: (context, state) => Scaffold(
              body: Center(
                child: _bearingWidget(state),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => _floatingButtonAction(state.isRunning),
                tooltip: state.isRunning ? 'Stop compass' : 'Start compass',
                child: Icon(Icons.av_timer),
              ), // This trailing comma makes auto-formatting nicer for build methods.
            ));
  }

  void _floatingButtonAction(bool isCompassRunning) async {
    isCompassRunning ? _compassBloc.add(StopCompass()) : _compassBloc.add(StartCompass());
  }

  Widget _bearingWidget(CompassState state) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_drop_up, size: 84.0),
          Text(
            _formatBearing(state.bearing),
            style: TextStyle(fontSize: 72.0, height: 0.75),
          )
        ],
      );

  String _formatBearing(double bearing) {
    String direction = '?';
    bearing = bearing ?? 0.0;
    if (bearing > 337.5 || bearing <= 22.5)
      direction = 'N';
    else if (bearing > 22.5 && bearing <= 67.5)
      direction = 'NE';
    else if (bearing > 67.5 && bearing <= 112.5)
      direction = 'E';
    else if (bearing > 112.5 && bearing <= 157.5)
      direction = 'SE';
    else if (bearing > 157.5 && bearing <= 202.5)
      direction = 'S';
    else if (bearing > 202.5 && bearing <= 247.5)
      direction = 'SW';
    else if (bearing > 247.5 && bearing <= 292.5)
      direction = 'W';
    else if (bearing > 292.5 && bearing <= 337.5) direction = 'NW';

    return "${bearing.truncate()} $direction";
  }
}
