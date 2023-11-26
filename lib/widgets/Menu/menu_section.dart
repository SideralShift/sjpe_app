import 'package:app/widgets/Menu/menu_item.dart';
import 'package:flutter/material.dart';

class MenuSection extends StatelessWidget {
  final String title;
  final List<MenuItem> items;

  const MenuSection({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 8.0, // horizontal spacing between items
            runSpacing: 8.0, // vertical spacing between lines
            children: items.map((item) => MenuItemWidget(item: item)).toList(),
            alignment: WrapAlignment.start,
          ),
        ],
      ),
    );
  }
}
