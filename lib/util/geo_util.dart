import 'dart:math';

class GeoUtil {
  static double toRadians(double degrees) => degrees * ( pi / 180.0);

  static double toDegrees(double radians) => radians * 180 / pi;
}