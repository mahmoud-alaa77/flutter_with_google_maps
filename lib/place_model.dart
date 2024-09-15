import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;

  PlaceModel({required this.id, required this.name, required this.latLng});
}

List<PlaceModel> places = [
  PlaceModel(id: 1, name: "طنطا", latLng: const LatLng(30.787655752244596, 31.03155552044285)),
    PlaceModel(id: 2, name: "بنها", latLng: const LatLng(30.466659586713167, 31.222697427337966)),

  PlaceModel(id: 3, name:  "قويسنا", latLng: const LatLng(30.562543815522805, 31.159950216635334)),

];
