import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MapShapeSource _shapeSource;
  late List<Model> _data;
  late MapZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
     _data = <Model>[
      Model('Tulo', 280),
      Model('Endiguagn', 190),
      Model('Limu', 37),
      Model('Geta', 310)
  ];
   _shapeSource = MapShapeSource.asset(
      'ethiopia.json',
      shapeDataField: 'shapeName',
      dataCount: _data.length,
      primaryValueMapper: (int index) => _data[index].country,
      shapeColorValueMapper: (int index) => _data[index].density,
      shapeColorMappers: [
        MapColorMapper(from: 0, to: 100, color: Colors.red, text: '< 100/km'),
        MapColorMapper(
            from: 101, to: 200, color: Colors.green, text: '100 - 200/km'),
        MapColorMapper(
            from: 201, to: 300, color: Colors.blue, text: '200 - 300/km'),
        MapColorMapper(
            from: 301, to: 400, color: Colors.orange, text: '300 - 400/km'),
        ]
    );
    _zoomPanBehavior = MapZoomPanBehavior(enableDoubleTapZooming: true);
   
    super.initState();
  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 50, 0, 0),
        child: SfMaps(layers: [MapShapeLayer(
          source: _shapeSource, 
          strokeColor: Colors.white,
          strokeWidth: 1.0,
          zoomPanBehavior: _zoomPanBehavior,
          legend: MapLegend(MapElement.shape)
          // selectionChanged: (MapSelectionChangedDetails details) {
          //   final MapShapeDataModel model = details.model;
          //   print('Selected area: ${model.data['shapeName']}');
          // },
          ),
          ],),
      ),
    );
  }
}
class Model {
  const Model(this.country, this.density);

  final String country;
  final double density;
  // final DateTime date;
}