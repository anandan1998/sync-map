import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CaseReportingScreen extends StatelessWidget {
  const CaseReportingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Scaffold provides basic app structure
      appBar: AppBar(
        title: const Text('Report New Cases'),
      ),
      body: const CaseReportingForm(), // Embed the CaseReportingForm widget
    );
  }
}

class CaseReportingForm extends StatefulWidget {
  const CaseReportingForm({Key? key}) : super(key: key);

  @override
  _CaseReportingFormState createState() => _CaseReportingFormState();
}

class _CaseReportingFormState extends State<CaseReportingForm> {
  String? selectedRegionName;
  TextEditingController numCasesController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  List<DropdownMenuItem<String>> _dropdownItems = []; // Changed to String

  @override
  void initState() {
    _fetchRegions(); // Fetch regions from Firestore
    super.initState();
  }

  Future<void> _fetchRegions() async {
    try {
      final regionDocs =
          await FirebaseFirestore.instance.collection('regions').get();

      setState(() {
        _dropdownItems = regionDocs.docs
            .map((doc) => DropdownMenuItem<String>(
                  value: doc['shapeName'], // Use shapeName as the value
                  child: Text(doc['shapeName']),
                ))
            .toList();
      });
    } catch (error) {
      // Handle the error (e.g., show a snackbar or alert)
      print('Error fetching regions: $error');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    // ... (same as your existing _selectDate function) ...
  }

  Future<void> _submitData() async {
    // ... your existing _submitData function ...
     if (selectedRegionName == null || numCasesController.text.isEmpty) {
      // Handle case where no region is selected or numCases is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Please select a region and enter the number of cases.')),
      );
      return;
    }

    try {
      // Get the region document using the selected region name
      final regionDoc = await FirebaseFirestore.instance
          .collection('regions')
          .where('shapeName', isEqualTo: selectedRegionName)
          .get();

      if (regionDoc.docs.isNotEmpty) {
        final regionId = regionDoc.docs.first.id;

        final casesCollection = FirebaseFirestore.instance
            .collection('regions')
            .doc(regionId)
            .collection('cases');

        await casesCollection.doc(DateFormat('yyyy-MM-dd').format(selectedDate)).set({
          'numCases': int.parse(numCasesController.text),
          'date': selectedDate, // Store the date for reference (optional)
        });

        // ... (rest of your success handling code) ...
      } else {
        // Handle the case where the region is not found
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Region not found.')),
        );
      }
    } catch (error) {
      // ... (your error handling code) ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // Region Dropdown (without search)
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Select Region'),
            value: selectedRegionName, // Use shapeName as the selected value
            items: _dropdownItems,
            onChanged: (value) {
              setState(() {
                selectedRegionName = value;
              });
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: numCasesController,
            decoration: const InputDecoration(
              labelText: 'Number of Cases',
            ),
            keyboardType: TextInputType.number,
          ),

          const SizedBox(height: 16),

          // Date Picker
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
          ),

          const SizedBox(height: 16),
          // Submit Button
          ElevatedButton(
            onPressed: _submitData, // Use the updated _submitData function
            child: Text("Submit".toUpperCase()),
          ),
        ],
      ),
    );
  }
}
