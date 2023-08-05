import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToolBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      titleSpacing: 0,
      centerTitle: false,
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: const Image(
              height: 42,
              width: 42,
              image: AssetImage('lib/assets/logo-sjpe.png'),
            ),
          ),
          Text('SJPE',
              style: GoogleFonts.openSans(
                  color:
                      Colors.black, // Change this color to your desired color
                  fontWeight: FontWeight.bold,
                  fontSize: 26)),
        ],
      ),
      actions: [
        Container(
            margin: const EdgeInsets.only(right: 12),
            child: const CircleAvatar(
              radius:
                  20.0, // Adjust this value to change the size of the CircleAvatar
              backgroundColor: Colors
                  .red, // Customize the background color of the CircleAvatar
              foregroundImage: AssetImage('lib/assets/user_images/jacob.jpg'),
            ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
