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

  void startQuiz() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget widgetScreen = StartScreen(startQuiz);

    // Using ternary to determine the Widget Screen
    // Widget widgetScreen = (activeScreen == 'start-screen')
    //     ? StartScreen(startQuiz)
    //     : const QuestionsScreen();

    if (activeScreen == 'questions-screen') widgetScreen = const QuestionsScreen();

    return (MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.purple[800],
        body: Center(
          // child: activeScreen
          child: widgetScreen,
        ),
      ),
    ));
  }
}
