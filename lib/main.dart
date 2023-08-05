import 'package:app/widgets/announcements_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:app/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  await initializeDateFormatting('es_ES', null);

  runApp(MaterialApp(
    home: AnnouncementsScreen(),
  ));
}
