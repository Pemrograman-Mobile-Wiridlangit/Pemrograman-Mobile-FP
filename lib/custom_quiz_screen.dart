import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_quiz_screen.dart';

class CustomQuizScreen extends StatelessWidget {
  final void Function() onAddQuiz;
  final void Function() onBack;
  final Future<void> Function() refreshQuizzes;

  CustomQuizScreen(this.onAddQuiz, this.onBack,
      {required this.refreshQuizzes, super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Custom Quizzes',
          style: TextStyle(
            fontFamily: 'PressStart2P',
            color: Color.fromARGB(255, 255, 165, 0),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 28, 28, 28),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 165, 0)),
          onPressed: () async {
            await refreshQuizzes();
            onBack();
          },
        ),
      ),
      body: StreamBuilder(
        stream: _firestore.collection('customQuizzes').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 255, 165, 0)),
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No custom quizzes found.',
                style: TextStyle(
                  fontFamily: 'PressStart2P',
                  color: Color.fromARGB(255, 255, 165, 0),
                ),
              ),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                title: Text(
                  doc['question'],
                  style: const TextStyle(
                    fontFamily: 'PressStart2P',
                    color: Color.fromARGB(255, 255, 165, 0),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit,
                          color: Color.fromARGB(255, 255, 165, 0)),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditQuizScreen(
                              quizId: doc.id,
                              initialQuestion: doc['question'],
                              initialAnswers: List<String>.from(doc['answers']),
                              onSave: () async {
                                await refreshQuizzes();
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete,
                          color: Color.fromARGB(255, 255, 165, 0)),
                      onPressed: () async {
                        await _firestore
                            .collection('customQuizzes')
                            .doc(doc.id)
                            .delete();
                        await refreshQuizzes();
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddQuiz,
        backgroundColor: const Color.fromARGB(255, 255, 165, 0),
        child: const Icon(Icons.add, color: Color.fromARGB(255, 28, 28, 28)),
      ),
    );
  }
}
