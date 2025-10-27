import 'package:intl/intl.dart';

class BusInfo {
  String? originCode;
  String? destinationCode;
  DateTime? estimatedArrival;
  int? monitored;
  double? latitude;
  double? longitude;
  String? visitNumber;
  String? load;
  String? feature;
  String? type;

  BusInfo({
    this.originCode,
    this.destinationCode,
    this.estimatedArrival,
    this.monitored,
    this.latitude,
    this.longitude,
    this.visitNumber,
    this.load,
    this.feature,
    this.type,
  });

  factory BusInfo.fromJson(Map<String, dynamic> json) {
    DateTime? estimatedArrival;
    double latitude = 0.0;
    double longitude = 0.0;

    try {
      if (json['EstimatedArrival'] != null) {
        var format = DateFormat("yyyy-MM-dd'T'HH:mm:ssZ");
        estimatedArrival = format.parse(json['EstimatedArrival']);
      }
    } catch (e) {
      print(e);
      print("Failed to parse date ${json['EstimatedArrival']} - $json");
    }

    try {
      latitude = double.parse(json['Latitude'] ?? -1);
    } catch (e) {
      print(e);
      print("Failed to parse double latitude ${json['Latitude']} - $json");
    }

    try {
      longitude = double.parse(json['Longitude'] ?? -1);
    } catch (e) {
      print(e);
      print("Failed to parse double Longitude ${json['Longitude']} - $json");
    }
    return BusInfo(
      originCode: json['OriginCode'] as String?,
      destinationCode: json['DestinationCode'] as String?,
      estimatedArrival: estimatedArrival,
      monitored: json['Monitored'] as int?,
      latitude: latitude,
      longitude: longitude,
      visitNumber: json['VisitNumber'] as String?,
      load: json['Load'] as String?,
      feature: json['Feature'] as String?,
      type: json['Type'] as String?,
    );
  }
}
