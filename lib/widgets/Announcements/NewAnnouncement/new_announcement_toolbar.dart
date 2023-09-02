import 'package:app/widgets/Announcements/announcements_context.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewAnnouncementToolBar extends StatelessWidget{
  final AnnouncementsContext announcementsContext;

  NewAnnouncementToolBar({required this.announcementsContext});
  
  @override
  Widget build(BuildContext context) {
    return Row(
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
                  onPressed: () {
                    announcementsContext.addAnnouncement();
                  },
                  child: const Text(
                    'Publicar',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ))
            ],
          );
  }

}