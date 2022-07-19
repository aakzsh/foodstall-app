import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late MapShapeSource _mapSource;

  @override
  void initState() {
    _mapSource = MapShapeSource.asset(
      'assets/world_map.json',
      shapeDataField: 'STATE_NAME',
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfMaps(
        layers: [
          MapShapeLayer(
            source: _mapSource,
          )
        ],
      ),
    );
  }
}
