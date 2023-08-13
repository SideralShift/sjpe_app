import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:app/models/user.dart';
import 'dart:convert';

import '../utils/env_constants.dart';

class AuthResult {
  final UserCredential? userCredential;
  final String? error;

  AuthResult({this.userCredential, this.error});
}

class AuthService {
  static Future<AuthResult?> logginUser(UserModel user) async {
    AuthResult result;

    try {
      final email = user.person?.email ?? '';
      final password = user.password ?? '';
      if (email.isNotEmpty) {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        final userResult = credential.user;

        final response = await http.get(
          Uri.parse(
              '${dotenv.env[EnvConstants.sjpeApiServerAndroid]}/auth/token/${userResult?.uid}'),
        );
        final responsejson = jsonDecode(response.body);
        final userCredential = await FirebaseAuth.instance
            .signInWithCustomToken(responsejson['token']);
        result = AuthResult(userCredential: userCredential, error: null);
      } else {
        result = AuthResult(userCredential: null, error: 'email-empty');
      }
    } on FirebaseAuthException catch (e) {
      result = AuthResult(userCredential: null, error: e.code);
    }
    return result;
  }
}
