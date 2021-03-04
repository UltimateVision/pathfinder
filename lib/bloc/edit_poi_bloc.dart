import 'package:bloc/bloc.dart';
import 'package:pathfinder/model/poi.dart';

class EditPoiBloc extends Bloc<PoiDataEvent, PoiDataState> {
  EditPoiBloc(PoiDataState initialState) : super(initialState);

  @override
  Stream<PoiDataState> mapEventToState(PoiDataEvent event) async* {
    switch (event.runtimeType) {
      case PoiDataChanged:
        yield PoiDataState(model: event.model);
        break;
    }
  }

}

class PoiDataState {
  final Poi model;

  PoiDataState({this.model = const Poi("", null, null)});

}

abstract class PoiDataEvent {
  final Poi model;

  PoiDataEvent(this.model);
}

class PoiDataChanged extends PoiDataEvent {
  PoiDataChanged(Poi model) : super(model);
}

class PoiDataSubmitted extends PoiDataEvent {
  PoiDataSubmitted(Poi model) : super(model);
}