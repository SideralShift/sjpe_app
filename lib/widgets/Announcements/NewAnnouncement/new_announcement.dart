import 'dart:typed_data';
import 'package:app/models/announcement.dart';
import 'package:app/models/announcement_attachment.dart';
import 'package:app/models/attachment.dart';
import 'package:app/services/announcement_service.dart';
import 'package:app/services/attachment_service.dart';
import 'package:app/services/storage_service.dart';
import 'package:app/utils/app_colors.dart';
import 'package:app/utils/storage_constants.dart';
import 'package:app/widgets/Announcements/NewAnnouncement/new_announcement_screen.dart';
import 'package:app/widgets/Announcements/announcements_context.dart';
import 'package:app/widgets/app_context.dart';
import 'package:app/widgets/reusable/safe_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewAnnouncementDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final announcementsContext =
        Provider.of<AnnouncementsContext>(context, listen: false);
    final appContext = Provider.of<AppContext>(context, listen: false);

    return FloatingActionButton(
      onPressed: () =>
          _showNewAnnouncementDialog(context, announcementsContext, appContext),
      tooltip: 'Nuevo anuncio',
      child: const Icon(Icons.add),
    );
  }

  void _showNewAnnouncementDialog(BuildContext context,
      AnnouncementsContext announcementsContext, AppContext appContext) {
    showGeneralDialog<String>(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: AppStyles.mainBackgroundColor!,
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return SafeDialog(
          child: NewAnnouncement(
            announcementsContext: announcementsContext,
            appContext: appContext,
          ),
        );
      },
    );
  }
}

class NewAnnouncement extends StatefulWidget {
  final AnnouncementsContext announcementsContext;
  final AppContext appContext;

  NewAnnouncement(
      {required this.announcementsContext, required this.appContext});

  @override
  State<StatefulWidget> createState() => NewAnnouncementState();
}

class NewAnnouncementState extends State<NewAnnouncement> {
  Announcement newAnnouncement = Announcement(body: '', attachments: []);
  TextEditingController announcementBodyController = TextEditingController();

  _pickImage() async {
    ImagePicker picker = ImagePicker();
    List<XFile?> selectedImages = await picker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      List<AnnouncementAttachment> announcementAttachments = selectedImages
          .map((image) => AnnouncementAttachment(
              attachment: Attachment.fromXFile(image!,
                  '${StorageConstants.pathAnnouncementsAttachments}/${image.name}')))
          .toList();

      for (AnnouncementAttachment announcentAttachment
          in announcementAttachments) {
        if (announcentAttachment.attachment.data == null) {
          await announcentAttachment.attachment.loadData();
        }
      }
      setState(() {
        newAnnouncement.attachments.addAll(announcementAttachments);
      });
    }
  }

  _publishAnnouncement() async {
    Navigator.of(context).pop();
    newAnnouncement.body = announcementBodyController.text;
    newAnnouncement.user = widget.appContext.loggedUser;
    newAnnouncement.createdAt = DateTime.now();

    widget.announcementsContext
        .startPublishing(newAnnouncement, _uploadAnnouncementInfo());
  }

  Future<void> _uploadAnnouncementInfo() async {

    Announcement createdAnnouncement =
        await AnnouncementService.createAnnouncement(newAnnouncement);

    final uploadToFirebaseTasks =
        newAnnouncement.attachments.map((announcementAttachment) {
      return StorageService.saveToFolder(
          announcementAttachment.attachment.data!,
          (announcementAttachment.attachment.url)!);
    }).toList();

    await Future.wait(uploadToFirebaseTasks!).catchError(() {
      _flushAnnouncement(createdAnnouncement);
    });

  }

  _flushAnnouncement(Announcement announcement) {
    if (announcement.id != null) {
      AnnouncementService.deleteAnnouncement(announcement.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Attachment> attachments =
        newAnnouncement.attachments.map((e) => e.attachment).toList();
    return NewAnnouncementScreen(
      announcementsContext: widget.announcementsContext,
      appContext: widget.appContext,
      attachedImages: attachments,
      onAttachImagePressed: _pickImage,
      onPublishTap: _publishAnnouncement,
      announcementBodyController: announcementBodyController,
    );
  }
}
