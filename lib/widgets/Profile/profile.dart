import 'package:app/models/user.dart';
import 'package:app/utils/general_constants.dart';
import 'package:app/utils/general_utils.dart';
import 'package:app/widgets/reusable/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
  readOnlyField({label, text}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(labelText: label),
        controller: TextEditingController(text: text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final UserModel user = arguments['user'];
    return Scaffold(
      appBar: AppBar(elevation: 0, title: Text(user.person.getShortName()), backgroundColor: Colors.redAccent,),
      body: SafeArea(
        child: Center(
          child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 20, left: 30),
                  child: ProfileHeader(
                    heroTag: arguments['heroTag'],
                    user: user,
                  ),
                ),
                FractionallySizedBox(widthFactor: 0.9, child: Column(children: [Row(
                  children: [
                    Expanded(
                      child: readOnlyField(
                          label: 'Edad', text: user.person.age.toString()),
                    ),
                    const SizedBox(
                        width: 16.0), // Add some space between the text fields
                    Expanded(
                      child: readOnlyField(label: 'Bautizado', text: 'SI'),
                    ),
                  ],
                ),
                readOnlyField(label: 'Fecha nacimiento', text: '06 Oct 1997'),
                readOnlyField(label: 'Grupo de trabajo', text: 'Grupo 1'),
                readOnlyField(label: 'Telefono', text: user.person.phoneNumber),
                readOnlyField(label: 'Correo', text: user.person.email)],),)
              ],
            ),
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final UserModel user;
  final String heroTag;

  ProfileHeader({required this.user, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: heroTag,
          child: UserAvatar.fromStorage(radius: 65,
            image: user.profilePictureImage,
          ),
        ),
        Expanded(
            child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  '${user.person.getNames()}\n${user.person.lastName}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(fontSize: 20)),
                ),
              ))
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                '${GeneralUtils.capitalizeFirstLetter(user.mainRole?.description)}',
                style: GoogleFonts.roboto(
                    textStyle:
                        const TextStyle(fontSize: 16, color: Colors.black87)),
              ),
            )
          ],
        )),
      ],
    );
  }
}
