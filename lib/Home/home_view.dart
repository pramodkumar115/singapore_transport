import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:singapore_transport/Bus/bus_view.dart';
import 'package:singapore_transport/Favorites/favorites_view.dart';
import 'package:singapore_transport/OneMap/one_map_service.dart';
import 'package:singapore_transport/Search/search_view.dart';
import 'package:singapore_transport/Settings/settings_view.dart';
import 'package:singapore_transport/riverpod/onemap_token_provider.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(oneMapTokenProvider.notifier).fetchOneMapToken();
  }

  @override
  Widget build(BuildContext context) {
    var accessToken = ref.watch(oneMapTokenProvider).accessToken;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: Text("Singapore Transport"),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 15),
            child: 
          InkWell(
            child: Icon(Icons.settings),
            onTap: () => showShadSheet(
              context: context,
              builder: (context) => const SettingsView(),
              side: ShadSheetSide.right,
            ),
          )),
        ],
      ),
      body: accessToken != ''
          ? Container(
              margin: EdgeInsets.all(10),
              child: ShadTabs<String>(
                decoration: ShadDecoration(
                  border: ShadBorder.all(color: Colors.amber),
                ),
                value: 'Bus',
                tabs: [
                  ShadTab(
                    value: "Bus",
                    leading: Icon(Icons.directions_bus_filled, size: 25),
                    content: BusView(),
                    child: Text("Bus"),
                  ),
                  ShadTab(
                    value: "MRT",
                    leading: Icon(Icons.train, size: 25),
                    content: Container(child: Text("Under Construction")),
                    child: Text("MRT"),
                  ),
                  
                ],
              ),
            )
          : Container(),
    );
  }
}
