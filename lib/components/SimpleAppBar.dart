import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget SimpleAppBar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(50),
    child: Container(
        height: 150,
        color: Colors.black87,
        child: Center(
          child: Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                // shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Center(
                child: Text(
              'Periodic Table',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            )),
          ),
        )),
  );
}
