import 'package:app/models/attachment.dart';
import 'package:app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AttachedImages extends StatelessWidget {
  late List<Attachment> loadedImages;

  AttachedImages({required this.loadedImages});

  @override
  Widget build(BuildContext context) {
    if (loadedImages.isEmpty) {
      return Container(); // Display a loading indicator while loading images.
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: loadedImages.map((image) {
          return AttachmentImage(image: image);
        }).toList(),
      ),
    );
  }
}

class AttachmentImage extends StatelessWidget {
  final Attachment image;

  AttachmentImage({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppStyles.cardsBorderRadius),
          child: Image.memory(
            image.data!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
