import 'package:app/models/attachment.dart';
import 'package:app/utils/app_colors.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class AttachedImages extends StatelessWidget {
  late List<Attachment> loadedImages;
  final void Function(Attachment) onDelete;
  final void Function(int, int) handleReorder;

  AttachedImages(
      {required this.loadedImages,
      required this.onDelete,
      required this.handleReorder});

  Widget _proxyDecorator(Widget child, int index, Animation<double> animation) {
    return Material(
      color: Colors.transparent,
      child: ScaleTransition(
        scale: animation.drive(
          Tween<double>(begin: 1, end: 0.9).chain(
            CurveTween(curve: Curves.linear),
          ),
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loadedImages.isEmpty) {
      return Container(); // Display a loading indicator while loading images.
    }

    //Draggable(feedback: AttachmentImage(image: image, onDelete: onDelete), child: AttachmentImage(image: image, onDelete: onDelete), childWhenDragging: Container(),)
    return Container(
      height: 200,
      child: ReorderableListView(
        proxyDecorator: _proxyDecorator,
        onReorder: handleReorder,
        scrollDirection: Axis.horizontal,
        children: loadedImages.mapIndexed((index, image) {
          return AttachmentImage(
            image: image,
            onDelete: onDelete,
            key: Key(index.toString()),
          );
        }).toList(),
      ),
    );
  }
}

class AttachmentImage extends StatelessWidget {
  @override
  // TODO: implement key
  Key? get key => super.key;
  final Attachment image;
  final void Function(Attachment) onDelete;

  AttachmentImage({required this.image, required this.onDelete, key})
      : super(key: key);

  _renderDeleteButton() => Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
        child: SizedBox(
          height: 24,
          child: FloatingActionButton(
            mini: true,
            elevation: 0,
            onPressed: () {
              onDelete(image);
            },
            backgroundColor: Colors.black87,
            foregroundColor: Colors.white,
            child: Text(
              String.fromCharCode(Icons.close.codePoint),
              style: TextStyle(
                inherit: false,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: Icons.close.fontFamily,
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 160,
          height: 200,
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppStyles.cardsBorderRadius),
              child: Image.memory(
                (image.storageObject?.data)!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(top: 0, right: 0, child: _renderDeleteButton()),
      ],
    );
  }
}
