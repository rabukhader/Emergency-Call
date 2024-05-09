class Location {
  double latitude;
  double longitude;

  Location({required this.longitude, required this.latitude});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(latitude: (json['latitude']).toDouble(), longitude: (json['longitude']).toDouble());
  }

  Map<String, dynamic> toJson() {
    return {'latitude': latitude, 'longitude': longitude};
  }
}
