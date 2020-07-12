import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:PeriodicTable/screens/loadScreen.dart';


void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      title: 'Periodic Table',
      home: LoadScreen(),
    );
  }
}
