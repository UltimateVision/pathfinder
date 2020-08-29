import 'package:flutter_test/flutter_test.dart';
import 'package:pathfinder/util/geo_formating_utils.dart';

void main() {
  group("GeoFormattingUtils", () {
    test("should correctly convert latitude to DMS format", () {
      double position = 55.23121;
      expect(GeoFormattingUtils.formatLatitude(position), "55\u00B0 13' 52'' N");
      expect(GeoFormattingUtils.formatLatitude(-position), "55\u00B0 13' 52'' S");
    });

    test("should correctly convert longitude to DMS format", () {
      double position = 55.23121;
      expect(GeoFormattingUtils.formatLongitude(position), "55\u00B0 13' 52'' E");
      expect(GeoFormattingUtils.formatLongitude(-position), "55\u00B0 13' 52'' W");
    });
  });
}