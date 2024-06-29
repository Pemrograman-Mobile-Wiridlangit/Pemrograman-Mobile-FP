import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddQuizScreen extends StatelessWidget {
  final void Function() onSave;
  final void Function() onBack;

  AddQuizScreen(this.onSave, this.onBack, {super.key});

  final TextEditingController _questionController = TextEditingController();
  final List<TextEditingController> _answerControllers =
      List.generate(4, (index) => TextEditingController());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _addQuiz() {
    final String question = _questionController.text;
    final List<String> answers =
        _answerControllers.map((controller) => controller.text).toList();

    if (question.isNotEmpty && answers.every((answer) => answer.isNotEmpty)) {
      _firestore.collection('customQuizzes').add({
        'question': question,
        'answers': answers,
      });

      onSave();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Quiz',
          style: TextStyle(
            fontFamily: 'PressStart2P',
            color: Color.fromARGB(255, 255, 165, 0),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 28, 28, 28),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 165, 0)),
          onPressed: onBack,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _questionController,
              style: const TextStyle(
                fontFamily: 'OCRAEXT',
                color: Color.fromARGB(255, 255, 165, 0),
              ),
              decoration: const InputDecoration(
                labelText: 'Question',
                labelStyle: TextStyle(
                  fontFamily: 'OCRAEXT',
                  color: Color.fromARGB(255, 255, 165, 0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 255, 165, 0)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 255, 165, 0)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ...List.generate(4, (index) {
              return TextField(
                controller: _answerControllers[index],
                style: const TextStyle(
                  fontFamily: 'OCRAEXT',
                  color: Color.fromARGB(255, 255, 165, 0),
                ),
                decoration: InputDecoration(
                  labelText: 'Answer ${index + 1}',
                  labelStyle: const TextStyle(
                    fontFamily: 'OCRAEXT',
                    color: Color.fromARGB(255, 255, 165, 0),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 255, 165, 0)),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 255, 165, 0)),
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addQuiz,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                backgroundColor: const Color.fromARGB(255, 255, 165, 0),
                foregroundColor: const Color.fromARGB(255, 28, 28, 28),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: const Text(
                'Add Quiz',
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
