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
  // Solution 1 - Conditional Rendering
  // Widget? activeScreen;

  // @override
  // void initState() {
  //   activeScreen = StartScreen(startQuiz);
  //   super.initState();
  // }

  // void startQuiz() {
  //   setState(() {
  //     activeScreen = const QuestionsScreen();
  //   });
  // }

// Solution 2 - Conditional Rendering
  var activeScreen = 'start-screen';
  final List<String> chosenAnswers = [];

  void startQuiz() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    chosenAnswers.add(answer);
  }

  @override
  Widget build(BuildContext context) {
    Widget widgetScreen = StartScreen(startQuiz);

    // Using ternary to determine the Widget Screen
    // Widget widgetScreen = (activeScreen == 'start-screen')
    //     ? StartScreen(startQuiz)
    //     : const QuestionsScreen();

    if (activeScreen == 'questions-screen') {
      widgetScreen =  QuestionsScreen(onChooseAnswer: chooseAnswer);
    }

    return (MaterialApp(
      home: Scaffold(
          body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 78, 13, 151),
          Color.fromARGB(255, 107, 15, 168)
        ])),
        child: widgetScreen,
      )),
    ));
  }
}
