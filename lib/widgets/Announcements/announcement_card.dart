import 'package:app/models/announcement.dart';
import 'package:app/services/announcement_service.dart';
import 'package:app/utils/app_colors.dart';
import 'package:app/utils/classes/storage_image.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/widgets/reusable/MiniGallery/mini_gallery.dart';
import 'package:app/widgets/reusable/formatted_name_role.dart';
import 'package:app/widgets/reusable/user_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;

  const AnnouncementCard({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              AppStyles.cardsBorderRadius), // Adjust the radius as needed
        ),
        elevation: 5,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        UserProfileAvatar(user: announcement.user!)
                      ],
                    ),
                    _buildDetail()
                  ],
                ),
                Positioned(
                  right: -10,
                  top: -11,
                  child: _buildPopUpMenu(),
                )
              ],
            )));
  }

  Widget _buildPopUpMenu() {
    return SizedBox(
      height: 40,
      width: 40,
      child: PopupMenuButton(
        padding: const EdgeInsets.all(0),
        splashRadius: 15,
        itemBuilder: (context) {
          return <PopupMenuEntry<int>>[
            PopupMenuItem<int>(
              onTap: () {
                AnnouncementService.deleteAnnouncement(announcement.id!);
              },
              value: 1,
              child: const Row(
                children: [
                  Icon(
                    Icons.delete,
                    size: 20,
                  ),
                  Text('Eliminar')
                ],
              ),
            ),
          ];
        },
        iconSize: 20,
        icon: const Icon(
          Icons.more_horiz,
          color: Colors.black38,
        ),
      ),
    );
  }

  Widget _buildDetail() {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormattedNameRole(user: announcement.user!),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(
                top: 3,
                bottom: 10,
              ),
              child: Row(
                children: [
                  Flexible(
                      child: Text(
                    announcement.body,
                    style: GoogleFonts.openSans(
                    color:
                        Colors.black, // Change this color to your desired color
                    fontSize: 13),
                    textAlign: TextAlign.justify,
                  )),
                ],
              )),
          MiniGallery(
            images: announcement.attachments.map((e) {
              if (e.attachment.storageObject != null) {
                StorageImage imageFromStorage =
                    e.attachment.storageObject as StorageImage;
                return Image.memory(imageFromStorage.data,
                    width: imageFromStorage.width,
                    height: imageFromStorage.height,
                    fit: BoxFit.cover,);
              }
              return null;
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateUtil.formatDate(announcement.createdAt!, 'es'),
                  style: const TextStyle(fontSize: 9),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
