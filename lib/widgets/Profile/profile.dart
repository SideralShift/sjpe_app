import 'package:app/models/user.dart';
import 'package:app/utils/app_colors.dart';
import 'package:app/utils/general_utils.dart';
import 'package:app/widgets/reusable/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  readOnlyField({label, text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            text ?? '',
            style: const TextStyle(color: Colors.black54, fontSize: 16),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final UserModel user = arguments['user'];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black54, //change your color here
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ProfileHeader(
                      heroTag: arguments['heroTag'],
                      user: user,
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Column(children: [
                      Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppStyles
                                .cardsBorderRadius), // Adjust the radius as needed
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                readOnlyField(
                                    label: 'Edad',
                                    text: user.person.age.toString()),
                                readOnlyField(label: 'Bautizado', text: 'SI'),
                                readOnlyField(
                                    label: 'Fecha nacimiento',
                                    text: '06 Oct 1997'),
                                readOnlyField(
                                    label: 'Grupo de trabajo', text: 'Grupo 1'),
                                readOnlyField(
                                    label: 'Telefono',
                                    text: user.person.phoneNumber),
                                readOnlyField(
                                    label: 'Correo', text: user.person.email)
                              ],
                            ),
                          )),
                      Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppStyles
                                .cardsBorderRadius), // Adjust the radius as needed
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                readOnlyField(
                                    label: 'Direccion',
                                    text: user.person.address?.details),
                                readOnlyField(
                                    label: 'Codigo Postal',
                                    text: user.person.address?.postalCode
                                        .toString()),
                                readOnlyField(
                                    label: 'Ciudad',
                                    text: user.person.address?.city.cityName),
                                readOnlyField(
                                    label: 'Estado',
                                    text: user.person.address?.state.stateName),
                              ],
                            ),
                          )),
                          Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppStyles
                                .cardsBorderRadius), // Adjust the radius as needed
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Container(child: TextButton(onPressed: (){}, child: const Text('Cerrar sesión', textAlign: TextAlign.left, style: TextStyle(color: Colors.red),)), width: double.infinity,)
                              ],
                            ),
                          ))
                    ]),
                  ),
                ],
              )
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

  const ProfileHeader({super.key, required this.user, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: heroTag,
          child: UserAvatar.fromStorage(
            radius: 55,
            image: user.profilePictureImage,
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Flexible(
              child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              '${user.person.getNames()} ${user.person.lastName}',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w500)),
            ),
          ))
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            '${GeneralUtils.capitalizeFirstLetter(user.mainRole?.description)}',
            style: GoogleFonts.roboto(
                textStyle:
                    const TextStyle(fontSize: 18, color: Colors.black87)),
          ),
        ),
      ],
    );
  }
}
