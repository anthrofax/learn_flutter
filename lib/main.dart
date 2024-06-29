import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:learn_flutter/widgets/expenses.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125));

void main() {
  // Dibuat untuk memastikan penerapan orientasi dan jalannya aplikasi bekerja sesuai dengan keinginan
  // WidgetsFlutterBinding.ensureInitialized();

// Mengatur orientasi yang tersedia untuk aplikasi
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((fn) {
    runApp(
      MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: kDarkColorScheme,
          cardTheme: const CardTheme().copyWith(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: kDarkColorScheme.secondaryContainer),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkColorScheme.primaryContainer)),
        ),
        theme: ThemeData().copyWith(
            colorScheme: kColorScheme,
            appBarTheme: const AppBarTheme().copyWith(
                backgroundColor: kColorScheme.onPrimaryContainer,
                foregroundColor: kColorScheme.primaryContainer),
            cardTheme: const CardTheme().copyWith(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: kColorScheme.secondaryContainer),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kColorScheme.primaryContainer)),
            textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: kColorScheme.onSecondaryContainer,
                    fontSize: 14))),
        // themeMode: ThemeMode.system, //Default
        debugShowCheckedModeBanner: false,
        home: const Expenses(),
      ),
    );
  // });
}
