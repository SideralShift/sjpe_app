import 'package:flutter/material.dart';

class NewAnnouncementActions extends StatelessWidget {
  void Function() onAttachImagePressed;

  NewAnnouncementActions({required this.onAttachImagePressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onAttachImagePressed,
          icon: Icon(Icons.image),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.attach_file),
        )
      ],
    );
  }
}
