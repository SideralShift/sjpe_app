import 'package:flutter/material.dart';

class ProfileBase extends StatelessWidget {
  List<Widget> children;

  ProfileBase({required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black54, //change your color here
          ),
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
            child: Center(
                child: ListView(children: [
          Column(
            children: children,
          )
        ]))));
  }
}
