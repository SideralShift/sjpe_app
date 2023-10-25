import 'package:app/models/user.dart';
import 'package:app/services/user_service.dart';
import 'package:app/utils/app_colors.dart';
import 'package:app/utils/general_utils.dart';
import 'package:app/widgets/Profile/common/address_profile_section.dart';
import 'package:app/widgets/Profile/common/personaldata_profile_section.dart';
import 'package:app/widgets/Profile/common/profile_base.dart';
import 'package:app/widgets/Profile/common/profile_header.dart';
import 'package:app/widgets/reusable/readonly_textrow.dart';
import 'package:app/widgets/reusable/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfileScreen extends StatefulWidget {
  final Map<String, dynamic> arguments;

  UserProfileScreen({required this.arguments});

  @override
  State<StatefulWidget> createState() {
    return UserProfileState();
  }
}

class UserProfileState extends State<UserProfileScreen> {
  late UserModel user;

  @override
  void initState() {
    user = widget.arguments['user'];
    UserService.getUserByIdSJPE(user.id!).then((retrivedUser) {
      setState(() {
        retrivedUser?.profilePictureImage = user.profilePictureImage;
        user = retrivedUser!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _UserProfileLayout(
      user: user,
      heroTag: widget.arguments['heroTag'],
    );
  }
}

class _UserProfileLayout extends StatelessWidget {
  final UserModel user;
  final String heroTag;

  const _UserProfileLayout(
      {super.key, required this.user, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return ProfileBase(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: ProfileHeader(
            heroTag: heroTag,
            user: user,
          ),
        ),
        FractionallySizedBox(
          widthFactor: 0.9,
          child: Column(children: [
            PersonalDataProfileSection(user: user),
            AddressProfileSection(user: user)
          ]),
        ),
      ],
    );
  }
}
