import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CaseReportingScreen extends StatelessWidget {
  const CaseReportingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report New Cases'),
      ),
      body: const CaseReportingForm(),
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
  List<DropdownMenuItem<String>> _dropdownItems = [];

  @override
  void initState() {
    _fetchRegions();
    super.initState();
  }

  Future<void> _fetchRegions() async {
    try {
      final regionDocs = await FirebaseFirestore.instance.collection('regions').get();
      final sortedRegionDocs = regionDocs.docs
        ..sort((a, b) => (a['shapeName'] as String).toLowerCase().compareTo((b['shapeName'] as String).toLowerCase()));
      setState(() {
        _dropdownItems = sortedRegionDocs
            .map((doc) => DropdownMenuItem<String>(
                  value: doc['shapeName'],
                  child: Text(doc['shapeName']),
                ))
            .toList();
      });
    } catch (error) {
      print('Error fetching regions: $error');
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
    }
  }

  Future<void> _deleteAllCases() async {
    try {
      final regionsSnapshot = await FirebaseFirestore.instance.collection('regions').get();
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
      QuerySnapshot regionSnapshot = await FirebaseFirestore.instance
          .collection('regions')
          .where('shapeName', isEqualTo: selectedRegionName)
          .get();

      if (regionSnapshot.docs.isNotEmpty) {
        DocumentSnapshot regionDoc = regionSnapshot.docs.first;
        String regionId = regionDoc.id;

        CollectionReference casesCollection =
            FirebaseFirestore.instance.collection('regions').doc(regionId).collection('cases');

        final dateString = DateFormat('yyyy-MM-dd').format(selectedDate);
        DocumentReference caseDocRef = casesCollection.doc(dateString);
        DocumentSnapshot caseDoc = await caseDocRef.get();

        int existingNumCases = 0;
        if (caseDoc.exists) {
          existingNumCases = caseDoc.get('numCases') as int;
        }

        final newNumCases = int.parse(numCasesController.text);
        await caseDocRef.set({
          'numCases': existingNumCases + newNumCases,
          'date': selectedDate,
        });

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

        numCasesController.clear();
        setState(() {
          selectedRegionName = null;
          selectedDate = DateTime.now();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Region not found.')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting data: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400), // Increased the container's width
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Report New Cases',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Select Region',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    value: selectedRegionName,
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
                    decoration: InputDecoration(
                      labelText: 'Number of Cases',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 8), // Reduced the padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.calendar_today, size: 20), // Reduced the icon size
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('yyyy-MM-dd').format(selectedDate),
                          style: TextStyle(fontSize: 14), // Reduced the font size
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _submitData,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 8), // Reduced the padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 14, color: Colors.white), // Reduced the font size
                    ),
                  ),
                  const SizedBox(height: 16),
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
                              onPressed: () => Navigator.of(context).pop(),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.blue.shade800,
                                padding: EdgeInsets.symmetric(vertical: 8), // Reduced the padding
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                _deleteAllCases();
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                                padding: EdgeInsets.symmetric(vertical: 8), // Reduced the padding
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 8), // Reduced the padding
                      backgroundColor: Color.fromARGB(255, 26, 10, 114),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Undo',
                      style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 255, 255, 255)), // Reduced the font size
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// working as expected
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class CaseReportingScreen extends StatelessWidget {
//   const CaseReportingScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Report New Cases'),
//       ),
//       body: const CaseReportingForm(),
//     );
//   }
// }

// class CaseReportingForm extends StatefulWidget {
//   const CaseReportingForm({Key? key}) : super(key: key);

//   @override
//   _CaseReportingFormState createState() => _CaseReportingFormState();
// }

// class _CaseReportingFormState extends State<CaseReportingForm> {
//   String? selectedRegionName;
//   TextEditingController numCasesController = TextEditingController();
//   DateTime selectedDate = DateTime.now();
//   List<DropdownMenuItem<String>> _dropdownItems = [];

//   @override
//   void initState() {
//     _fetchRegions();
//     super.initState();
//   }

//   Future<void> _fetchRegions() async {
//     try {
//       final regionDocs = await FirebaseFirestore.instance.collection('regions').get();
//       final sortedRegionDocs = regionDocs.docs
//         ..sort((a, b) => (a['shapeName'] as String).toLowerCase().compareTo((b['shapeName'] as String).toLowerCase()));
//       setState(() {
//         _dropdownItems = sortedRegionDocs
//             .map((doc) => DropdownMenuItem<String>(
//                   value: doc['shapeName'],
//                   child: Text(doc['shapeName']),
//                 ))
//             .toList();
//       });
//     } catch (error) {
//       print('Error fetching regions: $error');
//     }
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2020),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }

