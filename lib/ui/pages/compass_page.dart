import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathfinder/bloc/compass_bloc.dart';
import 'package:pathfinder/bloc/geolocation_bloc.dart';
import 'package:pathfinder/bloc/poi_list_bloc.dart';
import 'package:pathfinder/font_awesome_5.dart';
import 'package:pathfinder/ui/pages/poi_list_page.dart';
import 'package:pathfinder/ui/widgets/compass_widget.dart';
import 'package:pathfinder/ui/widgets/location_widget.dart';

/// TODO:
/// - show distance to selected POI
/// - user backtracking switch
class CompassPage extends StatefulWidget {
  @override
  State<CompassPage> createState() => _CompassPageState();
}

class _CompassPageState extends State<CompassPage> {
  CompassBloc _compassBloc;
  GeolocationBloc _geolocationBloc;

  @override
  void initState() {
    super.initState();
    _compassBloc = BlocProvider.of<CompassBloc>(context);
    _geolocationBloc = BlocProvider.of<GeolocationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CompassWidget(), LocationWidget()],
            ),
          ),
          _options
        ],
      ),
    ));
  }

  Widget get _options => Padding(
      padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_compassSwitch, _azimuthSwitch, _resetAzimuth, _poiList]));

  void _floatingButtonAction(bool isCompassRunning) async {
    isCompassRunning ? _compassBloc.add(StopCompass()) : _compassBloc.add(StartCompass());
    isCompassRunning
        ? _geolocationBloc.add(GeolocationEvent(GeolocationEventType.Stop))
        : _geolocationBloc.add(GeolocationEvent(GeolocationEventType.Start));
  }

  Widget get _compassSwitch => BlocBuilder<CompassBloc, CompassState>(
        builder: (context, state) => IconButton(
            icon: Icon(FontAwesome5.compass),
            tooltip: "compass",
            onPressed: () => _floatingButtonAction(state.isRunning)),
      );

  Widget get _azimuthSwitch => BlocBuilder<CompassBloc, CompassState>(
        builder: (context, state) => IconButton(
            icon: Icon(FontAwesome5.drafting_compass),
            tooltip: "set azimuth",
            onPressed: () => _compassBloc.add(SetAzimuth(state.bearing))),
      );

  Widget get _resetAzimuth => BlocBuilder<CompassBloc, CompassState>(
        builder: (context, state) => IconButton(
            icon: Icon(FontAwesome5.trash),
            tooltip: "reset azimuth",
            onPressed: () => _compassBloc.add(SetAzimuth(-1.0))),
      );

  Widget get _poiList => IconButton(
      icon: Icon(FontAwesome5.list),
      tooltip: "POI List",
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(create: (_) => PoiListBloc(), child: PoiListPage()),
          )));
}
