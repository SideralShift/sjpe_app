import 'package:app/utils/app_colors.dart';
import 'package:app/widgets/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await dotenv.load(fileName: "lib/assets/dev.env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'sjpe-48ba5',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('es_ES', null);
  runApp(MaterialApp(
    theme: ThemeData(scaffoldBackgroundColor: AppStyles.mainBackgroundColor),
    home: App(),
  ));
}
