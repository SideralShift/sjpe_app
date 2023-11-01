import 'package:app/models/user.dart';
import 'package:app/utils/classes/storage_image.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final double radius;
  final ImageProvider? foregroundImage;
  final String? tooltipMessage;

  const UserAvatar({
    super.key,
    this.radius = 20,
    this.foregroundImage,
    this.tooltipMessage,
  });

  factory UserAvatar._fromStorage(
      {StorageImage? image, double radius = 20, String? tooltipMessage}) {
    UserAvatar avatar = UserAvatar(
      radius: radius,
      foregroundImage: image != null
          ? Image.memory(
              image.data,
            ).image
          : null,
      tooltipMessage: tooltipMessage,
    );
    return avatar;
  }

  factory UserAvatar.fromUser(
      {UserModel? user, double radius = 20, String? tooltipMessage}) {
    UserAvatar avatar = UserAvatar._fromStorage(
      radius: radius,
      image: user?.profilePictureImage,
      tooltipMessage: user?.person.getShortName(),
    );
    return avatar;
  }

  @override
  Widget build(BuildContext context) {
    Widget avatar = Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white, // Set your border color here
            width: 1.0, // Set the border width here
          ),
        ),
        child: CircleAvatar(
          radius: radius,
          foregroundImage: foregroundImage,
          backgroundColor: Colors.grey.shade300,
        ),
      ),
    );

    return tooltipMessage != null
        ? Tooltip(
            message: tooltipMessage!,
            child: avatar,
          )
        : avatar;
  }
}
