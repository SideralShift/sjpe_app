import 'package:flutter/material.dart';

class CustomAlert {
  static void showCustomAlert({context, String? title, details}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: title != null ? Text(title) : null,
        content: Text(details),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
