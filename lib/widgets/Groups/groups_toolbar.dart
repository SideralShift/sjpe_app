import 'package:app/utils/app_colors.dart';
import 'package:app/widgets/Groups/complete_rol_screen.dart';
import 'package:app/widgets/Groups/groups_context.dart';
import 'package:app/widgets/app_context.dart';
import 'package:app/widgets/reusable/safe_dialog.dart';
import 'package:app/widgets/reusable/user_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GroupsToolBar extends StatelessWidget implements PreferredSizeWidget {
  void _showCompleteRol(BuildContext context, GroupsContext groupsContext) {
    showGeneralDialog<String>(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: AppStyles.mainBackgroundColor!,
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return SafeDialog(
            child: CompleteRolScreen(
          groupSchedules: groupsContext.groupSchedules,
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupsContext>(
        builder: (context, groupsContext, child) => AppBar(
              elevation: 0,
              titleSpacing: 14,
              centerTitle: false,
              backgroundColor: AppStyles.mainBackgroundColor,
              title: Text('Grupos y Rol',
                        style: GoogleFonts.openSans(
                            color: Colors
                                .black, // Change this color to your desired color
                            fontWeight: FontWeight.w600,
                            fontSize: 24)),
              actions: [
                Padding(
                    padding:
                        const EdgeInsets.only(right: 12, bottom: 10, top: 10),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showCompleteRol(context, groupsContext);
                      },
                      icon: Icon(Icons.remove_red_eye), // The eye icon
                      label: Text("Ver Rol"), // The text "Rol de Trabajo"
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ))
              ],
            ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
