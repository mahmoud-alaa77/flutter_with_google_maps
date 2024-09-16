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
  Set<Polyline> polyLines = {};
  Set<Polygon> polyGons = {};
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
    // initMarkers();
    // initPolylines();
    initPolygons();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GoogleMap(
        polygons: polyGons,
        polylines: polyLines,
        zoomControlsEnabled: false,
        // markers: markers,
        //mapType: MapType.satellite,
        style: mapStyle,
        onMapCreated: (controller) {
          mapController = controller;
          // initMapStyle();
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(30.109712694237142, 31.5106095812379),
          zoom: 6,
        ),
      ),
      // Positioned(
      //     bottom: 20,
      //     left: 16,
      //     right: 16,
      //     child: FloatingActionButton(
      //         onPressed: () {
      //           setState(() {
      //             mapController.animateCamera(CameraUpdate.newLatLng(
      //                 const LatLng(31.56049009629473, 25.27466807111593)));
      //           });
      //         },
      //         child: const Text("Change Location")))
    ]);
  }

  void initMarkers() async {
    var customIcon = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(30, 30)),
        "assets/images/location.png");
    var myMarkers = places.map((place) => Marker(
        icon: customIcon,
        infoWindow: InfoWindow(title: place.name),
        markerId: MarkerId(place.id.toString()),
        position: place.latLng));
    markers.addAll(myMarkers);
  }

  void initPolylines() {
    Polyline p = const Polyline(polylineId: PolylineId("1"), points: [
      LatLng(30.527345318683327, 31.14296885555196),
      LatLng(30.548340141854784, 31.128549300603158),
      LatLng(30.55321857050778, 31.033105579751563),
      LatLng(322.12994090068492, 36.642809897210775),
    ]);
    polyLines.add(p);
  }

  void initPolygons() {
    Polygon polygon = Polygon(
      holes: [
        [
          LatLng(29.874758138985083, 27.46879482060436),
          LatLng(29.960265827886758, 32.57413349509317),
          LatLng(25.864308621765367, 31.390286845936345),
        ]
      ],
      polygonId: const PolygonId("1"),
      fillColor: Colors.black.withOpacity(.8),
      strokeWidth: 3,
      points: const [
        LatLng(31.66331817316294, 25.14127848024088),
        LatLng(31.17273472409815, 29.911141515268266),
        LatLng(23.940583046127674, 35.0822712584423),
        LatLng(22.067075678781233, 25.04054428135799),
      ],
    );
    polyGons.add(polygon);
  }

  // void initMapStyle() async {
  //   var newMapStyle = await DefaultAssetBundle.of(context)
  //       .loadString("assets/map_styles/dark_map_style.json");
  //   mapController.setMapStyle(newMapStyle);
  // }
}
