import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataFetcher {
  Future<Map<String, int>> fetchRegionCaseDataLast30Days(DateTime endDate) async {
    // Calculate the start date (30 days ago)
    final startDate = endDate.subtract(const Duration(days: 30));


    // Fetch region data
    final regionsSnapshot = await FirebaseFirestore.instance.collection('regions').get();
    
    // Fetch cases for each region
    Map<String, int> regionCaseData = {};
    for (var regionDoc in regionsSnapshot.docs) {
      final regionId = regionDoc.id;
      final casesQuery = FirebaseFirestore.instance
          .collection('regions')
          .doc(regionId)
          .collection('cases')
          .where('date', isGreaterThanOrEqualTo: startDate)
          .where('date', isLessThanOrEqualTo: endDate);

      final casesSnapshot = await casesQuery.get();

      int totalCases = 0;
      for (var caseDoc in casesSnapshot.docs) {
        final numCases = caseDoc.get('numCases');
        if (numCases is int) { // Check if numCases is already an int
          totalCases += numCases;
        } else if (numCases is double) {
          totalCases += numCases.toInt(); // Convert double to int
        }
        // Can handle the cases that are not int or double here, throwing an error right now.
      }
      regionCaseData[regionId] = totalCases;
    }

    return regionCaseData;
  }
}
