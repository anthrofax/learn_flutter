import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/quiz-logo.png',
          width: 350,
          // opacity: Animation(),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Learn Flutter in the fun way',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w100),
        ),
        const SizedBox(
          height: 20,
        ),
        OutlinedButton.icon(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              shape: const ContinuousRectangleBorder(), 
              side: const BorderSide(color: Colors.white)
              ),
          icon: const Icon(Icons.arrow_right_alt),
          label: const Text('Start Quiz'),
        )
      ],
    );
  }
}
