import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_with_google_maps/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsWidget extends StatefulWidget {
  const GoogleMapsWidget({super.key});

  @override
  State<GoogleMapsWidget> createState() => _GoogleMapsWidgetState();
}

late GoogleMapController mapController;

class _GoogleMapsWidgetState extends State<GoogleMapsWidget> {
  String mapStyle = '';
  Set<Marker> markers = {};
  @override
  void initState() {
    super.initState();
    rootBundle
        .loadString('assets/map_styles/dark_map_style.json')
        .then((String style) {
      setState(() {
        mapStyle = style;
      });
    });
    initMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GoogleMap(
        markers: markers,
        //mapType: MapType.satellite,
        style: mapStyle,
        onMapCreated: (controller) {
          mapController = controller;
          // initMapStyle();
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(30.560073234352902, 31.1513466305802),
          zoom: 10,
        ),
      ),
      Positioned(
          bottom: 20,
          left: 16,
          right: 16,
          child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  mapController.animateCamera(CameraUpdate.newLatLng(
                      const LatLng(31.56049009629473, 25.27466807111593)));
                });
              },
              child: const Text("Change Location")))
    ]);
  }

  void initMarkers()async {
    var customIcon= await BitmapDescriptor.asset(ImageConfiguration(
      size: Size(30, 30)
    ),"assets/images/location.png" );
    var myMarkers = places.map((place) => Marker(
      icon: customIcon,
      
      infoWindow: InfoWindow(title: place.name),
        markerId: MarkerId(place.id.toString()), position: place.latLng));
    markers.addAll(myMarkers);
  }

  // void initMapStyle() async {
  //   var newMapStyle = await DefaultAssetBundle.of(context)
  //       .loadString("assets/map_styles/dark_map_style.json");
  //   mapController.setMapStyle(newMapStyle);
  // }
}
