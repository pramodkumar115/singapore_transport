import 'package:singapore_transport/data_models/bus_info.dart';

class BusArrivalModel {
  String? serviceNo;
  String? operator;
  BusInfo? nextBus;
  BusInfo? nextBus2;
  BusInfo? nextBus3;

  BusArrivalModel({
    this.serviceNo,
    this.operator,
    this.nextBus,
    this.nextBus2,
    this.nextBus3
  });

  factory BusArrivalModel.fromJson(Map<String, dynamic> json) {
    try {
    return BusArrivalModel(
      serviceNo: json['ServiceNo'] as String?,
      operator: json['Operator'] as String?,
      nextBus: BusInfo.fromJson(json['NextBus']) as BusInfo?,
      nextBus2: BusInfo.fromJson(json['NextBus2']) as BusInfo?,
      nextBus3: BusInfo.fromJson(json['NextBus3']) as BusInfo?,
    );
    } catch(e) {
      print(e);
      throw Exception(e);
    }
  }
}
