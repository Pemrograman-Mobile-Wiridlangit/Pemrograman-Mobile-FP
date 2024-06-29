import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.answerText,
    required this.onTap,
  });

  final String answerText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            backgroundColor: const Color.fromARGB(255, 255, 165, 0),
            foregroundColor: const Color.fromARGB(255, 28, 28, 28),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          child: Text(
            answerText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'PressStart2P',
            ),
          ),
        ),
      ),
    );
  }
}
