import 'package:app/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UserAvatarFromStorage extends StatefulWidget {
  final String path;
  final UserModel user;

  UserAvatarFromStorage({required this.path, required this.user});

  @override
  State<StatefulWidget> createState() => UserAvatarFromStorageState();
}

class UserAvatarFromStorageState extends State<UserAvatarFromStorage> {
  String? downloadUrl;

  @override
  void initState() {
    // TODO: implement initState
    FirebaseStorage.instance
        .ref()
        .child(widget.path)
        .getDownloadURL()
        .then((url) => {
              setState(() {
                downloadUrl = url;
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return UserAvatar(user: widget.user, imageUrl: downloadUrl!,);
  }
}

class UserAvatar extends StatelessWidget {
  final UserModel user;
  final double radius;
  final String imageUrl;

  UserAvatar({required this.user, this.radius = 20, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      foregroundImage: NetworkImage(imageUrl),
    );
  }
}
