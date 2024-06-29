import 'package:flutter/material.dart';
import 'package:pemrograman_mobile_fp/data/questions.dart';
import 'package:pemrograman_mobile_fp/question_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
    required this.onStartScreen,
  });

  final List<String> chosenAnswers;
  final VoidCallback onRestart;
  final VoidCallback onStartScreen;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    final allQuestions = questions + customQuestions;

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'questionIndex': i,
        'question': allQuestions[i].text,
        'correctAnswer': allQuestions[i].answers[0],
        'userAnswer': chosenAnswers[i],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length + customQuestions.length;
    final numCorrectAnswers = summaryData.where((data) {
      return data['correctAnswer'] == data['userAnswer'];
    }).length;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      body: SizedBox(
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You answered $numCorrectAnswers out of $numTotalQuestions questions correctly!',
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 165, 0),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PressStart2P',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              QuestionSummary(summaryData),
              const SizedBox(height: 30),
              TextButton.icon(
                onPressed: onRestart,
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 28, 28, 28),
                  backgroundColor: const Color.fromARGB(255, 255, 165, 0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                icon: const Icon(Icons.refresh,
                    color: Color.fromARGB(255, 28, 28, 28)),
                label: const Text(
                  'Restart Quiz!',
                  style: TextStyle(
                    fontFamily: 'PressStart2P',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: onStartScreen,
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 28, 28, 28),
                  backgroundColor: const Color.fromARGB(255, 255, 165, 0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                icon: const Icon(Icons.home,
                    color: Color.fromARGB(255, 28, 28, 28)),
                label: const Text(
                  'Go to Start Screen!',
                  style: TextStyle(
                    fontFamily: 'PressStart2P',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
