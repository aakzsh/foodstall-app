import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Mapview extends StatefulWidget {
  const Mapview({Key? key}) : super(key: key);

  @override
  State<Mapview> createState() => _MapviewState();
}

class _MapviewState extends State<Mapview> {
  double doubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;
  List<Marker> allMarkers = [];
  int _sliderVal = 10 ~/ 10;

  @override
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      var r = Random();
      for (var x = 0; x < 10; x++) {
        allMarkers.add(
          Marker(
            point: LatLng(
              doubleInRange(r, 37, 55),
              doubleInRange(r, -9, 30),
            ),
            builder: (context) => const Icon(
              Icons.circle,
              color: Colors.red,
              size: 12.0,
            ),
          ),
        );
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(50, 20),
          zoom: 5.0,
          interactiveFlags: InteractiveFlag.all - InteractiveFlag.rotate,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          MarkerLayerOptions(
              markers:
                  allMarkers.sublist(0, min(allMarkers.length, _sliderVal))),
        ],
      ),
    );
  }
}
