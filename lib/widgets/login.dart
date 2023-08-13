import 'package:flutter/material.dart';
import 'package:app/services/auth_service.dart';
import 'package:app/models/user.dart';
import 'package:app/models/person.dart';
import 'package:app/widgets/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/widgets/reusable/popup.dart';
import 'package:app/utils/text_constants.dart';
import 'package:app/utils/email_verificator.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isEmailVerified = true;
  bool isPasswordVerified = true;
  final FocusNode _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        // Cuando pierde el foco
        setState(() {
          isEmailVerified =
              EmailValidator.isValidEmail(_emailController.text.trim());
        });
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  bool get canSubmit =>
      isEmailVerified &&
      isPasswordVerified &&
      _emailController.text.trim().isNotEmpty &&
      _passwordController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                onEditingComplete: () {},
                decoration: InputDecoration(
                    labelText: 'Correo',
                    errorText: isEmailVerified ? null : 'Correo no válido',
                    errorStyle: const TextStyle(color: Colors.red)),
                style: const TextStyle(fontSize: 22),
              ),
            ),
            const SizedBox(height: 45),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                controller: _passwordController,
                onEditingComplete: () {
                  setState(() {
                    isPasswordVerified =
                        _passwordController.text.trim().isNotEmpty;
                  });
                },
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                style: const TextStyle(fontSize: 22),
              ),
            ),
            const SizedBox(height: 100),
            SizedBox(
              width: 200, // Ajusta el ancho del botón a 200 puntos
              child: ElevatedButton(
                onPressed: canSubmit
                    ? () async {
                        final email = _emailController.text;
                        final password = _passwordController.text;

                        if (email.isNotEmpty && password.isNotEmpty) {
                          final user = UserModel(
                            roles: [],
                            person: Person(name: '', email: email),
                            password: password,
                          );
                          final authResult = await AuthService.logginUser(user);
                          final String idToken = await authResult
                                  ?.userCredential?.user
                                  ?.getIdToken() ??
                              '';
                          //local storage
                          if (idToken != '') {
                            // Autenticación exitosa, hacer algo aquí
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setString('customToken', idToken);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => App()),
                            );
                          } else {
                            // Autenticación fallida, hacer algo aquí
                            if (authResult?.error == 'user-not-found') {
                              CustomAlert.showCustomAlert(
                                  context: context,
                                  title: TextConstants.loginInvalidUserTitle,
                                  details:
                                      TextConstants.loginInvalidUserDetail);
                            } else if (authResult?.error == 'wrong-password') {
                              CustomAlert.showCustomAlert(
                                  context: context,
                                  title:
                                      TextConstants.loginInvalidPasswordTitle,
                                  details:
                                      TextConstants.loginInvalidPasswordDetail);
                            } else {}
                          }
                        } else {
                          // Mostrar mensaje de error si los campos están vacíos
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black54,
                  textStyle: const TextStyle(fontSize: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
