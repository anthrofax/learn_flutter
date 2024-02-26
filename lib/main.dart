import 'package:flutter/material.dart';
import 'package:learn_flutter/start_screen.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.purple[800],
      body: Center(
        child: StartScreen()
      ),
    ),
  ));
}
