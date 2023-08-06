import 'package:app/widgets/Announcements/announcements_screen.dart';
import 'package:app/widgets/tool_bar.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  static final List<Map<String, Widget>> _pages = [
    {"toolbar": ToolBar(), "body": AnnouncementsScreen()},
    {"toolbar": ToolBar(), "body": Text('Grupos page')},
    {"toolbar": ToolBar(), "body": Text('Calendario page')},
    {"toolbar": ToolBar(), "body": Text('Mas page')}
  ];

  int _actualIndex = 0;

  void _onNavBarTap(int index) {
    setState(() {
      _actualIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _pages[_actualIndex]['toolbar'] as PreferredSizeWidget,
      body: _pages[_actualIndex]['body'],
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
              label: 'Mas',
            )
          ]),
    );
  }
}
