import 'package:app/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UserAvatarFromStorage extends StatefulWidget {
  final String path;
  final UserModel user;
  final double radius;

  UserAvatarFromStorage(
      {required this.path, required this.user, this.radius = 20});

  @override
  State<StatefulWidget> createState() => UserAvatarFromStorageState();
}

class UserAvatarFromStorageState extends State<UserAvatarFromStorage> {
  String? downloadUrl;

  @override
  void initState() {
    super.initState();
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
    return downloadUrl != null
        ? UserAvatar(
            radius: widget.radius,
            foregroundImage: NetworkImage(downloadUrl!),
          )
        : UserAvatar(
            radius: widget.radius,
          );
  }
}

class UserAvatar extends StatelessWidget {
  final double radius;
  final ImageProvider? foregroundImage;

  UserAvatar({this.radius = 20, this.foregroundImage});

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
