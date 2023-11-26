import 'package:app/widgets/Announcements/announcements_context.dart';
import 'package:app/widgets/Announcements/announcements_screen.dart';
import 'package:app/widgets/Announcements/NewAnnouncement/new_announcement.dart';
import 'package:app/widgets/Calendar/calendar_screen.dart';
import 'package:app/widgets/Groups/complete_rol_screen.dart';
import 'package:app/widgets/Groups/groups_context.dart';
import 'package:app/widgets/Groups/groups_screen.dart';
import 'package:app/widgets/Groups/groups_toolbar.dart';
import 'package:app/widgets/Menu/menu_screen.dart';
import 'package:app/widgets/app_context.dart';
import 'package:app/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AnnouncementsContext()),
        ChangeNotifierProvider(create: (context) => AppContext()),
        ChangeNotifierProvider(create: (context) => GroupsContext())
      ],
      child: const AppController(),
    );
  }
}

class AppController extends StatefulWidget {
  const AppController({super.key});

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
      "toolbar": const ToolBar(),
      "body": Consumer<AnnouncementsContext>(
        builder: (context, announcementsState, child) =>
            AnnouncementScreenController(
          announcementsState: announcementsState,
        ),
      ),
      "floatingButton": const NewAnnouncementDialog()
    },
    {
      "toolbar": GroupsToolBar(),
      "body": Consumer2(
        builder: (context, AppContext appContext, GroupsContext groupsContext,
                child) =>
            GroupsScreen(
          appContext: appContext,
          groupsContext: groupsContext,
        ),
      )
    },
    {"toolbar": const ToolBar(), "body": CalendarScreen()},
    {"toolbar": const ToolBar(), "body": MenuScreen()}
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
