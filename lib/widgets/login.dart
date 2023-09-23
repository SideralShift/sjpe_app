import 'package:app/services/auth_service.dart';
import 'package:app/utils/login_constants.dart';
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
  bool isLoading = false;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusnode = FocusNode();

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

  _onLoginTaped(BuildContext context) {
    LoginValidationStates validationState = _validateForm(context);
    if (validationState == LoginValidationStates.validForm) {
      _loginUser(context);
    } else {
      _handleInvalidState(validationState);
    }
  }

  LoginValidationStates _validateForm(BuildContext context) {
    if (!ValidationsUtils.isValidEmail(_emailController.text)) {
      return _emailFocusNode.hasFocus
          ? LoginValidationStates.invalidEmailFocused
          : LoginValidationStates.invalidEmailNotFocused;
    }

    if (_passwordController.text == '') {
      return _passwordFocusnode.hasFocus
          ? LoginValidationStates.emptyPasswordFocused
          : LoginValidationStates.emptyPasswordNotFocused;
    }

    return LoginValidationStates.validForm;
  }

  _handleInvalidState(LoginValidationStates state) {
    switch (state) {
      case LoginValidationStates.invalidEmailNotFocused:
        _emailFocusNode.requestFocus();
        break;
      case LoginValidationStates.invalidEmailFocused:
        CustomAlert.show(Alerts.wrongEmail, context);
        break;
      case LoginValidationStates.emptyPasswordNotFocused:
        _passwordFocusnode.requestFocus();
        break;
      case LoginValidationStates.emptyPasswordFocused:
        CustomAlert.show(Alerts.emptyPassword, context);
        break;
      default:
    }
  }

  _hanldeLoginError(AuthResult authResult) {
    if (authResult.error == 'user-not-found') {
      CustomAlert.show(Alerts.invalidUser, context);
    } else if (authResult.error == 'wrong-password') {
      CustomAlert.show(Alerts.invalidPassword, context);
    } else {
      CustomAlert.show(Alerts.internalServerError, context);
    }
  }

  _loginUser(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final email = _emailController.text;
    final password = _passwordController.text;

    final user = UserModel(
      roles: [],
      person: Person(name: '', email: email),
      password: password,
    );

    final authResult = await AuthService.logginUser(user);

    if (authResult.error != null) {
      // Autenticación fallida, hacer algo aquíz
      setState(() {
        isLoading = false;
      });
      _hanldeLoginError(authResult);
    } else {
      final String? idToken =
          await authResult.userCredential?.user?.getIdToken();
      final String? uid = authResult.userCredential?.user?.uid;
      //local storage
      // Autenticación exitosa, hacer algo aquí
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('idToken', idToken!);
      prefs.setString('userId', uid!);
      Navigator.pushReplacementNamed(context, '/app');
    }
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
              readOnly: isLoading,
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
              readOnly: isLoading,
              controller: _passwordController,
              focusNode: _passwordFocusnode,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 70, // Ajusta el ancho del botón a 200 puntos
            child: ElevatedButton(
              onPressed: () {
                _onLoginTaped(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF6F0007)),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                textStyle:
                    MaterialStateProperty.all(const TextStyle(fontSize: 15)),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(
                      strokeWidth: 2.0,
                      color: Colors.white,
                    )
                  : const Text('INICIAR SESION'),
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
    _passwordController.dispose();
    super.dispose();
  }

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
