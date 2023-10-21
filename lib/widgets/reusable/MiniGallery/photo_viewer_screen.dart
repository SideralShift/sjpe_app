import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewerScreen extends StatelessWidget {
  final List<Image?> images;
  final int currentIndex;

  PhotoViewerScreen({required this.images, this.currentIndex = 0});

  _closePhotoViewer(BuildContext context) {
    Navigator.of(context).pop();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dismissible(
      resizeDuration: null,
      key: UniqueKey(),
      direction: DismissDirection.vertical,
      onDismissed: (_) {
        // Close the photo viewer when dragged down
        _closePhotoViewer(context);
      },
      child: Scaffold(
          body: Stack(
        children: [
          // Image with fitted box
          PhotoViewGallery(
            pageController: PageController(initialPage: currentIndex),
            pageOptions: images
                .map((e) => PhotoViewGalleryPageOptions(
                      imageProvider: e?.image,
                      minScale:
                          PhotoViewComputedScale.contained * 1.0,
                      maxScale: PhotoViewComputedScale.covered * 3.1,
                    ))
                .toList(),
          ),

          // Gradient overlay at the top
          Positioned(
            top: 0,
            left: 0,
            right: 0, // Fixed height
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                    // Adjust the opacity and color as needed
                  ],
                  stops: const [
                    0.0,
                    0.7
                  ], // Adjust the stops to control the gradient distribution
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: SizedBox(
                      height: 25,
                      child: FloatingActionButton(
                        mini: true,
                        elevation: 0,
                        onPressed: () {
                          _closePhotoViewer(context);
                        },
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        child: Icon(Icons.close),
                      ),
                    ),
                  )
                ],
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
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [Colors.black, Colors.transparent],
                  ),
                ),
              )),
        ],
      )),
    );
  }
}
