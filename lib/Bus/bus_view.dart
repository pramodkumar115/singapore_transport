import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:singapore_transport/Bus/nearest_bus_station_list.dart';
import 'package:url_launcher/url_launcher.dart';

class BusView extends StatefulWidget {
  const BusView({super.key});

  @override
  State<BusView> createState() => _BusViewState();
}

class _BusViewState extends State<BusView> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return ShadCard(
      width: screenWidth,
      backgroundColor: Theme.of(context).colorScheme.tertiaryFixedDim,
      title: Text("Bus Stations near you", style: TextStyle(fontSize: 20)),
      description: Text(""),
      child: NearestBusStationList()
      );
  }
}
