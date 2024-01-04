import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/blocs/main/feed/feed_bloc.dart';
import 'package:kima/src/screens/dashboard/widgets/dashboard_post/dashboard_post_card.dart';
import 'package:kima/src/utils/widgets/customs/custom_empty_widget.dart';
import 'package:kima/src/utils/widgets/customs/custom_error_widget.dart';
import 'package:kima/src/utils/widgets/customs/custom_loading_widget.dart';

class BusinessProfileFeed extends StatelessWidget {
  const BusinessProfileFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.2),
        child: BlocBuilder<FeedBloc, FeedState>(
          builder: (BuildContext context, state) {
            if (state.status == FeedStatus.profileLoading) return const CustomLoadingWidget();
            if (state.profileFeed?.isEmpty == true) return const CustomEmptyWidget();
            if (state.error != null) return const CustomErrorWidget();

            if (state.profileFeed?.isNotEmpty == true) {
              return Container(
                margin: const EdgeInsets.only(top: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: state.profileFeed!
                      .map((post) => Container(
                            color: Colors.white,
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: DashboardPostCard(
                              type: post.type,
                              dailyStatus: post.dailyStatus,
                            ),
                          ))
                      .toList(),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      );
}
