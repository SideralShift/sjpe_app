import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:app/models/user.dart';
import 'dart:convert';

import '../utils/env_constants.dart';

class AuthResult {
  final UserCredential? userCredential;
  String? error;

  AuthResult({this.userCredential, this.error});
}

class AuthService {
  static Future<String> _getCustomToken(String uid) async {
    http.Response response = await http.get(
      Uri.parse(
          '${dotenv.env[EnvConstants.sjpeApiServerAndroid]}/auth/token/$uid'),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw HttpExceptionWithStatus(response.statusCode, response.body);
    }

    return jsonDecode(response.body)['token'];
  }

  static Future<AuthResult> logginUser(UserModel user) async {
    try {
      final email = user.person?.email ?? '';
      final password = user.password ?? '';

      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final userResult = credential.user;

      if (userResult == null) {
        return AuthResult(userCredential: null, error: 'user-not-found');
      }

      String customToken = await _getCustomToken(userResult.uid);

      final userCredential =
          await FirebaseAuth.instance.signInWithCustomToken(customToken);

      return AuthResult(userCredential: userCredential, error: null);
    } on FirebaseAuthException catch (e) {
      return AuthResult(userCredential: null, error: e.code);
    } on HttpExceptionWithStatus catch (e) {
      switch (e.statusCode) {
        case HttpStatus.notFound:
          return AuthResult(userCredential: null, error: 'user-not-found');
        default:
          return AuthResult(
              userCredential: null, error: 'internal-server-error');
      }
    }
  }
}
