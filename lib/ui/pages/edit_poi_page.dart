import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathfinder/bloc/edit_poi_bloc.dart';
import 'package:pathfinder/model/basic_position.dart';
import 'package:pathfinder/model/poi.dart';
import 'package:pathfinder/ui/widgets/option_selector_widget.dart';

typedef OnPoiSaved = Function (Poi poi);

class EditPoiPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final OnPoiSaved onPoiSaved;

  EditPoiPage({Key key, this.onPoiSaved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new POI..."),
      ),
      body: BlocBuilder<EditPoiBloc, PoiDataState>(
          builder: (BuildContext context, PoiDataState state) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _EditPoiForm(_formKey, state.model),
                  ],
                ),
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Poi poi = BlocProvider.of<EditPoiBloc>(context).state.model;
          onPoiSaved?.call(poi);
          Navigator.pop(context);
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.black,
      ),
    );
  }
}

/// TODO:
/// - validation
/// - description field
class _EditPoiForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey;
  final Poi model;

  const _EditPoiForm(this._formKey, this.model, {Key key}) : super(key: key);
  static const Map<PoiType, String> _poiTypeOptions = {
    PoiType.cache: "Cache",
    PoiType.car: "Car",
    PoiType.home: "Home",
    PoiType.backtrack: "Backtrack"
  };

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: "Name"),
            initialValue: model.name,
            onChanged: (String name) => _modelChanged(context, model.copyWith(name: name)),
          ),
          GestureDetector(
            child: Container(
              color: Colors.transparent,
              child: IgnorePointer(
                child: TextFormField(
                  key: ObjectKey(model.type),
                  decoration: InputDecoration(labelText: "Type"),
                  initialValue: _poiTypeOptions[model.type],
                ),
              ),
            ),
            onTap: () => _selectOption(context, model),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Latitude"),
            initialValue: model?.position?.latitude.toString(),
            onChanged: (String latitude) {
              double lat = double.parse(latitude);
              BasicPosition pos =
                  model.position != null ? model.position.copyWith(latitude: lat) : BasicPosition(lat, null);
              _modelChanged(context, model.copyWith(position: pos));
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Longitude"),
            initialValue: model?.position?.latitude.toString(),
            onChanged: (String longitude) {
              double lon = double.parse(longitude);
              BasicPosition pos =
                  model.position != null ? model.position.copyWith(longitude: lon) : BasicPosition(null, lon);
              _modelChanged(context, model.copyWith(position: pos));
            },
          ),
        ],
      ),
    );
  }

  void _selectOption(BuildContext context, Poi model) {
    EditPoiBloc bloc = BlocProvider.of<EditPoiBloc>(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _PoiTypeSelection(
          (poiType) => bloc.add(PoiDataChanged(model.copyWith(type: poiType))),
          initialSelection: model.type,
        ),
      ),
    );
  }

  void _modelChanged(BuildContext context, Poi poi) => BlocProvider.of<EditPoiBloc>(context).add(PoiDataChanged(poi));
}

class _PoiTypeSelection extends StatelessWidget {
  final OnElementSelected<PoiType> onElementSelected;
  final PoiType initialSelection;

  const _PoiTypeSelection(this.onElementSelected, {this.initialSelection, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: OptionSelector<PoiType>(
          _EditPoiForm._poiTypeOptions,
          (type) => _onElementSelected(context, type),
          initialSelection: initialSelection,
        ),
      );

  void _onElementSelected(BuildContext context, PoiType type) {
    onElementSelected?.call(type);
    Navigator.pop(context);
  }
}
