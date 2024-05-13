import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import '../Login/login_screen.dart';
import "../Welcome/Classes/DataFetcher.dart";
import 'package:intl/intl.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
  late MapShapeSource _shapeSource;
  late List<Model> _data;
  late MapZoomPanBehavior _zoomPanBehavior;
  DateTime selectedDate = DateTime.now(); // State for selected date

  Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2020), // Earliest date to select
    lastDate: DateTime.now(), // User can't select future dates
  );
  if (picked != null && picked != selectedDate) {
    setState(() {
      selectedDate = picked;
    });
  }
}

  @override
  void initState() {
    _data = <Model>[
      const Model('Tulo', 280),
      const Model('Endiguagn', 190),
      const Model('Limu', 37),
      const Model('Geta', 310)
    ];
    _shapeSource = MapShapeSource.asset(
      'ethiopia.json',
      shapeDataField: 'shapeName',
      dataCount: _data.length,
      primaryValueMapper: (int index) => _data[index].name,
      shapeColorValueMapper: (int index) => _data[index].density,
      shapeColorMappers: [
        const MapColorMapper(from: 0, to: 100, color: Colors.red, text: 'explanation'),
        const MapColorMapper(from: 101, to: 200, color: Colors.green, text: 'explanation'),
        const MapColorMapper(from: 201, to: 300, color: Colors.blue, text: 'explanation'),
        const MapColorMapper(from: 301, to: 400, color: Colors.orange, text: 'explanation'),
      ],
    );
    _zoomPanBehavior = MapZoomPanBehavior(enableDoubleTapZooming: true);

    super.initState();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Outbreak Tracker"),
        actions: <Widget>[
          // Date Selection Button (Using _selectDate directly)
          Flexible(
          child:ElevatedButton(
            onPressed: () => _selectDate(context),
            child: Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
          ),

          const SizedBox(width: 10), // Add spacing between buttons

          // Login Button (Existing)
          Flexible(
          child:SizedBox(
            width: 100, 
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Text('Login'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, 
                backgroundColor: Theme.of(context).primaryColor, 
                padding: const EdgeInsets.symmetric(horizontal: 8), 
              ),
            ),
          ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SfMaps(
          layers: [
            MapShapeLayer(
              source: _shapeSource, 
              strokeColor: Colors.white,
              strokeWidth: 1.0,
              zoomPanBehavior: _zoomPanBehavior,
              legend: const MapLegend(MapElement.shape),
            ),
          ],
        ),
      ),
    );
  }
}

class Model {
  const Model(this.name, this.density);

  final String name;
  final double density;
}
