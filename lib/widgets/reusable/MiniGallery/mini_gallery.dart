import 'package:app/models/attachment.dart';
import 'package:app/utils/classes/storage_image.dart';
import 'package:app/widgets/reusable/MiniGallery/mini_gallery_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class MiniGallery extends StatelessWidget {
  final List<Image?> images;

  MiniGallery({required this.images});

  _showPhotoViewer(BuildContext context, int index) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    showGeneralDialog<String>(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Scaffold(
          body: Stack(
            children: [
              // Image with fitted box
              PhotoViewGallery(
                pageOptions: images
                    .map((e) =>
                        PhotoViewGalleryPageOptions(imageProvider: e?.image))
                    .toList(),
              ),

              // Gradient overlay at the top
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 150, // Fixed height
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                        // Adjust the opacity and color as needed
                      ],
                      stops: [
                        0.0,
                        0.7
                      ], // Adjust the stops to control the gradient distribution
                    ),
                  ),
                ),
              ),

              // Gradient overlay at the bottom
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 150, // Fixed height
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [Colors.black, Colors.transparent],
                      ),
                    ),
                  )),

              // Circular button at the top left
              Positioned(
                top: 45,
                left: 10,
                child: SizedBox(
                  height: 25,
                  child: FloatingActionButton(
                    mini: true,
                    elevation: 0,
                    onPressed: () {
                      Navigator.of(context).pop();
                      SystemChrome.setEnabledSystemUIMode(
                          SystemUiMode.edgeToEdge);
                    },
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    child: Icon(Icons.close),
                  ),
                ),
              )
            ],
          ),
        );
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

    return MiniGalleryImage(
      onTap: () {
        _showPhotoViewer(context, 0);
      },
      image: images[0],
    );
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
        Expanded(
          child: Container(
            width: double.infinity,
          ),
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
