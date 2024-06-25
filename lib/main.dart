import 'package:flutter/material.dart';
import 'package:learn_flutter/widgets/expenses.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kColorScheme.onPrimaryContainer,
              foregroundColor: kColorScheme.primaryContainer)),
      debugShowCheckedModeBanner: false,
      home: const Expenses(),
    ),
  );
}
