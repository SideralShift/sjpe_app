import 'package:app/utils/app_colors.dart';
import 'package:app/utils/general_constants.dart';
import 'package:app/widgets/app_context.dart';
import 'package:app/widgets/reusable/user_avatar.dart';
import 'package:app/widgets/reusable/user_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ToolBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppContext>(
        builder: (context, appContext, child) => AppBar(
              elevation: 0,
              titleSpacing: 10,
              centerTitle: false,
              backgroundColor: AppStyles.mainBackgroundColor,
              title: Row(
                children: [
                  const Image(
                    height: 42,
                    image: AssetImage('lib/assets/logo-sjpe.png'),
                  ),
                  GestureDetector(onTap: (){
                    appContext.cleanUserSession();
                    Navigator.pushNamed(context, '/login');
                  }, child: Text('SJPE',
                      style: GoogleFonts.openSans(
                          color: Colors
                              .black, // Change this color to your desired color
                          fontWeight: FontWeight.bold,
                          fontSize: 26)),),
                ],
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: UserProfileAvatar(
                      user: appContext.loggedUser
                    ),
                  ),
                )
              ],
            ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
