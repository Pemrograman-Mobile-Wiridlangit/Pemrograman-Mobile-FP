import 'package:pemrograman_mobile_fp/question_identifier.dart';
import 'package:flutter/material.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(this.itemData, {super.key});

  final Map<String, Object> itemData;

  @override
  Widget build(BuildContext context) {
    final isCorrectAnswer = itemData['userAnswer'] == itemData['correctAnswer'];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionIdentifier(
          isCorrectAnswer: isCorrectAnswer,
          questionIndex: itemData['questionIndex'] as int,
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemData['question'] as String,
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 165, 0),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OCRAEXT',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                itemData['userAnswer'] as String,
                style: const TextStyle(
                  color: Color.fromARGB(255, 56, 204, 107),
                  fontFamily: 'OCRAEXT',
                ),
              ),
              Text(
                itemData['correctAnswer'] as String,
                style: const TextStyle(
                  color: Color.fromARGB(255, 223, 158, 234),
                  fontFamily: 'OCRAEXT',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
