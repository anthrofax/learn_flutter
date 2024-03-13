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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            activeQuestion.question,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 30.0,
          ),
          QuestionsAnswers(answerText: activeQuestion.answers[0], onTap: () {}),
          const SizedBox(height: 15.0),
          QuestionsAnswers(answerText: activeQuestion.answers[1], onTap: () {}),
          const SizedBox(height: 15.0),
          QuestionsAnswers(answerText: activeQuestion.answers[2], onTap: () {}),
          const SizedBox(height: 15.0),
          QuestionsAnswers(answerText: activeQuestion.answers[3], onTap: () {}),
        ],
      ),
    ));
  }
}
