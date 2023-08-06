import 'package:app/utils/app_colors.dart';
import 'package:app/widgets/app.dart';
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
    theme: ThemeData(
      scaffoldBackgroundColor: AppColors.mainBackgroundColor 
    ),
    home: App(),
  ));
}
