import 'package:flutter/material.dart';
import 'package:learn_flutter/data/questions.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.chosenAnswers});

  final List<String> chosenAnswers;

  List<Map<String, Object>> getResultSummary() {
    final List<Map<String, Object>> summary = [];

    for (int i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[0].question,
        'correct_answer': questions[0].answers[0],
        'user_answer': chosenAnswers[i]
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    return (SizedBox(
        width: double.infinity,
        child: Container(
            margin: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    "Kamu telah menjawab X soal dengan benar dari Y soal"),
                const SizedBox(
                  height: 30,
                ),
                const Text("Daftar soal & jawaban ....."),
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
