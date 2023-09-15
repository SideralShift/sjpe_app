import 'package:app/services/storage_service.dart';
import 'package:app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MiniGalleryImage extends StatefulWidget {
  final bool isInList;
  final int index;
  final double bucketProportion;
  final double maxWidth = 300;
  final Image? image;

  MiniGalleryImage(
      {this.isInList = false,
      this.index = 0,
      this.bucketProportion = 0,
      required this.image});

  @override
  State<StatefulWidget> createState() => _MiniGalleryImageState();
}

class _MiniGalleryImageState extends State<MiniGalleryImage> {

  @override
  void initState() {
    super.initState();

    if (widget.image != null && (widget.image?.width == null || widget.image?.height == null)){
      throw Exception("Width and height must be provided in image");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.image != null && widget.isInList == false) {
      return _renderBasedOnRatio();
    } else if (widget.image != null && widget.isInList == true) {
      return _renderIsInList();
    } else {
      return Container();
    }
  }

  ClipRRect _renderBasedOnRatio() {
    Widget imageWidget;
    double ratio = (widget.image?.width)! / (widget.image?.height)!;

    if (ratio < 0.8) {
      imageWidget = SizedBox(
        width: widget.maxWidth,
        height: 400,
        child: widget.image, // Display the image
      );
    } else if (ratio > 1.2) {
      imageWidget = SizedBox(
        width: widget.maxWidth,
        height: 190,
        child: widget.image, // Display the image
      );
    } else {
      imageWidget = SizedBox(
        width: widget.maxWidth,
        height: 300,
        child: widget.image, // Display the image
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

    switch (widget.bucketProportion) {
      case 2:
        sideIndex = widget.index == 0 ? 0 : 1;
        BorderRadius border = sideIndex == 0
            ? const BorderRadius.only(
                topLeft: Radius.circular(AppStyles.cardsBorderRadius),
                bottomLeft: Radius.circular(AppStyles.cardsBorderRadius))
            : const BorderRadius.only(
                topRight: Radius.circular(AppStyles.cardsBorderRadius),
                bottomRight: Radius.circular(AppStyles.cardsBorderRadius));
        return ClipRRect(
          borderRadius: border,
          child: SizedBox(
            width: widget.maxWidth / 2 - 5,
            height: 190,
            child: widget.image, // Display the image
          ),
        );
      case < 2:
        double height = 190;
        sideIndex = widget.index == 0 ? 0 : 1;
        BorderRadius border = sideIndex == 0
            ? const BorderRadius.only(
                topLeft: Radius.circular(AppStyles.cardsBorderRadius),
                bottomLeft: Radius.circular(AppStyles.cardsBorderRadius))
            : widget.index == 1
                ? const BorderRadius.only(
                    topRight: Radius.circular(AppStyles.cardsBorderRadius),
                  )
                : const BorderRadius.only(
                    bottomRight: Radius.circular(AppStyles.cardsBorderRadius));
        if (sideIndex == 1) {
          height = height / 2 - 1;
        }

        return ClipRRect(
          borderRadius: border,
          child: SizedBox(
            width: widget.maxWidth / 2 - 5,
            height: height,
            child: widget.image, // Display the image
          ),
        );
      default:
        return SizedBox(
          width: 200,
          height: 300,
          child: widget.image, // Display the image
        );
    }
  }
}
