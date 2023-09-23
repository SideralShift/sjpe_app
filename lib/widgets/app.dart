import 'package:app/widgets/Announcements/announcements_context.dart';
import 'package:app/widgets/Announcements/announcements_screen.dart';
import 'package:app/widgets/Announcements/NewAnnouncement/new_announcement.dart';
import 'package:app/widgets/Birthdays/birthday_screen.dart';
import 'package:app/widgets/app_context.dart';
import 'package:app/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AnnouncementsContext()),
        ChangeNotifierProvider(create: (context) => AppContext())
      ],
      child: AppController(),
    );
  }
}

class AppController extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<AppController> {
  int _actualIndex = 0;
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    Provider.of<AppContext>(context, listen: false).getUserInfo();
  }

  final List<Map<String, Widget>> _pages = [
    {
      "toolbar": ToolBar(),
      "body": Consumer<AnnouncementsContext>(
        builder: (context, announcementsState, child) =>
            AnnouncementScreenController(
          announcementsState: announcementsState,
        ),
      ),
      "floatingButton": NewAnnouncementDialog()
    },
    {"toolbar": ToolBar(), "body": const Text('Grupos page')},
    {
      "toolbar": AppBar(
        elevation: 0,
        titleSpacing: 10,
        centerTitle: false,
        backgroundColor: AppStyles.mainBackgroundColor,
        title: Row(
          children: [
            Text('Cumpleaños',
                style: GoogleFonts.openSans(
                    color:
                        Colors.black, // Change this color to your desired color
                    fontWeight: FontWeight.bold,
                    fontSize: 26)),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius:
                  20.0, // Adjust this value to change the size of the CircleAvatar
              backgroundColor: Colors
                  .red, // Customize the background color of the CircleAvatar
              foregroundImage: AssetImage('lib/assets/user_images/jacob.jpg'),
            ),
          )
        ],
      ),
      "body": const BirthdayScreen()
    },
    {"toolbar": ToolBar(), "body": const Text('Calendario page')},
    {"toolbar": ToolBar(), "body": const Text('Mas page')}
  ];

  void _onNavBarTap(int index) {
    setState(() {
      _actualIndex = index;
    });
    _pageController.jumpToPage(_actualIndex);
  }

  Widget _mapWidgets(Map<String, Widget> e) {
    return e['body']!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _pages[_actualIndex]['toolbar'] as PreferredSizeWidget,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _pages.map(_mapWidgets).toList(),
      ),
      floatingActionButton: _pages[_actualIndex]['floatingButton'],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _actualIndex,
          onTap: _onNavBarTap,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.announcement_outlined),
              label: 'Anuncios',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.groups_outlined),
              label: 'Grupos',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_outlined), label: 'Cumples'),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: 'Calendario',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Más',
            )
          ]),
    );
  }
}
