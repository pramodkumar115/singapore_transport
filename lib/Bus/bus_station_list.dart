import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:singapore_transport/Bus/bus_list.dart';
import 'package:singapore_transport/Helpers/location_helper.dart';
import 'package:singapore_transport/data_models/one_map_bus_station.dart';

class BusStationList extends StatefulWidget {
  const BusStationList({
    super.key,
    required this.busStations,
    required this.currentPosition,
  });
  final List<OneMapBusStation> busStations;
  final Position? currentPosition;
  @override
  State<BusStationList> createState() => _BusStationListState();
}

class _BusStationListState extends State<BusStationList> {
  List<int> expandedBSIds = List.empty(growable: true);

  expandCollapse(OneMapBusStation station) {
    setState(() {
      if (expandedBSIds.contains(station.id)) {
        expandedBSIds.remove(station.id);
      } else {
        expandedBSIds.add(station.id!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.busStations.length,
      itemBuilder: (context, index) {
        var bs = widget.busStations[index];
        return ShadCard(
          title: GestureDetector(
            onTap: () => expandCollapse(bs),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(bs.name ?? "", style: TextStyle(fontSize: 18)),
                Icon(
                  expandedBSIds.contains(bs.id)
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 30,
                ),
              ],
            ),
          ),
          description: GestureDetector(
            onTap: () => expandCollapse(bs),
            child: Text(bs.road ?? ""),
          ),
          footer: GestureDetector(
            onTap: () => expandCollapse(bs),
            child: widget.currentPosition != null
                ? Text(
                    '${calculateDistanceInMeters(widget.currentPosition!.latitude, widget.currentPosition!.longitude, bs.lat, bs.lon).toString()} meters from your location',
                  )
                : Container(),
          ),
          child: expandedBSIds.contains(bs.id)
              ? BusList(busStation: bs)
              : Container(),
        );
      },
    );
  }
}
