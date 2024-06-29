import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pemrograman_mobile_fp/quiz.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Quiz());
}