//   Future<void> _deleteAllCases() async {
//     try {
//       final regionsSnapshot = await FirebaseFirestore.instance.collection('regions').get();
//       for (var regionDoc in regionsSnapshot.docs) {
//         final casesCollection = regionDoc.reference.collection('cases');
//         final casesSnapshot = await casesCollection.get();
//         for (var caseDoc in casesSnapshot.docs) {
//           await caseDoc.reference.delete();
//         }
//       }
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('All case data deleted successfully!')),
//       );
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error deleting case data: $error')),
//       );
//     }
//   }

//   Future<void> _submitData() async {
//     if (selectedRegionName == null || numCasesController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select a region and enter the number of cases.')),
//       );
//       return;
//     }

//     try {
//       QuerySnapshot regionSnapshot = await FirebaseFirestore.instance
//           .collection('regions')
//           .where('shapeName', isEqualTo: selectedRegionName)
//           .get();

//       if (regionSnapshot.docs.isNotEmpty) {
//         DocumentSnapshot regionDoc = regionSnapshot.docs.first;
//         String regionId = regionDoc.id;

//         CollectionReference casesCollection =
//             FirebaseFirestore.instance.collection('regions').doc(regionId).collection('cases');

//         final dateString = DateFormat('yyyy-MM-dd').format(selectedDate);
//         DocumentReference caseDocRef = casesCollection.doc(dateString);
//         DocumentSnapshot caseDoc = await caseDocRef.get();

//         int existingNumCases = 0;
//         if (caseDoc.exists) {
//           existingNumCases = caseDoc.get('numCases') as int;
//         }

//         final newNumCases = int.parse(numCasesController.text);
//         await caseDocRef.set({
//           'numCases': existingNumCases + newNumCases,
//           'date': selectedDate,
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Data submitted successfully!\n'
//               'Region: $selectedRegionName\n'
//               'Cases Added: $newNumCases\n'
//               'Total Cases: ${existingNumCases + newNumCases}\n'
//               'Date: $dateString',
//             ),
//           ),
//         );

//         numCasesController.clear();
//         setState(() {
//           selectedRegionName = null;
//           selectedDate = DateTime.now();
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Region not found.')),
//         );
//       }
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error submitting data: $error')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16.0),
//       child: Center(
//         child: Card(
//           elevation: 1,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   'Report New Cases',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 16),
//                 DropdownButtonFormField<String>(
//                   decoration: InputDecoration(
//                     labelText: 'Select Region',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   value: selectedRegionName,
//                   items: _dropdownItems,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedRegionName = value;
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: numCasesController,
//                   decoration: InputDecoration(
//                     labelText: 'Number of Cases',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   keyboardType: TextInputType.number,
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () => _selectDate(context),
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(Icons.calendar_today),
//                       const SizedBox(width: 8),
//                       Text(
//                         DateFormat('yyyy-MM-dd').format(selectedDate),
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: _submitData,
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text(
//                     'Submit',
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: const Text('Confirm Delete'),
//                         content: const Text(
//                             'Are you sure you want to delete all case data? This action cannot be undone.'),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.of(context).pop(),
//                             style: TextButton.styleFrom(
//                               foregroundColor: Colors.blue.shade800,
//                               padding: EdgeInsets.symmetric(vertical: 16),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: const Text('Cancel'),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                               _deleteAllCases();
//                             },
//                             style: TextButton.styleFrom(
//                               foregroundColor: Colors.red,
//                               padding: EdgeInsets.symmetric(vertical: 16),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: const Text('Delete'),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                     backgroundColor: Colors.red,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text(
//                     'Delete All Cases',
//                     style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 2, 79, 33)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

                     

// working 2
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class CaseReportingScreen extends StatelessWidget {
//   const CaseReportingScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Report New Cases'),
//       ),
//       body: const CaseReportingForm(),
//     );
//   }
// }

// class CaseReportingForm extends StatefulWidget {
//   const CaseReportingForm({Key? key}) : super(key: key);

//   @override
//   _CaseReportingFormState createState() => _CaseReportingFormState();
// }

// class _CaseReportingFormState extends State<CaseReportingForm> {
//   String? selectedRegionName;
//   TextEditingController numCasesController = TextEditingController();
//   DateTime selectedDate = DateTime.now();
//   List<DropdownMenuItem<String>> _dropdownItems = [];

//   @override
//   void initState() {
//     _fetchRegions();
//     super.initState();
//   }

//   Future<void> _fetchRegions() async {
//     try {
//       final regionDocs = await FirebaseFirestore.instance.collection('regions').get();
//       final sortedRegionDocs = regionDocs.docs..sort((a, b) =>
//           (a['shapeName'] as String).toLowerCase().compareTo((b['shapeName'] as String).toLowerCase()));

//       setState(() {
//         _dropdownItems = sortedRegionDocs.map((doc) => DropdownMenuItem<String>(
//           value: doc['shapeName'],
//           child: Text(doc['shapeName']),
//         )).toList();
//       });
//     } catch (error) {
//       print('Error fetching regions: $error');
//     }
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2020),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }

