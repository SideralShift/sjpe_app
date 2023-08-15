import 'package:app/widgets/Announcements/announcements_context.dart';
import 'package:app/widgets/Announcements/announcements_screen.dart';
import 'package:app/widgets/Announcements/new_announcement.dart';
import 'package:app/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _actualIndex = 0;
  final _pageController = PageController();

  final List<Map<String, Widget>> _pages = [
    {
      "toolbar": ToolBar(),
      "body": Consumer<AnnouncementsContext>(
        builder: (context, announcementsState, child) =>
            AnnouncementScreenController(
          announcementsState: announcementsState,
        ),
      ),
      "floatingButton": NewAnnouncement()
    },
    {"toolbar": ToolBar(), "body": const Text('Grupos page')},
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AnnouncementsContext())
      ],
      child: Scaffold(
        appBar: _pages[_actualIndex]['toolbar'] as PreferredSizeWidget,
        body: PageView(
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
      ),
    );
  }
}
