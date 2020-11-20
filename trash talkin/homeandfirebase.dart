// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   bool _initialized = false;
//   bool _error = false;
//   final databaseReference = FirebaseDatabase.instance.reference();
//   int firedata = 1;

//   void initializeFlutterFire() async {
//     try {
//       // Wait for Firebase to initialize and set `_initialized` state to true
//       await Firebase.initializeApp();
//       setState(() {
//         _initialized = true;
//       });
//     } catch (e) {
//       // Set `_error` state to true if Firebase initialization fails
//       setState(() {
//         _error = true;
//       });
//     }
//   }

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   void initState() {
//     initializeFlutterFire();
//     super.initState();
//     readData();
//   }

//   void readData() {
//     databaseReference
//         .once()
//         .then((DataSnapshot snapshot) => print("Data : ${snapshot.value}"));
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_error) {
//       return Scaffold(
//         body: Center(
//           child: Text("Error"),
//         ),
//       );
//     }

//     if (!_initialized) {
//       return Scaffold(
//         body: Center(
//           child: Text("Loading...."),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//             Text("Data From Firebase: $firedata")
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
