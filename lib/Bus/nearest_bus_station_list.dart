
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:singapore_transport/Bus/bus_station_list.dart';
import 'package:singapore_transport/Helpers/location_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:singapore_transport/OneMap/one_map_service.dart';
import 'package:singapore_transport/data_models/one_map_bus_station.dart';
import 'package:singapore_transport/riverpod/onemap_token_provider.dart';

class NearestBusStationList extends ConsumerStatefulWidget {
  const NearestBusStationList({super.key});

  @override
  ConsumerState<NearestBusStationList> createState() => _BusStationListState();
}

class _BusStationListState extends ConsumerState<NearestBusStationList> {
  List<OneMapBusStation> busStations = List.empty(growable: true);
  Position? currentPosition;

  @override
  void initState() {
    super.initState();
    loadNearestBusStations();
  }

  loadNearestBusStations() async {
    Position? posn = await getCurrentLocation();
    if (posn != null) {
      var stationsList = await getNearestBusStations(
        ref.watch(oneMapTokenProvider).accessToken,
        posn.latitude,
        posn.longitude,
      );
      setState(() {
        busStations = [...stationsList];
        currentPosition = posn;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.65,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          ShadInput(
            decoration: ShadDecoration(
              border: ShadBorder.all(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
            style: TextStyle(),
            placeholder: Text('Search'),
            leading: Icon(Icons.search),
          ),
          Expanded(
            child: BusStationList(busStations: busStations, currentPosition: currentPosition)
          ),
        ],
      ),
    );
  }
}
