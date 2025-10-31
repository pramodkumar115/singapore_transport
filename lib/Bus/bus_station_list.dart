import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:singapore_transport/Bus/bus_list.dart';
import 'package:singapore_transport/Helpers/location_helper.dart';
import 'package:singapore_transport/data_models/one_map_bus_station.dart';
import 'package:singapore_transport/riverpod/favourites_provider.dart';

class BusStationList extends ConsumerStatefulWidget {
  const BusStationList({
    super.key,
    required this.busStations,
    required this.currentPosition,
  });
  final List<OneMapBusStation> busStations;
  final Position? currentPosition;
  @override
  ConsumerState<BusStationList> createState() => _BusStationListState();
}

class _BusStationListState extends ConsumerState<BusStationList> {
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

  addOrRemoveFromFavorite(OneMapBusStation station, List favourites) {
    var favIds = favourites.map((e) => e['id']).toList();
    if (favIds.contains(station.id)) {
      ref
          .read(favouritesProvider.notifier)
          .deleteFavourite(
            favIds.indexOf(station.id),
          );
    } else {
      ref.read(favouritesProvider.notifier).updateFavourites({
        "id": station.id,
        "name": station.name,
        "road": station.road,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List favourites = ref.watch(favouritesProvider);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.busStations.length,
      itemBuilder: (context, index) {
        var bs = widget.busStations[index];
        return ShadCard(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => expandCollapse(bs),
                child: Text(bs.name ?? "", style: TextStyle(fontSize: 18)),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => addOrRemoveFromFavorite(bs, favourites),
                    child: Icon(
                      favourites.map((e) => e['id']).contains(bs.id)
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: Colors.red,
                      size: 25,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => expandCollapse(bs),
                    child: Icon(
                      expandedBSIds.contains(bs.id)
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
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
