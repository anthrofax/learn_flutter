import 'package:flutter/material.dart';

class QuestionsAnswers extends StatelessWidget {
  const QuestionsAnswers(this.answerText, this.onTap, {super.key});

  final String answerText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return (ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 80, 0, 94),
          foregroundColor: Colors.white),
      onPressed: onTap,
      child: Text(answerText),
    ));
  }
}
