import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathfinder/data/poi_repository.dart';
import 'package:pathfinder/model/poi.dart';

class PoiListBloc extends Bloc<PoiListEvent, PoiListState> {
  final PoiRepository repository = PoiRepository();

  PoiListBloc() : super(PoiListState([]));

  @override
  Stream<PoiListState> mapEventToState(PoiListEvent event) async* {
    switch (event.type) {
      case PoiListEventType.fetch:
        yield PoiListState(repository.getPoiList());
        break;
      case PoiListEventType.add:
        yield PoiListState(state.poiList + [event.poi]);
        break;
      case PoiListEventType.remove:
        state.poiList.remove(event.poi);
        yield PoiListState(state.poiList);
        break;
    }
  }

}

enum PoiListEventType { fetch, add, remove }

class PoiListEvent {
  final PoiListEventType type;
  final Poi poi;

  PoiListEvent(this.type, { this.poi });
}

class PoiListState {
  final List<Poi> poiList;

  PoiListState(this.poiList);

  PoiListState copy({List<Poi> poiList}) => PoiListState(poiList ?? this.poiList);
}