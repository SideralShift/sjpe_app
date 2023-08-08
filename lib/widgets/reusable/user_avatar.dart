import 'package:app/models/user.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final UserModel user;
  final double radius;

  UserAvatar({required this.user, this.radius = 20});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      foregroundImage: NetworkImage(user.photoUrl!),
    );
  }
}
