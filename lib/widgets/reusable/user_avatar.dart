import 'package:app/models/user.dart';
import 'package:app/utils/classes/storage_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final double radius;
  final ImageProvider? foregroundImage;

  UserAvatar({this.radius = 20, this.foregroundImage});

  factory UserAvatar.fromStorage({StorageImage? image, double radius = 20}) {
    UserAvatar avatar = UserAvatar(
        radius: radius,
        foregroundImage: image != null ? Image.memory(image.data,).image : null,
      );
    return avatar;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: radius,
        foregroundImage: foregroundImage,
      ),
    );
  }
}
