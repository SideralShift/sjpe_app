import 'dart:typed_data';
import 'package:app/models/announcement.dart';
import 'package:app/models/announcement_attachment.dart';
import 'package:app/models/attachment.dart';
import 'package:app/services/announcement_service.dart';
import 'package:app/services/storage_service.dart';
import 'package:app/utils/app_colors.dart';
import 'package:app/utils/classes/storage_image.dart';
import 'package:app/utils/storage_constants.dart';
import 'package:app/widgets/Announcements/NewAnnouncement/new_announcement_screen.dart';
import 'package:app/widgets/Announcements/announcements_context.dart';
import 'package:app/widgets/app_context.dart';
import 'package:app/widgets/reusable/popup.dart';
import 'package:app/widgets/reusable/safe_dialog.dart';
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

  _pickImage(BuildContext context) async {
    int maxPhotosNum = 3 - newAnnouncement.attachments.length;
    ImagePicker picker = ImagePicker();
    List<XFile?> selectedImages = await picker.pickMultiImage();
    if (selectedImages.length > maxPhotosNum) {
      selectedImages = selectedImages.sublist(0, maxPhotosNum);
      CustomAlert.showCustomAlert(
          context: context,
          details: 'Solo se puede agregar un maximo de 3 fotos');
    }

    if (selectedImages.isNotEmpty) {
      List<AnnouncementAttachment> announcementAttachments = [];

      for (XFile? image in selectedImages) {
        final path =
            '${StorageConstants.pathAnnouncementsAttachments}/${image?.name}';

        Uint8List? imageData = await image?.readAsBytes();
        final imgMetadata = await decodeImageFromList(imageData!);
        StorageImage imgStorage = StorageImage(
            data: imageData,
            path: path,
            width: imgMetadata.width.toDouble(),
            height: imgMetadata.height.toDouble());

        Attachment attachment = Attachment.fromXFile(image!,
            path:
                '${StorageConstants.pathAnnouncementsAttachments}/${image.name}');

        attachment.storageObject = imgStorage;
        AnnouncementAttachment announcementAttachment =
            AnnouncementAttachment(attachment: attachment);
        announcementAttachments.add(announcementAttachment);
      }
      setState(() {
        newAnnouncement.attachments.addAll(announcementAttachments);
      });
    }
  }

  void _deleteAttachment(Attachment attachment) {
    setState(() {
      newAnnouncement.attachments
          .removeWhere((element) => element.attachment == attachment);
    });
  }

  void _handleReorder(int oldIndex, int newIndex) {
    AnnouncementAttachment backedAnnAtt = newAnnouncement.attachments[oldIndex];
    if (oldIndex < newIndex) {
      // removing the item at oldIndex will shorten the list by 1.
      newIndex -= 1;
    }
    setState(() {
      newAnnouncement.attachments.removeAt(oldIndex);
      newAnnouncement.attachments.insert(newIndex, backedAnnAtt);
    });
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
          announcementAttachment.attachment.storageObject!);
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
      onAttachImagePressed: () {
        _pickImage(context);
      },
      handleReorder: _handleReorder,
      onDelete: _deleteAttachment,
      onPublishTap: _publishAnnouncement,
      announcementBodyController: announcementBodyController,
    );
  }
}
