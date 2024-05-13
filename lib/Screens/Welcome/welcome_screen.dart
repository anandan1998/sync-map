import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import '../Login/login_screen.dart';
import "../Welcome/Classes/DataFetcher.dart";
import 'package:intl/intl.dart';
import 'package:flutter_auth/model.dart'; // data model

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
  MapShapeSource? _shapeSource;
  List<Model> _data = [];
  late MapZoomPanBehavior _zoomPanBehavior;
  DateTime selectedDate = DateTime.now();
  final DataFetcher _dataFetcher = DataFetcher();
  

  @override
  void initState() {
    super.initState();
    _zoomPanBehavior = MapZoomPanBehavior(enableDoubleTapZooming: true);
    _fetchData(); 
  }

  Future<void> _fetchData() async {
    try {
      final fetchedData = await _dataFetcher.fetchRegionCaseDataLast30Days(selectedDate);
      setState(() {
        _data = fetchedData;

        // Initialize _shapeSource only if it's not already initialized
        _shapeSource ??= MapShapeSource.asset(
          'assets/ethiopia.json', // Assuming your JSON file is in the 'assets' folder
          shapeDataField: 'shapeName',
          dataCount: _data.length,
          primaryValueMapper: (int index) => _data[index].name,
          shapeColorValueMapper: (int index) => _data[index].density,
          shapeColorMappers: [
            const MapColorMapper(from: 0, to: 100, color: Colors.red, text: '<100'),
            const MapColorMapper(from: 101, to: 200, color: Colors.orange, text: '101-200'),
            const MapColorMapper(from: 201, to: 300, color: Colors.yellow, text: '201-300'),
            const MapColorMapper(from: 301, to: 400, color: Colors.green, text: '>300'),
          ],
        );
      });
    } catch (error) {
      print('Error fetching data: $error');
      // Handle the error (e.g., show a snackbar to the user)
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      _fetchData(); // Re-fetch data when the date changes
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Outbreak Tracker"),
        actions: <Widget>[
          Flexible(
            child: ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: SizedBox(
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
        child: _shapeSource != null
            ? SfMaps(
                layers: [
                  MapShapeLayer(
                    source: _shapeSource!, 
                    strokeColor: Colors.white,
                    strokeWidth: 1.0,
                    zoomPanBehavior: _zoomPanBehavior,
                    legend: const MapLegend(MapElement.shape),
                    shapeTooltipBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(7),
                        child: Column(
                          children: [
                            Text(_data[index].name),
                            Text('infected: ${_data[index].density.toInt()}'), // Convert to int for display
                          ],
                        ),
                      );
                    },
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator()), 
      ),
    );
  }
}
