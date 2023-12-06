import 'package:app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MenuItem {
  final String name;
  final IconData? iconData;
  final String? imagePath;
  final String? route;

  MenuItem({required this.name, this.iconData, this.imagePath, this.route})
      : assert(iconData != null || imagePath != null, 'Either iconData or imagePath must be provided');
}

class MenuItemWidget extends StatelessWidget {
  final MenuItem item;

  const MenuItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget iconWidget;
    if (item.iconData != null) {
      iconWidget = Icon(item.iconData, size: 40);
    } else if (item.imagePath != null) {
      iconWidget = Image.asset(item.imagePath!, width: 40, height: 40);
    } else {
      throw Exception('No icon or image provided');
    }

    return InkWell(
      onTap: () {
        if (item.route != null) {
          Navigator.of(context).pushNamed(item.route!);
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyles.cardsBorderRadius),
        ),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 75,
            width: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                iconWidget,
                SizedBox(height: 8),
                Text(item.name),
              ],
            ),
          ),
        ),
      ),
    );
  }
}