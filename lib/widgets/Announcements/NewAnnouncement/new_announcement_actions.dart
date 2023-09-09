import 'package:flutter/material.dart';

class NewAnnouncementActions extends StatelessWidget {
  void Function() onAttachImagePressed;

  NewAnnouncementActions({super.key, required this.onAttachImagePressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onAttachImagePressed,
          icon: const Icon(Icons.image),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.attach_file),
        )
      ],
    );
  }
}
