class OneMapBusStation {
    int? id;
    String? name;
    double? lat;
    double? lon;
    String? road;

    OneMapBusStation({
      this.id,
      this.name,
      this.lat,
      this.lon,
      this.road
    });

factory OneMapBusStation.fromJson(Map<String, dynamic> json) {
    return OneMapBusStation(
      id: json['id'] as int?,
      name: json['name'] as String?,
      lat: json['lat'] as double?,
      lon: json['lon'] as double?,
      road: json['road'] as String?
    );
}

}