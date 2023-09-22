import 'package:app/utils/text_constants.dart';
import 'package:flutter/material.dart';

enum Alerts {
  internalServerError,
  invalidPassword,
  invalidUser,
  wrongEmail,
  emptyPassword
}

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

  static void show(Alerts alert, BuildContext context) {
    switch (alert) {
      case Alerts.internalServerError:
        showCustomAlert(
            context: context,
            title: TextConstants.serverDownTitle,
            details: TextConstants.serverDownDetail);
      case Alerts.invalidPassword:
        showCustomAlert(
            context: context,
            title: TextConstants.loginInvalidPasswordTitle,
            details: TextConstants.loginInvalidPasswordDetail);
      case Alerts.invalidUser:
        showCustomAlert(
            context: context,
            title: TextConstants.loginInvalidUserTitle,
            details: TextConstants.loginInvalidUserDetail);
      case Alerts.wrongEmail:
        CustomAlert.showCustomAlert(
            context: context, details: TextConstants.wrongUserDetail);
      case Alerts.emptyPassword:
        CustomAlert.showCustomAlert(
            context: context, details: TextConstants.emptyPasswordDetail);
      default:
    }
  }
}