//   Future<void> _deleteAllCases() async {
//     try {
//       final regionsSnapshot = await FirebaseFirestore.instance.collection('regions').get();
//       for (var regionDoc in regionsSnapshot.docs) {
//         final casesCollection = regionDoc.reference.collection('cases');
//         final casesSnapshot = await casesCollection.get();
//         for (var caseDoc in casesSnapshot.docs) {
//           await caseDoc.reference.delete();
//         }
//       }

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('All case data deleted successfully!')),
//       );
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error deleting case data: $error')),
//       );
//     }
//   }

//   Future<void> _submitData() async {
//     if (selectedRegionName == null || numCasesController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select a region and enter the number of cases.')),
//       );
//       return;
//     }

//     try {
//       QuerySnapshot regionSnapshot = await FirebaseFirestore.instance
//           .collection('regions')
//           .where('shapeName', isEqualTo: selectedRegionName)
//           .get();

//       if (regionSnapshot.docs.isNotEmpty) {
//         DocumentSnapshot regionDoc = regionSnapshot.docs.first;
//         String regionId = regionDoc.id;

//         CollectionReference casesCollection =
//             FirebaseFirestore.instance.collection('regions').doc(regionId).collection('cases');

//         final dateString = DateFormat('yyyy-MM-dd').format(selectedDate);
//         DocumentReference caseDocRef = casesCollection.doc(dateString);
//         DocumentSnapshot caseDoc = await caseDocRef.get();

//         int existingNumCases = 0;
//         if (caseDoc.exists) {
//           existingNumCases = caseDoc.get('numCases') as int;
//         }

//         final newNumCases = int.parse(numCasesController.text);
//         await caseDocRef.set({
//           'numCases': existingNumCases + newNumCases,
//           'date': selectedDate,
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Data submitted successfully!\n'
//               'Region: $selectedRegionName\n'
//               'Cases Added: $newNumCases\n'
//               'Total Cases: ${existingNumCases + newNumCases}\n'
//               'Date: $dateString',
//             ),
//           ),
//         );

