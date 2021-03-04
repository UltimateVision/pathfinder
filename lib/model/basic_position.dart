class BasicPosition {
  final double latitude;
  final double longitude;

  BasicPosition(this.latitude, this.longitude);

  BasicPosition copyWith({double latitude, double longitude}) =>
      BasicPosition(latitude ?? this.latitude, longitude ?? this.longitude);
}
