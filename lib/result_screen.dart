import 'package:flutter/material.dart';
import 'package:learn_flutter/data/questions.dart';
import 'package:learn_flutter/result_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.chosenAnswers});

  final List<String> chosenAnswers;

  List<Map<String, Object>> getResultSummary() {
    final List<Map<String, Object>> summary = [];

    for (int i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[0].question,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i]
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> summary = getResultSummary();
    final int totalQuestions = questions.length;
    final int amountOfCorrectAnswers = summary.where((quizData) {
      return quizData['correct_answer'] == quizData['user_answer'];
    }).length;

    return (SizedBox(
        width: double.infinity,
        child: Container(
            margin: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    "Kamu telah menjawab $amountOfCorrectAnswers soal dengan benar dari $totalQuestions soal"),
                const SizedBox(
                  height: 30,
                ),
                ResultSummary(summary),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Restart Quiz",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ))));
  }
}
