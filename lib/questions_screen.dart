import 'package:flutter/material.dart';
import 'package:learn_flutter/questions_answers.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    return (SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Question 1',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 30.0,
          ),
          QuestionsAnswers(answerText: "Answer 1", onTap: () {}),
          QuestionsAnswers(answerText: "Answer 2", onTap: () {}),
          QuestionsAnswers(answerText: "Answer 3", onTap: () {}),
        ],
      ),
    ));
  }
}
