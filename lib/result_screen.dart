import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

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
