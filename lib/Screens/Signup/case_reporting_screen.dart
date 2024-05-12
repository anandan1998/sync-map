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
    //New fetch function, now with %100 more sorting!!
    try {
      final regionDocs =
          await FirebaseFirestore.instance.collection('regions').get();
      //print(regionDocs.docs);

      final sortedRegionDocs = regionDocs.docs..sort((a, b) =>
          (a['shapeName'] as String)
              .toLowerCase()
              .compareTo((b['shapeName'] as String).toLowerCase()));

      setState(() {
        _dropdownItems = sortedRegionDocs
            .map((doc) => DropdownMenuItem<String>( //Change from Map to String
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
// Function to delete all case data
  Future<void> _deleteAllCases() async {
    try {
      final regionsSnapshot =
          await FirebaseFirestore.instance.collection('regions').get();

      for (var regionDoc in regionsSnapshot.docs) {
        final casesCollection = regionDoc.reference.collection('cases');
        final casesSnapshot = await casesCollection.get();
        for (var caseDoc in casesSnapshot.docs) {
          await caseDoc.reference.delete();
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All case data deleted successfully!')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting case data: $error')),
      );
    }
  }

Future<void> _submitData() async {
  if (selectedRegionName == null || numCasesController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please select a region and enter the number of cases.')),
    );
    return;
  }

  try {
    // 1. Get region document by name
    QuerySnapshot regionSnapshot = await FirebaseFirestore.instance
        .collection('regions')
        .where('shapeName', isEqualTo: selectedRegionName)
        .get();

    if (regionSnapshot.docs.isNotEmpty) {
      DocumentSnapshot regionDoc = regionSnapshot.docs.first;
      String regionId = regionDoc.id;

      // 2. Get reference to cases subcollection for the region (use regionId here)
      CollectionReference casesCollection =
          FirebaseFirestore.instance.collection('regions').doc(regionId).collection('cases');

      // 3. Get or create the case document for the selected date
      final dateString = DateFormat('yyyy-MM-dd').format(selectedDate);
      DocumentReference caseDocRef = casesCollection.doc(dateString);
      DocumentSnapshot caseDoc = await caseDocRef.get();

      int existingNumCases = 0;
      if (caseDoc.exists) {
        existingNumCases = caseDoc.get('numCases') as int;
      }

      // 4. Calculate new numCases and update/create the document
      final newNumCases = int.parse(numCasesController.text);
      await caseDocRef.set({
        'numCases': existingNumCases + newNumCases,
        'date': selectedDate, // Optional, include if needed
      });

      // 5. Show success message with details
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Data submitted successfully!\n'
            'Region: $selectedRegionName\n'
            'Cases Added: $newNumCases\n'
            'Total Cases: ${existingNumCases + newNumCases}\n'
            'Date: $dateString',
          ),
        ),
      );

      // 6. Clear the form
      numCasesController.clear();
      setState(() {
        selectedRegionName = null; 
        selectedDate = DateTime.now(); 
      });
    } else {
      // Handle case where the region is not found
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Region not found.')),
      );
    }
  } catch (error) {
    // Handle errors, show an error message to the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error submitting data: $error')),
    );
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
      const SizedBox(height: 16),
          //Delete Button, only for testing dont forget to remove it
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Confirm Delete'),
                  content: const Text(
                      'Are you sure you want to delete all case data? This action cannot be undone.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(), // Cancel
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                        _deleteAllCases(); // Delete data
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
             backgroundColor: Colors.red,
            foregroundColor: Colors.white, // Optional: Set text color to white for contrast
          ),
          child: const Text('Delete All Cases'),
        ),

        ],
      ),
    );
  }
}

