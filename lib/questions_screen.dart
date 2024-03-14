import 'package:flutter/material.dart';
import 'package:learn_flutter/models/quiz_question.dart';
import 'package:learn_flutter/questions_answers.dart';
import 'package:learn_flutter/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.onChooseAnswer});

  final Function(String answer) onChooseAnswer;

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int activeQuestionIndex = 0;

  void answerQuestion(String answer) {
    widget.onChooseAnswer(answer);

    setState(() {
      activeQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    QuizQuestion activeQuestion = questions[activeQuestionIndex];
    final List<String> shuffledList = List.of(activeQuestion.answers);
    shuffledList.shuffle();

    return (SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              activeQuestion.question,
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15.0,
            ),
            ...shuffledList.map((answer) {
              return QuestionsAnswers(answerText: answer, onTap: () {
                answerQuestion(answer);
              });
            })
          ],
        ),
      ),
    ));
  }
}
