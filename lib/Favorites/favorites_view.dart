import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:singapore_transport/Bus/bus_list.dart';
import 'package:singapore_transport/Bus/bus_station_list.dart';
import 'package:singapore_transport/data_models/one_map_bus_station.dart';
import 'package:singapore_transport/riverpod/favourites_provider.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  Widget build(BuildContext context) {
    List busStationList = ref.watch(favouritesProvider);
    return busStationList.isEmpty ? Container(child: Text("No saved favourites yet"))
    : BusStationList(busStations: convertToStations(busStationList), currentPosition: null);
    // FutureBuilder(future: getNearestBusStations(authToken, latitude, longitude), builder: builder)
  }
  
  List<OneMapBusStation> convertToStations(List busStationList) {
    return busStationList.map((e) => OneMapBusStation(
      id: e['id'],
      name: e['name'],
      road: e['road']
    )).toList();
  }
}