//         numCasesController.clear();
//         setState(() {
//           selectedRegionName = null;
//           selectedDate = DateTime.now();
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Region not found.')),
//         );
//       }
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error submitting data: $error')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16.0),
//       child: Center(
//         child: Container(
//           padding: const EdgeInsets.all(20.0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15.0),
//             gradient: LinearGradient(
//               colors: [Colors.blue.shade300, Colors.blue.shade800],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 10,
//                 offset: Offset(0, 5),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Reporting New Outbreak',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               DropdownButtonFormField<String>(
//                 decoration: InputDecoration(
//                   labelText: 'Select Region',
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//                 value: selectedRegionName,
//                 items: _dropdownItems,
//                 onChanged: (value) {
//                   setState(() {
//                     selectedRegionName = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: numCasesController,
//                 decoration: InputDecoration(
//                   labelText: 'Number of Cases',
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () => _selectDate(context),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.blue.shade800,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: Text(
//                   DateFormat('yyyy-MM-dd').format(selectedDate),
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _submitData,
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                     backgroundColor: Colors.green,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: Text(
//                     "Submit".toUpperCase(),
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: const Text('Confirm Delete'),
//                         content: const Text(
//                             'Are you sure you want to delete all case data? This action cannot be undone.'),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.of(context).pop(),
//                             child: const Text('Cancel'),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                               _deleteAllCases();
//                             },
//                             child: const Text('Delete'),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                     backgroundColor: Colors.red,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text(
//                     'Delete All Cases',
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// working1 
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class CaseReportingScreen extends StatelessWidget {
//   const CaseReportingScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Report New Cases'),
//       ),
//       body: const CaseReportingForm(),
//     );
//   }
// }

// class CaseReportingForm extends StatefulWidget {
//   const CaseReportingForm({Key? key}) : super(key: key);

//   @override
//   _CaseReportingFormState createState() => _CaseReportingFormState();
// }

// class _CaseReportingFormState extends State<CaseReportingForm> {
//   String? selectedRegionName;
//   TextEditingController numCasesController = TextEditingController();
//   DateTime selectedDate = DateTime.now();
//   List<DropdownMenuItem<String>> _dropdownItems = [];

//   @override
//   void initState() {
//     _fetchRegions();
//     super.initState();
//   }

//   Future<void> _fetchRegions() async {
//     try {
//       final regionDocs = await FirebaseFirestore.instance.collection('regions').get();
//       final sortedRegionDocs = regionDocs.docs..sort((a, b) =>
//           (a['shapeName'] as String).toLowerCase().compareTo((b['shapeName'] as String).toLowerCase()));

//       setState(() {
//         _dropdownItems = sortedRegionDocs.map((doc) => DropdownMenuItem<String>(
//           value: doc['shapeName'],
//           child: Text(doc['shapeName']),
//         )).toList();
//       });
//     } catch (error) {
//       print('Error fetching regions: $error');
//     }
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2020),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }

//   Future<void> _deleteAllCases() async {
//     try {
//       final regionsSnapshot = await FirebaseFirestore.instance.collection('regions').get();
//       for (var regionDoc in regionsSnapshot.docs) {
//         final casesCollection = regionDoc.reference.collection('cases');
//         final casesSnapshot = await casesCollection.get();
//         for (var caseDoc in casesSnapshot.docs) {
//           await caseDoc.reference.delete();
//         }
//       }

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('All case data deleted successfully!')),
//       );
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error deleting case data: $error')),
//       );
//     }
//   }

//   Future<void> _submitData() async {
//     if (selectedRegionName == null || numCasesController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select a region and enter the number of cases.')),
//       );
//       return;
//     }

//     try {
//       QuerySnapshot regionSnapshot = await FirebaseFirestore.instance
//           .collection('regions')
//           .where('shapeName', isEqualTo: selectedRegionName)
//           .get();

//       if (regionSnapshot.docs.isNotEmpty) {
//         DocumentSnapshot regionDoc = regionSnapshot.docs.first;
//         String regionId = regionDoc.id;

//         CollectionReference casesCollection =
//             FirebaseFirestore.instance.collection('regions').doc(regionId).collection('cases');

//         final dateString = DateFormat('yyyy-MM-dd').format(selectedDate);
//         DocumentReference caseDocRef = casesCollection.doc(dateString);
//         DocumentSnapshot caseDoc = await caseDocRef.get();

//         int existingNumCases = 0;
//         if (caseDoc.exists) {
//           existingNumCases = caseDoc.get('numCases') as int;
//         }

//         final newNumCases = int.parse(numCasesController.text);
//         await caseDocRef.set({
//           'numCases': existingNumCases + newNumCases,
//           'date': selectedDate,
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Data submitted successfully!\n'
//               'Region: $selectedRegionName\n'
//               'Cases Added: $newNumCases\n'
//               'Total Cases: ${existingNumCases + newNumCases}\n'
//               'Date: $dateString',
//             ),
//           ),
//         );

