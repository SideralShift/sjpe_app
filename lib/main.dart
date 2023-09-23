import 'package:app/utils/app_colors.dart';
import 'package:app/widgets/app.dart';
import 'package:app/widgets/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  final prefs = await SharedPreferences.getInstance();
  String? idToken = prefs.getString('idToken');

  runApp(MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: AppStyles.mainBackgroundColor),
      initialRoute: idToken != null ? '/app' : '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/app': (context) => App(),
        // Add more routes as needed
      }));
}
