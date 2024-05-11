// import 'package:flutter/material.dart';

// import '../../components/background.dart';
// import '../../responsive.dart';
// import 'components/login_signup_btn.dart';
// import 'components/welcome_image.dart';

// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Background(
//       child: SingleChildScrollView(
//         child: SafeArea(
//           child: Responsive(
//             desktop: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Expanded(
//                   child: WelcomeImage(),
//                 ),
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         width: 450,
//                         child: LoginAndSignupBtn(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             mobile: MobileWelcomeScreen(),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MobileWelcomeScreen extends StatelessWidget {
//   const MobileWelcomeScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         WelcomeImage(),
//         Row(
//           children: [
//             Spacer(),
//             Expanded(
//               flex: 8,
//               child: LoginAndSignupBtn(),
//             ),
//             Spacer(),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import '../Login/login_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
  late MapShapeSource _shapeSource;
  late List<Model> _data;
  late MapZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _data = <Model>[
      Model('Tulo', 280),
      Model('Endiguagn', 190),
      Model('Limu', 37),
      Model('Geta', 310)
    ];
    _shapeSource = MapShapeSource.asset(
      'ethiopia.json',
      shapeDataField: 'shapeName',
      dataCount: _data.length,
      primaryValueMapper: (int index) => _data[index].name,
      shapeColorValueMapper: (int index) => _data[index].density,
      shapeColorMappers: [
        MapColorMapper(from: 0, to: 100, color: Colors.red, text: '< 100/km²'),
        MapColorMapper(from: 101, to: 200, color: Colors.green, text: '100 - 200/km²'),
        MapColorMapper(from: 201, to: 300, color: Colors.blue, text: '200 - 300/km²'),
        MapColorMapper(from: 301, to: 400, color: Colors.orange, text: '300 - 400/km²'),
      ],
    );
    _zoomPanBehavior = MapZoomPanBehavior(enableDoubleTapZooming: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Out break tracker"),
        actions: <Widget>[
          SizedBox(
            width: 100, // Set the width of the button
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, // Text color
                backgroundColor: Theme.of(context).primaryColor, // Button color
                padding: EdgeInsets.symmetric(horizontal: 8), // Optional: adjust padding for better fitting
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
              legend: MapLegend(MapElement.shape),
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
