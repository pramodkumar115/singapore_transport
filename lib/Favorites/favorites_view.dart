import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return ShadCard(
      width: screenWidth,
      backgroundColor: Theme.of(context).colorScheme.tertiaryFixedDim,
      title: Text("Favorites"),
      description: Text(""),
      child: Text("Favorites"),
    );
  }
}
