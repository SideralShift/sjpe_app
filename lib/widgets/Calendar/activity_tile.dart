import 'package:app/models/activity.dart';
import 'package:app/utils/date_utils.dart';
import 'package:flutter/material.dart';

class ActivityTile extends StatelessWidget{
  Activity activity;
  final double tileHeight;

  ActivityTile({required this.activity, required this.tileHeight});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: tileHeight, child: Card(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(30), // Adjust the radius as needed
        ),
        color: Colors.blue,
        child:  Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.book,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Text(activity.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,)),
              ),
              Text(
                DateUtil.getHour(activity.date, 'es'),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,),
              )
            ],
          ),
        ),
      ),);
  }

}