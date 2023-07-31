import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:app/login.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: LoginScreen(),
  ));
}
