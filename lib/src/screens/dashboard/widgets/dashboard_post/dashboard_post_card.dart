import 'package:flutter/material.dart';
import 'package:kima/src/data/models/daily_status.dart';
import 'package:kima/src/screens/dashboard/widgets/dashboard_post/classified_ad/classified_ad_post.dart';
import 'package:kima/src/screens/dashboard/widgets/dashboard_post/dashboard_post_header.dart';
import 'package:kima/src/screens/dashboard/widgets/dashboard_post/daily_status_post.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:timeago/timeago.dart' as timeago;

class DashboardPostCard extends StatelessWidget {
  const DashboardPostCard({
    Key? key,
    required this.type,
    this.isCurrentUserPost = true,
    this.images,
    this.dailyStatus,
  }) : super(key: key);

  final Post type;
  final bool isCurrentUserPost;
  final List<String>? images;
  final DailyStatus? dailyStatus;

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border.symmetric(
            horizontal: BorderSide(
              width: 1.0,
              color: AppColors.lightGrey30,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardPostHeader(
              isCurrentUserPost: isCurrentUserPost,
              postDate: timeago.format(
                type == Post.status ? DateTime.parse(dailyStatus!.createdAt!).toLocal() : DateTime.now(),
              ),
            ),
            type == Post.status ? DailyStatusPost(dailyStatus?.statusContent) : ClassifiedAdPost(images: images!),
          ],
        ),
      );
}
