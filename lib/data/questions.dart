import 'package:pemrograman_mobile_fp/models/quiz_question.dart';

const List<QuizQuestion> questions = [
  QuizQuestion(
    'Siapakah tokoh proklamator kemerdekaan Indonesia?',
    [
      'Soekarno dan Hatta',
      'Soekarno dan Suharto',
      'Hatta dan Suharto',
      'Soekarno dan Sjahrir',
    ],
  ),
  QuizQuestion(
    'Pada tanggal berapakah Indonesia memproklamasikan kemerdekaannya?',
    [
      '17 Agustus 1945',
      '17 Agustus 1946',
      '17 Agustus 1947',
      '17 Agustus 1948',
    ],
  ),
  QuizQuestion(
    'Perjanjian yang mengakhiri konflik antara Indonesia dan Belanda pada tahun 1949 adalah...',
    [
      'Perjanjian Renville',
      'Perjanjian Linggarjati',
      'Perjanjian Roem-Royen',
      'Konferensi Meja Bundar',
    ],
  ),
  QuizQuestion(
    'Kerajaan Hindu tertua di Indonesia adalah...',
    [
      'Kerajaan Majapahit',
      'Kerajaan Sriwijaya',
      'Kerajaan Kutai',
      'Kerajaan Singasari',
    ],
  ),
  QuizQuestion(
    'Siapakah pahlawan nasional yang dikenal sebagai "Panglima Besar" dan memimpin Tentara Nasional Indonesia dalam Perang Kemerdekaan?',
    [
      'Jenderal Sudirman',
      'Bung Tomo',
      'Pattimura',
      'Diponegoro',
    ],
  ),
];

List<QuizQuestion> customQuestions = [];

List<QuizQuestion> get allQuestions => [...questions, ...customQuestions];
