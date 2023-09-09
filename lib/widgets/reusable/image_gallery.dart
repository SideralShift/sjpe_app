import 'package:app/models/attachment.dart';
import 'package:app/widgets/reusable/image_attachment.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class ImageGallery extends StatelessWidget {
  final List<Attachment> attachments;

  ImageGallery({required this.attachments});

  @override
  Widget build(BuildContext context) {
    double bucketProportion = 4 / attachments.length;

    if (bucketProportion == 2) {
      return _render2(bucketProportion);
    } else if (bucketProportion < 2 && attachments.length > 1) {
      return _render3(bucketProportion);
    }

    return Column(
      children: attachments
          .map((e) => ImageAttachment(
                path: e.url!,
              ))
          .toList(),
    );
  }

  Widget _render2(double bucketProportion) {
    return Row(
      children: [
        ImageAttachment(
          path: attachments[0].url!,
          isInList: true,
          index: 0,
          bucketProportion: bucketProportion,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
          ),
        ),
        ImageAttachment(
          path: attachments[1].url!,
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
        ImageAttachment(
          path: attachments[0].url!,
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
            ImageAttachment(
              path: attachments[1].url!,
              isInList: true,
              index: 1,
              bucketProportion: bucketProportion,
            ),
            Container(
            height: 2,
          ),
            ImageAttachment(
              path: attachments[2].url!,
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
