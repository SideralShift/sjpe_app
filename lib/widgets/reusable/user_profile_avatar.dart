import 'package:app/models/user.dart';
import 'package:app/widgets/reusable/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UserProfileAvatar extends StatelessWidget {
  final UserModel user;
  final double radius;
  final ImageProvider? foregroundImage;

  const UserProfileAvatar(
      {super.key, required this.user, this.radius = 20, this.foregroundImage});

  @override
  Widget build(BuildContext context) {
    String heroId = const Uuid().v1();
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/profile', arguments: {
          "user": user,
          "heroTag": heroId
        });
      },
      child: Hero(
          tag: heroId,
          child: Center(
            child: UserAvatar(
              radius: radius,
              foregroundImage: user.profilePictureImage != null
                  ? Image.memory(
                      (user.profilePictureImage?.data)!,
                    ).image
                  : null,
            ),
          )),
    );
  }
}
