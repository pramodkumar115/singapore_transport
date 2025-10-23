import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return ShadCard(
      width: screenWidth,
      backgroundColor: Theme.of(context).colorScheme.tertiaryFixedDim,
      title: Text("Search"),
      description: Text(""),
      child: Text("Search"),
    );
  }
}
