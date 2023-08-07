import 'package:flutter/material.dart';

class SafeDialog extends StatelessWidget {
  final Widget child;

  const SafeDialog({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: child),);
  }
}
