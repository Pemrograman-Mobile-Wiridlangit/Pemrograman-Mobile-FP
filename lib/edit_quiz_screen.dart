import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditQuizScreen extends StatefulWidget {
  final String quizId;
  final String initialQuestion;
  final List<String> initialAnswers;
  final void Function() onSave;

  const EditQuizScreen({
    required this.quizId,
    required this.initialQuestion,
    required this.initialAnswers,
    required this.onSave,
    super.key,
  });

  @override
  _EditQuizScreenState createState() => _EditQuizScreenState();
}

class _EditQuizScreenState extends State<EditQuizScreen> {
  late TextEditingController _questionController;
  late List<TextEditingController> _answerControllers;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(text: widget.initialQuestion);
    _answerControllers = List.generate(4, (index) {
      return TextEditingController(
        text: index < widget.initialAnswers.length
            ? widget.initialAnswers[index]
            : '',
      );
    });
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updateQuiz() async {
    final String question = _questionController.text;
    final List<String> answers =
        _answerControllers.map((controller) => controller.text).toList();

    if (question.isNotEmpty && answers.every((answer) => answer.isNotEmpty)) {
      await _firestore.collection('customQuizzes').doc(widget.quizId).update({
        'question': question,
        'answers': answers,
      });

      widget.onSave();

      setState(() {
        _questionController.text = question;
        for (var i = 0; i < _answerControllers.length; i++) {
          _answerControllers[i].text = answers[i];
        }
      });
    }
  }

  void _navigateBack(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Quiz',
          style: TextStyle(
            fontFamily: 'PressStart2P',
            color: Color.fromARGB(255, 255, 165, 0),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 28, 28, 28),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 165, 0)),
          onPressed: () => _navigateBack(context),
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
              onPressed: _updateQuiz,
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
                'Update Quiz',
                style: TextStyle(
                  fontFamily: 'PressStart2P',
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _navigateBack(context),
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
                'Finish',
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
