import 'package:pathfinder/model/basic_position.dart';

class Poi {
  final String name;
  final String description;
  final PoiType type;
  final BasicPosition position;

  const Poi(this.name, this.type, this.position, {this.description = ""});

  Poi copyWith({String name, String description, PoiType type, BasicPosition position}) {
    return Poi(
      name ?? this.name,
      type ?? this.type,
      position ?? this.position,
      description: description ?? this.description
    );
  }
}

enum PoiType { cache, car, home, backtrack }