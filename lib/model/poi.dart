import 'package:pathfinder/model/basic_position.dart';

class Poi {
  final String name;
  final String description;
  final PoiType type;
  final BasicPosition position;

  Poi(this.name, this.type, this.position, {this.description = ""});
}

enum PoiType { cache, car, home, backtrack }