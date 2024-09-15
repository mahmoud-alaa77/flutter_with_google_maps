import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/google_maps_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: GoogleMapsWidget(),
      ),
    );
  }
}
