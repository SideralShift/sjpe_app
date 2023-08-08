import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:app/models/user.dart';
import 'dart:convert';

class AuthService {
  Future<UserCredential?> logginUser(UserModel user) async {
    UserCredential? userCredential;
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: 'sideraltest@gmail.com', password: 'ekizcosa');
      final user = credential.user;
      print(user?.uid);
      final response = await http.get(
        Uri.parse(
            'http://10.0.2.2:8080/auth/token/AIPFN0foVmXJyOgvI6WSOWCPD1t2'),
      );
      final responsejson = jsonDecode(response.body);

      userCredential = await FirebaseAuth.instance
          .signInWithCustomToken(responsejson['token']);
      print(await userCredential.user?.getIdToken());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          print('No user found for that email.');
          break;
        case "wrong-password":
          print('Wrong password provided for that user.');
          break;
        case "invalid-custom-token":
          print("The supplied token is not a Firebase custom auth token.");
          break;
        case "custom-token-mismatch":
          print("The supplied token is for a different Firebase project.");
          break;
        default:
          print("Unknown error.");
      }
    }
    return userCredential;
  }
}
