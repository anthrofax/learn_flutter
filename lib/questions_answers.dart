import 'package:flutter/material.dart';

class QuestionsAnswers extends StatelessWidget {
  const QuestionsAnswers(
      {super.key, required this.answerText, required this.onTap});

  final String answerText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return (Container(
        margin: const EdgeInsets.only(top: 15.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 174, 0, 255),
            foregroundColor: const Color.fromARGB(255, 255, 255, 255),
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
          ),
          onPressed: onTap,
          child: Text(answerText, textAlign: TextAlign.center,),
        )));
  }
}
