import 'dart:math';

import 'package:geolocator/geolocator.dart';

class GeoUtils {
  static const double _equatorialEarthRadius = 6378137.0;
  static const double _polarEarthRadius = 6356752.3;

  static double toRadians(double degrees) => degrees * (pi / 180.0);

  static double toDegrees(double radians) => radians * 180 / pi;

  static double calculateBearing(Position initialPosition, Position destination) {
    var dLon = toRadians(destination.longitude - initialPosition.longitude);
    var dPhi =
        log(tan(toRadians(destination.latitude) / 2 + pi / 4) / tan(toRadians(initialPosition.latitude) / 2 + pi / 4));
    if (dLon.abs() > pi) dLon = dLon > 0 ? -(2 * pi - dLon) : (2 * pi + dLon);
    return toBearing(atan2(dLon, dPhi));
  }

  static double toBearing(double radians) {
    // convert radians to degrees (as bearing: 0...360)
    return (toDegrees(radians) + 360) % 360;
  }

  static double getDistance(Position initialPosition, Position destination) {
    double initialRadLat = toRadians(initialPosition.latitude);
    double destinationRadLat = toRadians(destination.latitude);
    double latDiff = toRadians(destination.latitude - initialPosition.latitude);
    double lonDiff = toRadians(destination.longitude - initialPosition.longitude);

    double a = sin(latDiff / 2) * sin(latDiff / 2) +
        cos(initialRadLat) * cos(destinationRadLat) *
            sin(lonDiff / 2) * sin(lonDiff / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return (_equatorialEarthRadius + _polarEarthRadius) / 2 * c;
  }

  static double dmmToDecimal(double degrees, double minutes) {
    return degrees + minutes / 60.0;
  }

  static double dmsToDecimal(double degrees, double minutes, double seconds) {
    return dmmToDecimal(degrees, minutes) + seconds / 3600.0;
  }
}
