import 'package:app/models/announcement.dart';
import 'package:app/models/person.dart';
import 'package:app/models/user.dart';
import 'package:app/widgets/announcement_card.dart';
import 'package:app/widgets/tool_bar.dart';
import 'package:flutter/material.dart';

class AnnouncementsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Person person = Person(name: 'Salvador', lastName: 'Mata');
    User user =
        User(person: person, roles: ['Presidente'], mainRole: 'Presidente');
    user.photoUrl =
        'https://firebasestorage.googleapis.com/v0/b/sjpe-48ba5.appspot.com/o/profile_photos%2FRoelDoe.png?alt=media&token=74d9b90d-6d84-403a-be11-041f2a21f4dc';
    Announcement announcement = Announcement(
        body:
            'PdD jovenes, el día 18 de marzo se estara llevando acabo la sesión mensual de información, los invito a todos a asistir y a las comisiones preparar sus informes.',
        user: user);
    announcement.createdAt = DateTime(2023, 3, 10, 19, 30);

    Person person2 = Person(name: 'Itchell', lastName: 'Fierro');
    User user2 =
        User(person: person2, roles: ['Secretaria'], mainRole: 'Secretario');
    user2.photoUrl =
        'https://firebasestorage.googleapis.com/v0/b/sjpe-48ba5.appspot.com/o/profile_photos%2FRoelDoe.png?alt=media&token=74d9b90d-6d84-403a-be11-041f2a21f4dc';
    Announcement announcement2 = Announcement(
        body:
            'PdD jovenes el fin de semana estaremos vendiendo barbacoa, estaremos levantando pedidos el dia de mañana',
        user: user2);
    announcement2.createdAt = DateTime(2023, 3, 10, 19, 30);

    return Scaffold(
      appBar: ToolBar(),
      body: Column(
        children: [
          AnnouncementCard(announcement: announcement),
          AnnouncementCard(announcement: announcement2)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.announcement),
              label: 'Anuncios',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.groups),
              label: 'Grupos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: 'Calendario',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Mas',
            )
          ]),
    );
  }
}
