import 'package:app/models/user.dart';
import 'package:app/utils/classes/storage_image.dart';
import 'package:app/utils/general_constants.dart';
import 'package:app/widgets/reusable/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UserProfileAvatar extends StatelessWidget {
  final UserModel user;
  final double radius;
  final ImageProvider? foregroundImage;

  UserProfileAvatar(
      {required this.user, this.radius = 20, this.foregroundImage});

  @override
  Widget build(BuildContext context) {
    String heroId = Uuid().v1();
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
