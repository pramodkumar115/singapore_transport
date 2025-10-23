import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:singapore_transport/Bus/bus_view.dart';
import 'package:singapore_transport/Favorites/favorites_view.dart';
import 'package:singapore_transport/Search/search_view.dart';
import 'package:singapore_transport/Settings/settings_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: Text("Singapore Transport"),
        actions: [
          InkWell(
            child: Icon(Icons.settings),
            onTap: () => showShadSheet(
              context: context,
              builder: (context) => const SettingsView(),
              side: ShadSheetSide.right,
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ShadTabs<String>(
          decoration: ShadDecoration(
            border: ShadBorder.all(color: Colors.amber),
          ),
          value: 'Bus',
          // tabBarConstraints: const BoxConstraints(maxWidth: 400),
          // contentConstraints: const BoxConstraints(maxWidth: 400),
          tabs: [
            ShadTab(
              value: "Bus",
              leading: Icon(Icons.directions_bus_filled, size: 25),
              content: BusView(),
              child: Text("Bus"),
            ),
            ShadTab(
              value: "Favorites",
              leading: Icon(Icons.favorite, size: 25),
              content: FavoritesView(),
              child: Text("Favorites"),
            ),
            ShadTab(
              value: "Search",
              leading: Icon(Icons.search, size: 25),
              content: SearchView(),
              child: Text("Search"),
            ),
          ],
        ),
      ),
    );
  }
}
