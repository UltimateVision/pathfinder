import 'package:pathfinder/model/basic_position.dart';
import 'package:pathfinder/model/poi.dart';
import 'package:pathfinder/util/geo_utils.dart';

/// TODO:
/// - use SQLite
class PoiRepository {
  List<Poi> getPoiList() {
    return [
      Poi("Pradolina Redy i Chylonki", PoiType.cache, BasicPosition(54.60333, 18.4248)),
      Poi("Leśny Ogród Botaniczny Marszewo", PoiType.cache,
          BasicPosition(GeoUtils.dmmToDecimal(54.0, 31.229), GeoUtils.dmmToDecimal(18, 25.078))),
      Poi("Górka Żydowska", PoiType.cache,
          BasicPosition(GeoUtils.dmmToDecimal(54, 36.432), GeoUtils.dmmToDecimal(18, 10.991))),
      Poi("Garaż", PoiType.car, BasicPosition(54.572898, 18.414437))
    ];
  }
}
