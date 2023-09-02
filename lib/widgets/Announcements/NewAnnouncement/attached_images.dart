import 'package:app/utils/types.dart';
import 'package:flutter/material.dart';

class AttachedImages extends StatelessWidget {
  final List<AttachedImage> attachedImages;

  AttachedImages({required this.attachedImages});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: attachedImages.map((image) {
        return Container(
          width: 150,
          height: 200,
          child: Padding(padding: EdgeInsets.only(right: 8), child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Image.memory(
              image['data'],
              fit: BoxFit.cover,
            ),
          ),),
        );
      }).toList()),
    );
  }
}
