import 'dart:typed_data';

import 'package:app/utils/app_colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageAttachment extends StatefulWidget {
  final String path;
  final bool isInList;
  final int index;
  final double bucketProportion;
  final double maxWidth = 300;

  ImageAttachment(
      {required this.path,
      this.isInList = false,
      this.index = 0,
      this.bucketProportion = 0});

  @override
  State<StatefulWidget> createState() => _ImageAttachmentState();
}

class _ImageAttachmentState extends State<ImageAttachment> {
  double imageWidth = 0.0;
  double imageHeight = 0.0;

  Uint8List? data;

  @override
  void initState() {
    super.initState();

    FirebaseStorage.instance
        .ref()
        .child(widget.path)
        .getDownloadURL()
        .then((url) => {_getImageDimensions(url)});
  }

  Future<void> _getImageDimensions(String url) async {
    FileInfo fileInfo = await DefaultCacheManager().downloadFile(url);

    if (fileInfo.file.existsSync()) {
      Uint8List imageData = fileInfo.file.readAsBytesSync();
      final image = await decodeImageFromList(fileInfo.file.readAsBytesSync());
      setState(() {
        imageWidth = image.width.toDouble();
        imageHeight = image.height.toDouble();
        data = imageData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (data != null && widget.isInList == false) {
      return _renderBasedOnRatio((imageWidth / imageHeight));
    } else if (data != null && widget.isInList == true) {
      return _renderIsInList();
    } else {
      return Container();
    }
  }

  ClipRRect _renderBasedOnRatio(double imageRatio) {
    Widget imageWidget;
    Image image = Image.memory(
      data!,
      fit: BoxFit.cover,
    );
    if ((imageWidth / imageHeight) < 0.8) {
      imageWidget = SizedBox(
        width: widget.maxWidth,
        height: 400,
        child: image, // Display the image
      );
    } else if ((imageWidth / imageHeight) > 1.2) {
      imageWidget = SizedBox(
        width: widget.maxWidth,
        height: 190,
        child: image, // Display the image
      );
    } else {
      imageWidget = SizedBox(
        width: widget.maxWidth,
        height: 300,
        child: image, // Display the image
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppStyles.cardsBorderRadius),
      child: imageWidget,
    );
  }

  Widget _renderIsInList() {
    //0: right, 1 left
    final int sideIndex;

    Image image = Image.memory(
      data!,
      fit: BoxFit.cover,
    );

    switch (widget.bucketProportion) {
      case 2:
        sideIndex = widget.index == 0 ? 0 : 1;
        BorderRadius border = sideIndex == 0
            ? const BorderRadius.only(
                topLeft: Radius.circular(AppStyles.cardsBorderRadius), bottomLeft: Radius.circular(AppStyles.cardsBorderRadius))
            : const BorderRadius.only(
                topRight: Radius.circular(AppStyles.cardsBorderRadius),
                bottomRight: Radius.circular(AppStyles.cardsBorderRadius));
        return ClipRRect(
          borderRadius: border,
          child: SizedBox(
            width: widget.maxWidth / 2 - 5,
            height: 190,
            child: image, // Display the image
          ),
        );
      case < 2:
        double height = 190;
        sideIndex = widget.index == 0 ? 0 : 1;
        BorderRadius border = sideIndex == 0
            ? const BorderRadius.only(
                topLeft: Radius.circular(AppStyles.cardsBorderRadius), bottomLeft: Radius.circular(AppStyles.cardsBorderRadius))
            : widget.index == 1
                ? const BorderRadius.only(
                    topRight: Radius.circular(AppStyles.cardsBorderRadius),
                  )
                : const BorderRadius.only(bottomRight: Radius.circular(AppStyles.cardsBorderRadius));
        if (sideIndex == 1) {
          height = height / 2 - 1;
        }

        return ClipRRect(
          borderRadius: border,
          child: SizedBox(
            width: widget.maxWidth / 2 - 5,
            height: height,
            child: image, // Display the image
          ),
        );
      default:
        return SizedBox(
          width: 200,
          height: 300,
          child: image, // Display the image
        );
    }
  }
}
