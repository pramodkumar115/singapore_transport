import 'dart:async';
import 'dart:convert';

import 'package:singapore_transport/LTA/lta_constants.dart';
import 'package:singapore_transport/data_models/bus_arrival_model.dart';
import 'package:http/http.dart' as http;

Future<List<BusArrivalModel>> getBusArrivalForAStop(int busStopCode) async {
  return await http
      .get(
        Uri.parse('$LTA_GET_BUS_ARRIVAL?BusStopCode=$busStopCode'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'AccountKey': LTA_ACCOUNT_KEY,
        },
      )
      .then((resp) {
        if (resp.statusCode == 200) {
          var dataSet = jsonDecode(resp.body);
          List<BusArrivalModel> busArrivalInfoList = List.empty(growable: true);
          for (var d in dataSet["Services"]) {
            busArrivalInfoList.add(BusArrivalModel.fromJson(d));
          }
          //print("In get - ${jsonEncode(busArrivalInfoList)}");
          return busArrivalInfoList;
        }
        return [];
      });
}
