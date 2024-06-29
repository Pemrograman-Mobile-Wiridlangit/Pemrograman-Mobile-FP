import 'package:flutter/material.dart';
import 'package:pemrograman_mobile_fp/answer_button.dart';
import 'package:pemrograman_mobile_fp/data/questions.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalQuestions = allQuestions;
    if (currentQuestionIndex >= totalQuestions.length) {
      return const Center(
        child: Text(
          'No more questions!',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 165, 0),
            fontSize: 18,
            fontFamily: 'PressStart2P',
          ),
        ),
      );
    }
    final currentQuestion = totalQuestions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      body: SizedBox(
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Center(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    currentQuestion.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 165, 0),
                      fontSize: 18,
                      fontFamily: 'PressStart2P',
                    ),
                  ),
                  const SizedBox(height: 30),
                  ...currentQuestion.getShuffledAnswers().map((answer) {
                    return AnswerButton(
                      answerText: answer,
                      onTap: () {
                        answerQuestion(answer);
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