//         numCasesController.clear();
//         setState(() {
//           selectedRegionName = null;
//           selectedDate = DateTime.now();
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Region not found.')),
//         );
//       }
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error submitting data: $error')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16.0),
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         elevation: 5,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Reporting New Outbreak',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               DropdownButtonFormField<String>(
//                 decoration: const InputDecoration(labelText: 'Select Region'),
//                 value: selectedRegionName,
//                 items: _dropdownItems,
//                 onChanged: (value) {
//                   setState(() {
//                     selectedRegionName = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: numCasesController,
//                 decoration: const InputDecoration(
//                   labelText: 'Number of Cases',
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () => _selectDate(context),
//                       child: Text(
//                         DateFormat('yyyy-MM-dd').format(selectedDate),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _submitData,
//                   child: Text("Submit".toUpperCase()),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: const Text('Confirm Delete'),
//                         content: const Text(
//                             'Are you sure you want to delete all case data? This action cannot be undone.'),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.of(context).pop(),
//                             child: const Text('Cancel'),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                               _deleteAllCases();
//                             },
//                             child: const Text('Delete'),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     foregroundColor: Colors.white,
//                   ),
//                   child: const Text('Delete All Cases'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class CaseReportingScreen extends StatelessWidget {
//   const CaseReportingScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold( // Scaffold provides basic app structure
//       appBar: AppBar(
//         title: const Text('Report New Cases'),
//       ),
//       body: const CaseReportingForm(), // Embed the CaseReportingForm widget
//     );
//   }
// }

// class CaseReportingForm extends StatefulWidget {
//   const CaseReportingForm({Key? key}) : super(key: key);

//   @override
//   _CaseReportingFormState createState() => _CaseReportingFormState();
// }

// class _CaseReportingFormState extends State<CaseReportingForm> {
//   String? selectedRegionName;
//   TextEditingController numCasesController = TextEditingController();
//   DateTime selectedDate = DateTime.now();
//   List<DropdownMenuItem<String>> _dropdownItems = []; // Changed to String

//   @override
//   void initState() {
//     _fetchRegions(); // Fetch regions from Firestore
//     super.initState();
//   }

//   Future<void> _fetchRegions() async {
//     //New fetch function, now with %100 more sorting!!
//     try {
//       final regionDocs =
//           await FirebaseFirestore.instance.collection('regions').get();
//       //print(regionDocs.docs);

//       final sortedRegionDocs = regionDocs.docs..sort((a, b) =>
//           (a['shapeName'] as String)
//               .toLowerCase()
//               .compareTo((b['shapeName'] as String).toLowerCase()));

//       setState(() {
//         _dropdownItems = sortedRegionDocs
//             .map((doc) => DropdownMenuItem<String>( //Change from Map to String
//                   value: doc['shapeName'], // Use shapeName as the value
//                   child: Text(doc['shapeName']),
//                 ))
//             .toList();
//       });
//     } catch (error) {
//       // Handle the error (e.g., show a snackbar or alert)
//       print('Error fetching regions: $error');
//     }
//   }



// Future<void> _selectDate(BuildContext context) async {
//   final DateTime? picked = await showDatePicker(
//     context: context,
//     initialDate: selectedDate,
//     firstDate: DateTime(2020), // Earliest date to select
//     lastDate: DateTime.now(), // User can't select future dates
//   );
//   if (picked != null && picked != selectedDate) {
//     setState(() {
//       selectedDate = picked;
//     });
//   }
// }
// // Function to delete all case data
//   Future<void> _deleteAllCases() async {
//     try {
//       final regionsSnapshot =
//           await FirebaseFirestore.instance.collection('regions').get();

//       for (var regionDoc in regionsSnapshot.docs) {
//         final casesCollection = regionDoc.reference.collection('cases');
//         final casesSnapshot = await casesCollection.get();
//         for (var caseDoc in casesSnapshot.docs) {
//           await caseDoc.reference.delete();
//         }
//       }

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('All case data deleted successfully!')),
//       );
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error deleting case data: $error')),
//       );
//     }
//   }

