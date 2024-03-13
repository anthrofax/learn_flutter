import 'package:flutter/material.dart';
import 'package:learn_flutter/models/quiz_question.dart';
import 'package:learn_flutter/questions_answers.dart';
import 'package:learn_flutter/data/questions.dart';

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
    QuizQuestion activeQuestion = questions[0];

    return (SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              activeQuestion.question,
              style: const TextStyle(color: Colors.white, ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 25.0,
            ),
            ...activeQuestion.answers.map((answer) {
              return QuestionsAnswers(answerText: answer, onTap: () {});
            })
          ],
        ),
      ),
    ));
  }
}
