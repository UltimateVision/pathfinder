import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathfinder/bloc/poi_list_bloc.dart';
import 'package:pathfinder/font_awesome_5.dart';
import 'package:pathfinder/model/poi.dart';
import 'package:pathfinder/util/geo_formating_utils.dart';

class PoiListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PoiListState();
}

class _PoiListState extends State<PoiListPage> {
  static const Map<PoiType, IconData> _icons = {
    PoiType.cache: FontAwesome5.archive,
    PoiType.car: FontAwesome5.car,
    PoiType.home: FontAwesome5.home,
    PoiType.backtrack: FontAwesome5.history
  };

  PoiListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<PoiListBloc>(context);
    _bloc.add(PoiListEvent(PoiListEventType.fetch));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PoiListBloc, PoiListState>(
          builder: (context, state) => ListView.builder(
              itemCount: state.poiList.length, itemBuilder: (context, index) => _buildRow(state.poiList[index]))),
    );
  }

  Widget _buildRow(Poi poi) => Padding(
      padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(padding: EdgeInsets.only(right: 10.0), child: Icon(_icons[poi.type], size: 32.0)),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              poi.name,
              style: TextStyle(fontSize: 16.0),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "${GeoFormattingUtils.formatLatitude(poi.position.latitude)} ${GeoFormattingUtils.formatLongitude(poi.position.longitude)}",
              style: TextStyle(fontSize: 10.0, color: Colors.blueGrey),
            )
          ],
        )
      ]));
}
