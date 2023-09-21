import 'package:app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:app/models/user.dart';
import 'package:app/models/person.dart';
import 'package:app/widgets/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/widgets/reusable/popup.dart';
import 'package:app/utils/text_constants.dart';
import 'package:app/utils/validations_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
              ValidationsUtils.isValidEmail(_emailController.text.trim());
        });
      }
    });
  }

  _renderlogo() => const Padding(
        padding: EdgeInsets.only(bottom: 65),
        child: Image(
          color: Color(0xFFFFEBD4),
          height: 350,
          image: AssetImage('lib/assets/logo-sjpe.png'),
          fit: BoxFit.fitHeight,
        ),
      );

  _renderForm(BuildContext context) {
    return Center(
        child: FractionallySizedBox(
      widthFactor: 0.80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Text(
              'INICIAR SESIÓN',
              style: TextStyle(fontSize: 25, color: Colors.black54),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: TextFormField(
              controller: _emailController,
              focusNode: _emailFocusNode,
              onEditingComplete: () {},
              decoration: InputDecoration(
                  labelText: 'Correo',
                  errorText: isEmailVerified ? null : 'Correo no válido',
                  errorStyle: const TextStyle(color: Colors.red)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 45),
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
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 70, // Ajusta el ancho del botón a 200 puntos
            child: ElevatedButton(
              onPressed: canSubmit
                  ? () async {
                      final email = _emailController.text;
                      final password = _passwordController.text;

                      if (email.isNotEmpty && password.isNotEmpty) {
                        final user = UserModel(
                          roles: [],
                          person: Person(id: 1, name: '', email: email),
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
                                details: TextConstants.loginInvalidUserDetail);
                          } else if (authResult?.error == 'wrong-password') {
                            CustomAlert.showCustomAlert(
                                context: context,
                                title: TextConstants.loginInvalidPasswordTitle,
                                details:
                                    TextConstants.loginInvalidPasswordDetail);
                          } else {
                            CustomAlert.showCustomAlert(
                                context: context,
                                title: TextConstants.serverDownTitle,
                                details: TextConstants.serverDownDetail);
                          }
                        }
                      } else {
                        // Mostrar mensaje de error si los campos están vacíos
                      }
                    }
                  : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF6F0007)),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                textStyle:
                    MaterialStateProperty.all(const TextStyle(fontSize: 15)),
              ),
              child: const Text('INICIAR SESION'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: TextButton(
                onPressed: () {},
                child: const Text(
                  'NECESITAS AYUDA PARA INICIAR SESIÓN?',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                  ),
                )),
          )
        ],
      ),
    ));
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
      body: Stack(
        children: [
          Center(
            child: _renderlogo(),
          ),
          _renderForm(context)
        ],
      ),
    );
  }
}
