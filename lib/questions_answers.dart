import 'package:flutter/material.dart';

class QuestionsAnswers extends StatelessWidget {
  const QuestionsAnswers(
      {super.key, required this.answerText, required this.onTap});

  final String answerText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return (ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 193, 0, 227),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
        
      ),
      onPressed: onTap,
      child: Text(answerText),
    ));
  }
}
