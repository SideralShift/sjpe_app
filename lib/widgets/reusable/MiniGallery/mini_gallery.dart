import 'package:app/models/attachment.dart';
import 'package:app/utils/classes/storage_image.dart';
import 'package:app/widgets/reusable/MiniGallery/mini_gallery_image.dart';
import 'package:flutter/material.dart';

class MiniGallery extends StatelessWidget {
  final List<Image?> images;

  MiniGallery({required this.images});

  @override
  Widget build(BuildContext context) {
    double bucketProportion = 4 / images.length;

    if (bucketProportion == 2) {
      return _render2(bucketProportion);
    } else if (images.length > 1) {
      return _render3(bucketProportion);
    }

    return Column(
      children: images
          .map((e) => MiniGalleryImage(
                image: e,
              ))
          .toList(),
    );
  }

  Widget _render2(double bucketProportion) {
    return Row(
      children: [
        MiniGalleryImage(
          image: images[0],
          isInList: true,
          index: 0,
          bucketProportion: bucketProportion,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
          ),
        ),
        MiniGalleryImage(
          image: images[1],
          isInList: true,
          index: 1,
          bucketProportion: bucketProportion,
        )
      ],
    );
  }

  Widget _render3(double bucketProportion) {
    return Row(
      children: [
        MiniGalleryImage(
          image: images[0],
          isInList: true,
          index: 0,
          bucketProportion: bucketProportion,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
          ),
        ),
        Column(
          children: [
            MiniGalleryImage(
              image: images[1],
              isInList: true,
              index: 1,
              bucketProportion: bucketProportion,
            ),
            Container(
            height: 2,
          ),
            MiniGalleryImage(
              image: images[2],
              isInList: true,
              index: 2,
              bucketProportion: bucketProportion,
            )
          ],
        )
      ],
    );
  }
}
