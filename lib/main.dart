import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Maps with GeoJSON'),
        ),
        body: MapSample(),
      ),
    );
  }
}

class MapSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SfMaps(
      layers: <MapLayer>[
        MapShapeLayer(
          source: _getGeoJSONDataSource(),
          showDataLabels: true, // Set to true to display labels for areas
          tooltipSettings: MapTooltipSettings(
            // Configure tooltip settings
            color: Colors.grey[700],
          ),
          strokeColor: Colors.white, // Outline color for shapes
          strokeWidth: 1.0, // Outline width for shapes
        ),
      ],
    );
  }

  MapShapeSource _getGeoJSONDataSource() {
    return MapShapeSource.asset(
      'ethiopia.json', // Path to the GeoJSON file
      shapeDataField: 'geometry', // Field in GeoJSON containing the shape data
      dataCount: 1, // Number of features in the GeoJSON data
      primaryValueMapper: (int index) => index.toString(), // Mapper for primary values
    );
  }
}