// Future<void> _submitData() async {
//   if (selectedRegionName == null || numCasesController.text.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Please select a region and enter the number of cases.')),
//     );
//     return;
//   }

//   try {
//     // 1. Get region document by name
//     QuerySnapshot regionSnapshot = await FirebaseFirestore.instance
//         .collection('regions')
//         .where('shapeName', isEqualTo: selectedRegionName)
//         .get();

//     if (regionSnapshot.docs.isNotEmpty) {
//       DocumentSnapshot regionDoc = regionSnapshot.docs.first;
//       String regionId = regionDoc.id;

//       // 2. Get reference to cases subcollection for the region (use regionId here)
//       CollectionReference casesCollection =
//           FirebaseFirestore.instance.collection('regions').doc(regionId).collection('cases');

//       // 3. Get or create the case document for the selected date
//       final dateString = DateFormat('yyyy-MM-dd').format(selectedDate);
//       DocumentReference caseDocRef = casesCollection.doc(dateString);
//       DocumentSnapshot caseDoc = await caseDocRef.get();

//       int existingNumCases = 0;
//       if (caseDoc.exists) {
//         existingNumCases = caseDoc.get('numCases') as int;
//       }

//       // 4. Calculate new numCases and update/create the document
//       final newNumCases = int.parse(numCasesController.text);
//       await caseDocRef.set({
//         'numCases': existingNumCases + newNumCases,
//         'date': selectedDate, // include if needed
//       });

//       // 5. Show success message with details
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Data submitted successfully!\n'
//             'Region: $selectedRegionName\n'
//             'Cases Added: $newNumCases\n'
//             'Total Cases: ${existingNumCases + newNumCases}\n'
//             'Date: $dateString',
//           ),
//         ),
//       );

//       // 6. Clear the form
//       numCasesController.clear();
//       setState(() {
//         selectedRegionName = null; 
//         selectedDate = DateTime.now(); 
//       });
//     } else {
//       // Handle case where the region is not found
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Region not found.')),
//       );
//     }
//   } catch (error) {
//     // Handle errors, show an error message to the user
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Error submitting data: $error')),
//     );
//   }
// }

// @override
//   Widget build(BuildContext context) {
//     return Form(
//       child: Column(
//         children: [
//           // Region Dropdown (without search)
//           DropdownButtonFormField<String>(
//             decoration: const InputDecoration(labelText: 'Select Region'),
//             value: selectedRegionName, // Use shapeName as the selected value
//             items: _dropdownItems,
//             onChanged: (value) {
//               setState(() {
//                 selectedRegionName = value;
//               });
//             },
//           ),
//           const SizedBox(height: 16),
//           TextFormField(
//             controller: numCasesController,
//             decoration: const InputDecoration(
//               labelText: 'Number of Cases',
//             ),
//             keyboardType: TextInputType.number,
//           ),

//           const SizedBox(height: 16),

//           // Date Picker
//           ElevatedButton(
//             onPressed: () => _selectDate(context),
//             child: Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
//           ),

//           const SizedBox(height: 16),
//           // Submit Button
//           ElevatedButton(
//             onPressed: _submitData, // Use the updated _submitData function
//             child: Text("Submit".toUpperCase()),
//           ),
//       const SizedBox(height: 16),
//           //Delete Button, only for testing dont forget to remove it
//           ElevatedButton(
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: const Text('Confirm Delete'),
//                   content: const Text(
//                       'Are you sure you want to delete all case data? This action cannot be undone.'),
//                   actions: [
//                     TextButton(
//                       onPressed: () => Navigator.of(context).pop(), // Cancel
//                       child: const Text('Cancel'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop(); // Close dialog
//                         _deleteAllCases(); // Delete data
//                       },
//                       child: const Text('Delete'),
//                     ),
//                   ],
//                 ),
//               );
//             },
//             style: ElevatedButton.styleFrom(
//              backgroundColor: Colors.red,
//             foregroundColor: Colors.white, // Optional: Set text color to white for contrast
//           ),
//           child: const Text('Delete All Cases'),
//         ),

//         ],
//       ),
//     );
//   }
// }

