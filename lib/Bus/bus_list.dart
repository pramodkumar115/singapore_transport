import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:singapore_transport/LTA/lta_service.dart';
import 'package:singapore_transport/data_models/bus_arrival_model.dart';
import 'package:singapore_transport/data_models/bus_info.dart';
import 'package:singapore_transport/data_models/one_map_bus_station.dart';

class BusList extends ConsumerStatefulWidget {
  const BusList({super.key, required this.busStation});

  final OneMapBusStation busStation;

  @override
  ConsumerState<BusList> createState() => _BusListState();
}

class _BusListState extends ConsumerState<BusList> {
  List<BusArrivalModel> busArrivalInfoList = List.empty(growable: true);
  Timer? _timer;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    loadBusInfo();
    _timer = Timer.periodic(Duration(seconds: 30), (Timer timer) {
      loadBusInfo();
    });
  }

  loadBusInfo() async {
    if (widget.busStation.id != null) {
      setState(() => _loading = true);
      busArrivalInfoList.clear();
      var busData = await getBusArrivalForAStop(widget.busStation.id!);
      setState(() {
        busArrivalInfoList.addAll(busData);
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.busStation.id != null
        ? _loading == true
              ? CircularProgressIndicator()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: busArrivalInfoList.length,
                  itemBuilder: (context, index) {
                    var busArrivalInfo = busArrivalInfoList[index];
                    return Column(
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                busArrivalInfo.serviceNo!,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Row(
                                children: [
                                  getArrivalInfo(busArrivalInfo.nextBus),
                                  getArrivalInfo(busArrivalInfo.nextBus2),
                                  getArrivalInfo(busArrivalInfo.nextBus3),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    );
                  },
                )
        : Text("No data recieved from LTA.");
  }

  Widget getArrivalInfo(BusInfo? busInfo) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              busInfo?.feature == 'WAB'
                  ? Icon(Icons.accessible)
                  : Container(width: 15),
              Text(
                getArrivalTime(busInfo),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: getColor(busInfo),
                ),
              ),
            ],
          ),
          Text(
            busInfo?.type == 'DD' ? "Double" : "Single",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  String getArrivalTime(BusInfo? busInfo) {
    var returnable = '-';
    if (busInfo == null) {
      returnable = 'NA';
    } else {
      if (busInfo.estimatedArrival != null) {
        Duration diff = busInfo.estimatedArrival!.difference(DateTime.now());
        if (diff.inMinutes < 1) {
          returnable = "Arr";
        } else if (diff.inMinutes < 0) {
          returnable = "left";
        } else {
          returnable = NumberFormat("#,##0").format(diff.inMinutes);
        }
      }
    }
    return returnable;
  }

  Color? getColor(BusInfo? busInfo) {
    if (busInfo != null) {
      if (busInfo.load == 'SEA') {
        return Colors.green;
      } else if (busInfo.load == 'SDA') {
        return Colors.amber;
      } else {
        return Colors.red;
      }
    }
    return null;
  }
}
