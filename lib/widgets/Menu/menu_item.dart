import 'package:app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MenuItem {
  final String name;
  final IconData iconData;
  final String? route;

  MenuItem({required this.name, required this.iconData, this.route});
}

class MenuItemWidget extends StatelessWidget {
  final MenuItem item;

  const MenuItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (item.route != null) {
          Navigator.of(context).pushNamed(item.route!);
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              AppStyles.cardsBorderRadius), // Adjust the radius as needed
        ),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(height: 75, width: 100, child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(item.iconData, size: 40),
              SizedBox(height: 8),
              Text(item.name),
            ],
          ),),
        ),
      ),
    );
  }
}
