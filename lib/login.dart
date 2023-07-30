import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*Image.asset(
              'assets/logo.png', // Si tienes un logo, coloca la imagen en la carpeta 'assets' y referencia la ruta aquí.
              height: 100,
            ),*/
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Correo'),
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí irá el código para validar el inicio de sesión.
              },
              style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: LoginScreen(),
  ));
}
