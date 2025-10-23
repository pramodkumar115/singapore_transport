import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BusView extends StatefulWidget {
  const BusView({ super.key });

  @override
  State<BusView> createState() => _BusViewState();
}

class _BusViewState extends State<BusView> {
  @override
  Widget build(BuildContext context) {
    // final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    
    return ShadCard(
      width: screenWidth,
      backgroundColor: Theme.of(context).colorScheme.tertiaryFixedDim,
      title: Text("Bus Stations near you"),
      description: Text(""),
      child: Text("Bus"),
      
    );
  }
}