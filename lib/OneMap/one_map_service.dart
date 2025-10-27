import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:singapore_transport/OneMap/one_map_api_list.dart';
import 'package:singapore_transport/data_models/one_map_bus_station.dart';

getOneMapToken() async {
  const data = {
    "email": 'pramodkumar115@gmail.com',
    "password": 'Utthampk@115',
  };

  return await http.post(
    Uri.parse(ONE_MAP_TOKEN),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );
}

Future<List<OneMapBusStation>> getNearestBusStations(
  String? authToken,
  latitude,
  longitude,
) async {
  if (authToken != null) {
    return await http
        .get(
          Uri.parse(
            "$NEAREST_BUS_STATIONS?latitude=$latitude&longitude=$longitude&radius_in_meters=1000",
          ),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $authToken', // API token for authorization
          },
        )
        .then((resp) {
          if (resp.statusCode == 200) {
            var dataSet = jsonDecode(resp.body);
            List<OneMapBusStation> busStations = List.empty(growable: true);
            for (var d in dataSet) {
              busStations.add(OneMapBusStation.fromJson(d));
            }
            return busStations;
          }
          return [];
        });
  }
  return [];
}
