import 'package:favorite_places/screens/auth_screen.dart';
import 'package:favorite_places/screens/chat_screen.dart';
import 'package:favorite_places/screens/splash_screen.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat App',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 63, 17, 177)),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }

          if (snapshot.hasData) {
            // Jika ada data (pengguna telah login), tampilkan ChatScreen
            return const ChatScreen();
          }

          // Jika tidak ada data (pengguna belum login), tampilkan AuthScreen
          return const AuthScreen();
        },
      ),
    );
  }
}
