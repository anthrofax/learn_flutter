import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Opacity(
        //   opacity: 0.5,
        //   child: Image.asset(
        //     'assets/images/quiz-logo.png',
        //     width: 350,
        //   ),
        // ),
        Image.asset(
          'assets/images/quiz-logo.png',
          width: 350,
          color: const Color.fromARGB(150, 255, 255, 255),
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
              side: const BorderSide(color: Colors.white)),
          icon: const Icon(Icons.arrow_right_alt),
          label: const Text('Start Quiz'),
        )
      ],
    );
  }
}
