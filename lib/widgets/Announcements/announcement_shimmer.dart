import 'package:app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

const announcementsPlaceholders = [
  AnnouncementShimmer(),
  AnnouncementShimmer(extraLine: true,),
  AnnouncementShimmer(),
  AnnouncementShimmer(),
  AnnouncementShimmer(extraLine: true,),
  AnnouncementShimmer(extraLine: true,),
];

class AnnouncementShimmer extends StatelessWidget {
  final bool extraLine;

  const AnnouncementShimmer({super.key, this.extraLine = false});
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppStyles.cardsBorderRadius), // Adjust the radius as needed
        ),
        elevation: 5,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    children: [
                      CircleAvatar(),
                    ],
                  ),
                  _buildDetail()
                ],
              ),
            )));
  }

  Widget _buildDetail() {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 130,
                color: Colors.white,
                height: 10,
              )
            ],
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    height: 8,
                  ),
                  const SizedBox(height: 4.0),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    height: 8,
                  ),
                  const SizedBox(height: 4.0),
                  extraLine
                      ? Container(
                          width: double.infinity,
                          color: Colors.white,
                          height: 8,
                        )
                      : Container()
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 50,
                  color: Colors.white,
                  height: 6,
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
