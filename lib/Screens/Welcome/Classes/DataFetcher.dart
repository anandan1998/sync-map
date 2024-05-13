// data_fetcher.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Ensure you have this for date formatting
import 'package:flutter_auth/model.dart'; // data model

class DataFetcher {
  Future<List<Model>> fetchRegionCaseDataLast30Days(DateTime endDate) async {
    final startDate = endDate.subtract(const Duration(days: 30));
    final regionCaseDataList = <Model>[];  // List to store Model objects

    final regionsSnapshot = await FirebaseFirestore.instance
        .collection('regions')
        .get();

    for (var regionDoc in regionsSnapshot.docs) {
      final regionId = regionDoc.id;
      final regionName = regionDoc.get('shapeName') as String?; // Get region name if available

      try {
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
          if (numCases is int) {
            totalCases += numCases;
          } else {
            print('Invalid numCases format for region $regionId on ${caseDoc.id}: $numCases');
          }
        }

        regionCaseDataList.add(
          Model(regionName ?? regionId, totalCases.toDouble()),
        ); // Create a Model instance and add it to the list
      } catch (e) {
        print("The region $regionId does not have a case collection");
      }
    }

    //print('Fetched Region Case Data: $regionCaseDataList');
    return regionCaseDataList;
  }
}
