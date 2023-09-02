import 'package:app/utils/types.dart';
import 'package:app/widgets/Announcements/NewAnnouncement/attached_images.dart';
import 'package:app/widgets/Announcements/NewAnnouncement/new_announcement_actions.dart';
import 'package:app/widgets/Announcements/NewAnnouncement/new_announcement_toolbar.dart';
import 'package:app/widgets/Announcements/announcements_context.dart';
import 'package:app/widgets/app_context.dart';
import 'package:app/widgets/reusable/formatted_name_role.dart';
import 'package:app/widgets/reusable/user_avatar.dart';
import 'package:flutter/material.dart';

class NewAnnouncementScreen extends StatelessWidget {
  final FocusNode _focusNode = FocusNode();

  final AnnouncementsContext announcementsContext;
  final AppContext appContext;
  final void Function() onAttachImagePressed;
  final List<AttachedImage> attachedImages;

  NewAnnouncementScreen(
      {required this.announcementsContext,
      required this.appContext,
      required this.onAttachImagePressed,
      required this.attachedImages});

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        children: [
          NewAnnouncementToolBar(announcementsContext: announcementsContext),
          Expanded(
              child: ListView(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 14),
                    child: UserAvatar(
                      foregroundImage: appContext.profilePictureImage!,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: FormattedNameRole(
                        user: appContext.loggedUser,
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
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: AttachedImages(attachedImages: attachedImages),
              )
            ],
          )),
          NewAnnouncementActions(onAttachImagePressed: onAttachImagePressed)
        ],
      ),
    );
  }
}
