import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                decoration: const InputDecoration(labelText: 'Correo'),
                style: const TextStyle(fontSize: 22),
              ),
            ),
            const SizedBox(height: 45),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                style: const TextStyle(fontSize: 22),
              ),
            ),
            const SizedBox(height: 100),
            SizedBox(
              width: 200, // Ajusta el ancho del botón a 200 puntos
              child: ElevatedButton(
                onPressed: () {
                  // Aquí irá el código para validar el inicio de sesión.
                },
                style: ElevatedButton.styleFrom(
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
