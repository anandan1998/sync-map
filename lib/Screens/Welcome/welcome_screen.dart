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
  late MapShapeSource? _shapeSource;
  late List<Model> _data = [];
  late List<String> _time = ['30 days', '7 days', '1 day'];
  MapZoomPanBehavior _zoomPanBehavior = MapZoomPanBehavior(enableDoubleTapZooming: true);
  DateTime selectedDate = DateTime.now();
  bool _isLoading = true;
  final DataFetcher _dataFetcher = DataFetcher();
  

  @override
  void initState() {
    _fetchData(); 
    super.initState();
  }


  Future<void> _fetchData() async {
    setState(() => _isLoading = true); // Start loading

    try {
      final fetchedData = await _dataFetcher.fetchRegionCaseDataLast30Days(selectedDate);
      // Initialize shapeSource AFTER data is fetched
      _shapeSource = MapShapeSource.asset(
        'assets/ethiopia.json',
        shapeDataField: 'shapeName',
        dataCount: fetchedData.length, // Use fetchedData.length here
        primaryValueMapper: (int index) => fetchedData[index].name,
        shapeColorValueMapper: (int index) => fetchedData[index].density,
        shapeColorMappers: [
          const MapColorMapper(from: 1, to: 99, color: Colors.yellow, text: '<100'),
          const MapColorMapper(from: 100, to: 200, color: Color.fromARGB(255, 255, 102, 102), text: '100-200'),
          const MapColorMapper(from: 201, to: 300, color: Color.fromARGB(255, 255, 0, 0), text: '201-300'),
          const MapColorMapper(from: 301, to: double.infinity, color: Color.fromARGB(255, 153, 0, 0), text: '>300'),
        ],
      );
      setState(() {
        _data = fetchedData;
        _isLoading = false; // Stop loading
      });
    } catch (error) {
      print('Error fetching data: $error');
      setState(() => _isLoading = false); // Stop loading in case of error
      // Show SnackBar error message here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $error')),
      );
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
            child: SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () => _selectDate(context),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
                child: Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
              ),
            ),
          ),
          Flexible(
            child: SizedBox(
              width: 200,
              child: MyDropdownButton(),
            ),
          ),
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
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
                child: const Text('Login'),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SfMaps(
                layers: [
                  MapShapeLayer(
                    source: _shapeSource!,
                    strokeColor: Colors.white,
                    strokeWidth: 1.0,
                    zoomPanBehavior: _zoomPanBehavior,
                    legend: const MapLegend(MapElement.shape),
                    shapeTooltipBuilder: (BuildContext context, int index) {
                      return Container(
                        color: Color.fromARGB(255, 207, 206, 206), // Set the color of the tooltip
                        constraints: BoxConstraints(maxHeight: 80.0), // Set the maximum height of the tooltip
                        child: Padding(
                          padding: const EdgeInsets.all(7),
                          child: Column(
                            children: [
                              Text(_data[index].name),
                              Text('infected: ${_data[index].density.toInt()}'), // Convert to int for display
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
    }
  }

  class MyDropdownButton extends StatefulWidget {
  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String dropdownValue = '30 days';
  List<String> timeOptions = ['30 days', '7 days', '1 day'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border.all(color: const Color.fromARGB(255, 253, 253, 254)),
        borderRadius: BorderRadius.circular(50),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropdownValue,
          dropdownColor: Theme.of(context).primaryColor,
          style: TextStyle(color: Colors.white, fontSize: 18),
          icon: Icon(Icons.arrow_drop_down, color: Colors.white),  // Set the icon color here
          items: timeOptions.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
        ),
      ),
    );
  }
}
