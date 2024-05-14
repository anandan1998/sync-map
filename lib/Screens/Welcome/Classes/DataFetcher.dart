// data_fetcher.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_auth/model.dart'; // data model

class DataFetcher {
  Future<List<Model>> fetchRegionCaseDataLast30Days(DateTime endDate) async {
  final startDate = endDate.subtract(const Duration(days: 30));
  final regionCaseDataList = <Model>[];

  try {
    // Fetch all case documents for all regions within the date range
    final casesSnapshot = await FirebaseFirestore.instance
        .collectionGroup('cases') // Query across all 'cases' subcollections
        .where('date', isGreaterThanOrEqualTo: startDate)
        .where('date', isLessThanOrEqualTo: endDate)
        .get();

    // Aggregate case data by region
    final regionCaseData = <String, int>{};
    for (var caseDoc in casesSnapshot.docs) {
      final regionId = caseDoc.reference.parent.parent!.id; // Get region ID from case document
      final numCases = caseDoc.get('numCases');
      if (numCases is int) {
        regionCaseData[regionId] = (regionCaseData[regionId] ?? 0) + numCases;
      } else {
        // ... (error handling for invalid numCases)
      }
    }

    // Get region names
    final regionsSnapshot = await FirebaseFirestore.instance.collection('regions').get();
    final regionNames = {for (var doc in regionsSnapshot.docs) doc.id: doc.get('shapeName') as String?};

    // Create Model objects
    for (var entry in regionCaseData.entries) {
      regionCaseDataList.add(
        Model(regionNames[entry.key] ?? entry.key, entry.value.toDouble()),
      );
    }
  } catch (e) {
    print("Error fetching case data: $e");
    // ... (error handling)
  }

  return regionCaseDataList;
}
}
