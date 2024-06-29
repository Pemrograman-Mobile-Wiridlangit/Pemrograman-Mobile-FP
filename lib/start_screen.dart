import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, this.makeQuiz, {super.key});

  final void Function() startQuiz;
  final void Function() makeQuiz;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 28, 28, 28),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/quiz-logo.png',
              width: 300,
              color: const Color.fromARGB(150, 255, 255, 255),
            ),
            const SizedBox(height: 80),
            const Text(
              'Quiz Retro!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 255, 165, 0),
                fontSize: 24,
                fontFamily: 'PressStart2P',
              ),
            ),
            const SizedBox(height: 30),
            OutlinedButton.icon(
              onPressed: startQuiz,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                backgroundColor: const Color.fromARGB(255, 255, 165, 0),
                foregroundColor: const Color.fromARGB(255, 28, 28, 28),
              ),
              icon: const Icon(Icons.arrow_right_alt),
              label: const Text(
                'Start Quiz!',
                style: TextStyle(
                  fontFamily: 'PressStart2P',
                ),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: makeQuiz,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                backgroundColor: const Color.fromARGB(255, 255, 165, 0),
                foregroundColor: const Color.fromARGB(255, 28, 28, 28),
              ),
              icon: const Icon(Icons.create),
              label: const Text(
                'Make Your Own Quiz',
                style: TextStyle(
                  fontFamily: 'PressStart2P',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
