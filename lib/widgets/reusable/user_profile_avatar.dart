import 'package:app/models/user.dart';
import 'package:app/widgets/reusable/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UserProfileAvatar extends StatelessWidget {
  final UserModel user;
  final double radius;
  final bool isLoggedUser;

  const UserProfileAvatar(
      {super.key,
      required this.user,
      this.radius = 20,
      this.isLoggedUser = false});

  @override
  Widget build(BuildContext context) {
    String heroId = const Uuid().v1();
    String route = isLoggedUser ? '/myProfile' : '/profile';
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route,
            arguments: {"user": user, "heroTag": heroId});
      },
      child: Hero(
          tag: heroId,
          child: UserAvatar.fromUser(
            radius: radius,
            user: user,
          )),
    );
  }
}
