import 'package:app/widgets/Menu/menu_item.dart';
import 'package:app/widgets/Menu/menu_section.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10,
            ),
            MenuSection(
              title: 'Socios',
              items: [
                MenuItem(name: 'Jovenes', iconData: Icons.groups, route: '/members'),
                MenuItem(name: 'Cumpleaños', iconData: Icons.cake, route: '/birthdays'),
                // Add more items as needed
              ],
            ),
            SizedBox(
              height: 10,
            ),
            MenuSection(
              title: 'Administración',
              items: [
                MenuItem(name: 'Comisiones', iconData: Icons.assignment, route: '/commissions'),
                MenuItem(name: 'Organigrama', imagePath: 'lib/assets/organization_chart.png', route: '/organization/chart'),
                // Add more items as needed
              ],
            ),
            // Add more MenuSections as needed
          ],
        ),
      ),
    );
  }
}
