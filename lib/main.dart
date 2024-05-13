import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:flutter_auth/data_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_auth/screens/welcome/welcome_screen.dart';
import "package:flutter_auth/Screens/Welcome/Classes/DataFetcher.dart";
import 'package:flutter_auth/model.dart'; // data model


void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Ensure Flutter bindings are initialized

// Initialize Firebase
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
).then((_) async {
  final dataFetcher = DataFetcher();
  try {
    final regionCaseDataList = await dataFetcher.fetchRegionCaseDataLast30Days(DateTime.now());

    // Print the region-case pairs (using a for loop)
    for (var model in regionCaseDataList) {
      print('${model.name} - ${model.density.toInt()} cases'); 
    }

    runApp(const MyApp());  // Pass the data to MyApp
  } catch (error) {
    print('Error fetching data: $error');
  }
}).catchError((error) {
  print("Firebase initialization error: $error");
});
}
//  runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              foregroundColor: Colors.white,
              backgroundColor: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      home: const WelcomeScreen(),
    );
  }
}

  //CAUTION: Uncommenting the following code will import the regions from THE LITERAL FIRESTORE DB
  //insert into void main() 

  // // Import Region Data (Only Once)
  // final SharedPreferences prefs = await SharedPreferences.getInstance();
  // if (!prefs.containsKey('regionsImported')) {  // Check if imported before
  //   await importRegions();                      // Import regions from data_repository.dart
  //   await prefs.setBool('regionsImported', true); // Mark as imported
  // }