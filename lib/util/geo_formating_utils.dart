class GeoFormattingUtils {
  static String formatBearing(double bearing) {
    String direction = '?';
    bearing = bearing ?? 0.0;
    if (bearing > 337.5 || bearing <= 22.5)
      direction = 'N';
    else if (bearing > 22.5 && bearing <= 67.5)
      direction = 'NE';
    else if (bearing > 67.5 && bearing <= 112.5)
      direction = 'E';
    else if (bearing > 112.5 && bearing <= 157.5)
      direction = 'SE';
    else if (bearing > 157.5 && bearing <= 202.5)
      direction = 'S';
    else if (bearing > 202.5 && bearing <= 247.5)
      direction = 'SW';
    else if (bearing > 247.5 && bearing <= 292.5)
      direction = 'W';
    else if (bearing > 292.5 && bearing <= 337.5) direction = 'NW';

    String bearingStr = bearing.truncate().toString().padLeft(3, '0');

    return "$bearingStr\u00B0 $direction";
  }

  static String formatLatitude(double latitude) {
    if (latitude == null) return "unknown";
    String direction = (latitude >= 0) ? "N" : "S";
    return "${_formatCoordinate(latitude.abs())} $direction";
  }

  static String formatLongitude(double longitude) {
    if (longitude == null) return "unknown";
    String direction = (longitude >= 0) ? "E" : "W";
    return "${_formatCoordinate(longitude.abs())} $direction";
  }

  static String _formatCoordinate(double coordinate) {
    int degrees = coordinate.truncate();
    int minutes = ((coordinate - degrees) * 60.0).truncate();
    int seconds = ((((coordinate - degrees) * 60.0) - minutes) * 60.0).truncate();

    return "${degrees.toString().padLeft(2, '0')}\u00B0 ${minutes.toString().padLeft(2, '0')}' ${seconds.toString().padLeft(2, '0')}''";
  }
}
