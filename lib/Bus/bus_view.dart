import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:singapore_transport/Bus/nearest_bus_station_list.dart';
import 'package:singapore_transport/Favorites/favorites_view.dart';
import 'package:singapore_transport/riverpod/favourites_provider.dart';

class BusView extends ConsumerStatefulWidget {
  const BusView({super.key});

  @override
  ConsumerState<BusView> createState() => _BusViewState();
}

class _BusViewState extends ConsumerState<BusView> {
  String subMenu = 'NEAREST_BUSES';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(favouritesProvider.notifier).fetchFavourites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          spacing: 5,
          children: [
            GestureDetector(
              onTap: () {
                setState(() => subMenu = 'NEAREST_BUSES');
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  border: Border.all(
                    color: subMenu == 'NEAREST_BUSES'
                        ? Colors.red
                        : Theme.of(context).colorScheme.primaryContainer,
                    width: subMenu == 'NEAREST_BUSES' ? 1.5 : 0,
                  ),
                  color: Theme.of(context).colorScheme.tertiaryFixedDim,
                ),
                padding: EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                  left: 20,
                  right: 20,
                ),
                child: Icon(
                  Icons.bus_alert,
                  color: subMenu == 'NEAREST_BUSES'
                      ? Colors.red
                      : Theme.of(context).colorScheme.primaryContainer,
                  size: 25,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() => subMenu = 'FAVOURITES');
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  border: Border.all(
                    color: subMenu == 'FAVOURITES'
                        ? Colors.red
                        : Theme.of(context).colorScheme.primaryContainer,
                    width: subMenu == 'FAVOURITES' ? 1.5 : 0,
                  ),
                  color: Theme.of(context).colorScheme.tertiaryFixedDim,
                ),
                padding: EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                  left: 20,
                  right: 20,
                ),
                child: Icon(
                  Icons.favorite,
                  color: subMenu == 'FAVOURITES'
                      ? Colors.red
                      : Theme.of(context).colorScheme.primaryContainer,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        ShadCard(
          width: screenWidth,
          padding: EdgeInsets.all(10),
          backgroundColor: Theme.of(context).colorScheme.tertiaryFixedDim,
          // title: Text("", style: TextStyle(fontSize: 1)),
          description: Text(""),
          child: subMenu == 'NEAREST_BUSES'
              ? NearestBusStationList()
              : FavoritesView(),
        ),
      ],
    );
  }
}
