import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageAttachment extends StatefulWidget {
  final String path;

  const ImageAttachment({super.key, required this.path});

  @override
  State<StatefulWidget> createState() => _ImageAttachmentState();
}

class _ImageAttachmentState extends State<ImageAttachment> {
  String downloadUrl = '';

  @override
  void initState() {
    super.initState();
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
    return downloadUrl.isNotEmpty ? Image.network(downloadUrl) : Container();
  }
}
