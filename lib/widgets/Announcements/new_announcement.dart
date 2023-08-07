import 'package:app/models/person.dart';
import 'package:app/models/user.dart';
import 'package:app/utils/app_colors.dart';
import 'package:app/widgets/reusable/formatted_name_role.dart';
import 'package:app/widgets/reusable/safe_dialog.dart';
import 'package:app/widgets/reusable/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewAnnouncement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showGeneralDialog<String>(
          context: context,
          barrierDismissible: true,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          barrierColor: AppColors.mainBackgroundColor!,
          pageBuilder: (BuildContext buildContext, Animation animation,
              Animation secondaryAnimation) {
            return SafeDialog(child: _NewAnnouncementBody());
          }),
      tooltip: 'Nuevo anuncio',
      child: const Icon(Icons.add),
    );
  }
}

class _NewAnnouncementBody extends StatelessWidget {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);

    User user = User(
        person: Person(name: 'Roel', lastName: 'Mendoza'),
        roles: ['Presidente'],
        mainRole: 'Presidente');
    user.photoUrl =
        'https://firebasestorage.googleapis.com/v0/b/sjpe-48ba5.appspot.com/o/profile_photos%2FRoelDoe.png?alt=media&token=74d9b90d-6d84-403a-be11-041f2a21f4dc';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 23,
                child: FittedBox(
                  child: FloatingActionButton(
                    backgroundColor: Colors.black,
                    elevation: 0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Text(
                'Nuevo Anuncio',
                style: GoogleFonts.roboto(
                    color:
                        Colors.black, // Change this color to your desired color
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(72, 28),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Publicar',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ))
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 14),
                child: UserAvatar(
                  user: user,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: FormattedNameRole(
                    user: user,
                  )),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 18, left: 4),
            child: TextField(
                focusNode: _focusNode,
                maxLines: null,
                decoration: const InputDecoration.collapsed(
                    hintText: 'Que esta pasando?',
                    hintStyle: TextStyle(fontSize: 15))),
          ),
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.image),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.attach_file),
              )
            ],
          )
            ],
          ))
        ],
      ),
    );
  }
}
