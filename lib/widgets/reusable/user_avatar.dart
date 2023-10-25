import 'package:app/utils/classes/storage_image.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final double radius;
  final ImageProvider? foregroundImage;

  const UserAvatar({super.key, this.radius = 20, this.foregroundImage});

  factory UserAvatar.fromStorage({StorageImage? image, double radius = 20}) {
    UserAvatar avatar = UserAvatar(
      radius: radius,
      foregroundImage: image != null
          ? Image.memory(
              image.data,
            ).image
          : null,
    );
    return avatar;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: CircleAvatar(
            radius: radius,
            foregroundImage: foregroundImage,
            backgroundColor: Colors.grey.shade300,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white, // Set your border color here
              width: 1.0, // Set the border width here
            ),
          )),
    );
  }
}
