import 'package:flutter/material.dart';
import 'package:learn_flutter/questions_screen.dart';
import 'package:learn_flutter/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  Widget activeScreen = const StartScreen();

  void startQuiz() {
    activeScreen = const QuestionsScreen();
  }

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.purple[800],
        body: Center(child: activeScreen),
      ),
    ));
  }
}
