import 'package:app/models/group.dart';
import 'package:app/models/user.dart';
import 'package:app/utils/app_colors.dart';
import 'package:app/widgets/reusable/user_avatar.dart';
import 'package:app/widgets/reusable/user_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompleteGroupScreen extends StatelessWidget {
  final Group group;

  CompleteGroupScreen({required this.group});

  Widget _buildMemberSection(String title, List<UserModel?> members) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 8),
        ...members.map((member) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ListTile(
                    title: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: member != null ? UserProfileAvatar(user: member) : CircleAvatar(),
                        ),
                        Text(member?.person.getFullName() ?? '')
                      ],
                    ),
                    // Add other user details here
                  ),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppStyles.mainBackgroundColor,
        foregroundColor: Colors.black,
        title: Text('Grupo ${group.id}',
            style: GoogleFonts.openSans(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMemberSection('Lider', [group.leader]),
            SizedBox(height: 16),
            _buildMemberSection('Co-Lider', [group.coLeader]),
            SizedBox(height: 16),
            _buildMemberSection('Integrantes', group.members),
          ],
        ),
      ),
    );
  }
}
