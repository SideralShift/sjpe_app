import 'dart:typed_data';
import 'package:app/utils/app_colors.dart';
import 'package:app/utils/types.dart';
import 'package:app/widgets/Announcements/NewAnnouncement/new_announcement_screen.dart';
import 'package:app/widgets/Announcements/announcements_context.dart';
import 'package:app/widgets/app_context.dart';
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
      barrierColor: AppColors.mainBackgroundColor!,
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
  /**_uploadFiles(List<XFile?> images) {
    images.forEach((image) async {
      Uint8List? bytes = await image.readAsBytes();
      UploadTask uploadTask = StorageService.saveToFolder(
          bytes, image.name, StorageConstants.pathAnnouncementsAttachments);
      uploadTask.whenComplete(() => print('UPLOADED'));
    });
  } */
  List<AttachedImage> attachedImages = [];

  _pickImage() async {
    ImagePicker picker = ImagePicker();
    List<XFile?> images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      List<AttachedImage> processedImages = await _processImages(images);

      setState(() {
        attachedImages = processedImages;
      });
    }
  }

  Future<List<AttachedImage>> _processImages(
    List<XFile?> xFiles,
  ) async {
    final List<AttachedImage> imageList = [];

    for (final xFile in xFiles) {
      if (xFile != null) {
        Uint8List bytes = await xFile.readAsBytes();
        imageList.add({
          "file": xFile,
          "data": bytes,
        });
      }
    }

    return imageList;
  }

  @override
  Widget build(BuildContext context) {
    return NewAnnouncementScreen(
      announcementsContext: widget.announcementsContext,
      appContext: widget.appContext,
      onAttachImagePressed: _pickImage,
      attachedImages: attachedImages
    );
  }
}
