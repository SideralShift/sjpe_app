import 'package:app/services/storage_service.dart';
import 'package:app/utils/app_colors.dart';
import 'package:app/utils/classes/image_config.dart';
import 'package:app/utils/general_enums.dart';
import 'package:app/widgets/app.dart';
import 'package:flutter/material.dart';

class MiniGalleryImage extends StatefulWidget {
  final bool isInList;
  final int index;
  final double bucketProportion;
  final Image? image;
  void Function()? onTap;

  MiniGalleryImage(
      {this.isInList = false,
      this.index = 0,
      this.bucketProportion = 0,
      required this.image,
      this.onTap});

  @override
  State<StatefulWidget> createState() => _MiniGalleryImageState();
}

class _MiniGalleryImageState extends State<MiniGalleryImage> {
  late double maxWidth;

  @override
  void initState() {
    super.initState();

    if (widget.image != null &&
        (widget.image?.width == null || widget.image?.height == null)) {
      throw Exception("Width and height must be provided in image");
    }
  }

  @override
  Widget build(BuildContext context) {
    maxWidth = MediaQuery.of(context).size.width*0.76;
    
    ImageConfig imgConfig =
        widget.isInList == false ? _configBasedOnRatio() : _configIsInList();

    return widget.image != null
        ? GestureDetector(
            onTap: widget.onTap ?? () {},
            child: ClipRRect(
              borderRadius: imgConfig.generalRadius == 0
                  ? BorderRadius.only(
                      topLeft: Radius.circular(imgConfig.topLeftRadius),
                      topRight: Radius.circular(imgConfig.topRightRadius),
                      bottomLeft: Radius.circular(imgConfig.bottomLeftRadius),
                      bottomRight: Radius.circular(imgConfig.bottomRightRadius))
                  : BorderRadius.circular(imgConfig.generalRadius),
              child: SizedBox(
                width: imgConfig.width,
                height: imgConfig.height,
                child: widget.image, // Display the image
              ),
            ),
          )
        : ClipRRect(
            borderRadius: imgConfig.generalRadius == 0
                ? BorderRadius.only(
                    topLeft: Radius.circular(imgConfig.topLeftRadius),
                    topRight: Radius.circular(imgConfig.topRightRadius),
                    bottomLeft: Radius.circular(imgConfig.bottomLeftRadius),
                    bottomRight: Radius.circular(imgConfig.bottomRightRadius))
                : BorderRadius.circular(imgConfig.generalRadius),
            child: Container(
              color: Colors.grey,
              width: imgConfig.width,
              height: imgConfig.height, // Display the image
            ),
          );
  }

  ImageConfig _configBasedOnRatio() {
    if (widget.image == null) {
      return ImageConfig(
          height: 190,
          width: maxWidth,
          generalRadius: AppStyles.cardsBorderRadius);
    }

    double ratio = (widget.image?.width)! / (widget.image?.height)!;

    if (ratio < 0.8) {
      return ImageConfig(
          height: 400,
          width: maxWidth,
          generalRadius: AppStyles.cardsBorderRadius);
    } else if (ratio > 1.2) {
      return ImageConfig(
          height: 190,
          width: maxWidth,
          generalRadius: AppStyles.cardsBorderRadius);
    } else {
      return ImageConfig(
          height: 300,
          width: maxWidth,
          generalRadius: AppStyles.cardsBorderRadius);
    }
  }

  ImageConfig _configIsInList() {
    //0: left, 1 right
    ImageConfig imgConfig = ImageConfig(width: maxWidth / 2 - 3);
    print(maxWidth);
    final SideIndex sideIndex =
        widget.index == 0 ? SideIndex.left : SideIndex.right;
    const double baseHeight = 190;

    switch (widget.bucketProportion) {
      case 2:
        imgConfig.height = baseHeight;
        if (sideIndex == SideIndex.left) {
          imgConfig.topLeftRadius = AppStyles.cardsBorderRadius;
          imgConfig.bottomLeftRadius = AppStyles.cardsBorderRadius;
        } else {
          imgConfig.topRightRadius = AppStyles.cardsBorderRadius;
          imgConfig.bottomRightRadius = AppStyles.cardsBorderRadius;
        }
      case < 2:
        if (sideIndex == SideIndex.left) {
          imgConfig.height = baseHeight;
          imgConfig.topLeftRadius = AppStyles.cardsBorderRadius;
          imgConfig.bottomLeftRadius = AppStyles.cardsBorderRadius;
        } else {
          imgConfig.height = baseHeight / 2 - 1;
          if (widget.index == 1) {
            imgConfig.topRightRadius = AppStyles.cardsBorderRadius;
          } else {
            imgConfig.bottomRightRadius = AppStyles.cardsBorderRadius;
          }
        }

      default:
        imgConfig = ImageConfig(width: 200, height: 300);
    }

    return imgConfig;
  }
}
