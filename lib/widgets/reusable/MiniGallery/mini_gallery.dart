import 'package:app/widgets/reusable/MiniGallery/mini_gallery_image.dart';
import 'package:app/widgets/reusable/MiniGallery/photo_viewer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MiniGallery extends StatelessWidget {
  List<Image?> images = [];

  MiniGallery({super.key, required this.images});

  _showPhotoViewer(BuildContext context, int index) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    showGeneralDialog<String>(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return PhotoViewerScreen(images: images, currentIndex: index,);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double bucketProportion = 4 / images.length;

    if (bucketProportion == 2) {
      return _render2(bucketProportion, context);
    } else if (images.length > 1) {
      return _render3(bucketProportion, context);
    }

    return images.length > 0 ? MiniGalleryImage(
      onTap: () {
        _showPhotoViewer(context, 0);
      },
      image: images[0],
    ) : Container();
  }

  Widget _render2(double bucketProportion, BuildContext context) {
    return Row(
      children: [
        MiniGalleryImage(
          onTap: () {
            _showPhotoViewer(context, 0);
          },
          image: images[0],
          isInList: true,
          index: 0,
          bucketProportion: bucketProportion,
        ),
         Container(
            width: 2,
          ),
        MiniGalleryImage(
          onTap: () {
            _showPhotoViewer(context, 1);
          },
          image: images[1],
          isInList: true,
          index: 1,
          bucketProportion: bucketProportion,
        )
      ],
    );
  }

  Widget _render3(double bucketProportion, BuildContext context) {
    return Row(
      children: [
        MiniGalleryImage(
          onTap: () {
            _showPhotoViewer(context, 0);
          },
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
              onTap: () {
                _showPhotoViewer(context, 1);
              },
              image: images[1],
              isInList: true,
              index: 1,
              bucketProportion: bucketProportion,
            ),
            Container(
              height: 2,
            ),
            MiniGalleryImage(
              onTap: () {
                _showPhotoViewer(context, 2);
              },
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
