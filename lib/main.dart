import 'package:flutter/material.dart';
import 'package:learn_flutter/widgets/expenses.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: const Color.fromARGB(255, 244, 108, 203)),
      debugShowCheckedModeBanner: false,
      home: const Expenses(),
    ),
  );
}
