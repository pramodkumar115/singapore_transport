import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:singapore_transport/riverpod/favourites_provider.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    List<int> busList = ref.watch(favouritesProvider);
    return busList.isEmpty ? Container(child: Text("No saved favourites yet"))
    : Container();
    // FutureBuilder(future: getNearestBusStations(authToken, latitude, longitude), builder: builder)
  }
}
