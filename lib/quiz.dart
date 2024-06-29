import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pemrograman_mobile_fp/models/quiz_question.dart';
import 'start_screen.dart';
import 'question_screen.dart';
import 'results_screen.dart';
import 'custom_quiz_screen.dart';
import 'add_quiz_screen.dart';
import 'data/questions.dart';
import 'edit_quiz_screen.dart';

Future<void> fetchCustomQuestions() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final snapshot = await firestore.collection('customQuizzes').get();

  customQuestions.clear();
  for (var doc in snapshot.docs) {
    customQuestions.add(
      QuizQuestion(
        doc['question'],
        List<String>.from(doc['answers']),
      ),
    );
  }

  // Debug output to verify the fetched custom questions
  if (kDebugMode) {
    print('Custom Questions Fetched: ${customQuestions.length}');
  }
  for (var question in customQuestions) {
    if (kDebugMode) {
      print('Question: ${question.text}, Answers: ${question.answers}');
    }
  }
}

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';

  @override
  void initState() {
    super.initState();
    fetchCustomQuestions().then((_) {
      setState(() {});
    });
  }

  Future<void> refreshQuizzes() async {
    await fetchCustomQuestions();
    setState(() {});
  }

  void switchScreen(String screenName) {
    setState(() {
      activeScreen = screenName;
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length + customQuestions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers.clear();
      activeScreen = 'question-screen';
    });
  }

  void goToStartScreen() {
    refreshQuizzes().then((_) {
      setState(() {
        selectedAnswers.clear();
        activeScreen = 'start-screen';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartScreen(
      () => switchScreen('question-screen'),
      () => switchScreen('custom-quiz-screen'),
    );

    if (activeScreen == 'question-screen') {
      screenWidget = QuestionScreen(onSelectAnswer: chooseAnswer);
    } else if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswers,
        onRestart: restartQuiz,
        onStartScreen: goToStartScreen,
      );
    } else if (activeScreen == 'custom-quiz-screen') {
      screenWidget = CustomQuizScreen(
        () => switchScreen('add-quiz-screen'),
        () => switchScreen('start-screen'),
        refreshQuizzes: refreshQuizzes,
      );
    } else if (activeScreen == 'add-quiz-screen') {
      screenWidget = AddQuizScreen(
        () => switchScreen('custom-quiz-screen'),
        () => switchScreen('custom-quiz-screen'),
      );
    } else if (activeScreen == 'edit-quiz-screen') {
      screenWidget = EditQuizScreen(
        quizId: 'quizId',
        initialQuestion: 'question',
        initialAnswers: const ['answer'],
        onSave: () => switchScreen('custom-quiz-screen'),
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
