import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  @override
  State<StartScreen> createState() {
    return _StartScreenState();
  }
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/quiz-logo.png',
          width: 350,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Learn Flutter in the fun way',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w100),
        ),
        const SizedBox(
          height: 20,
        ),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            shape: const ContinuousRectangleBorder()
          ),
          child: const Text('Start Quiz'),
        )
      ],
    );
  }
}
