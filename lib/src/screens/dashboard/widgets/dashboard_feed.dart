import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/blocs/main/feed/feed_bloc.dart';
import 'package:kima/src/screens/dashboard/widgets/dashboard_post/dashboard_post_card.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_empty_widget.dart';
import 'package:kima/src/utils/widgets/customs/custom_error_widget.dart';
import 'package:kima/src/utils/widgets/customs/custom_loading_widget.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class DashboardFeed extends StatelessWidget {
  const DashboardFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(30.0),
          child: CustomText('Your Feed', fontWeight: FontWeight.w500),
        ),
        Container(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.35),
          child: BlocBuilder<FeedBloc, FeedState>(
            builder: (context, state) {
              if (state.status == FeedStatus.dashboardLoading) return const CustomLoadingWidget();
              if (state.dashboardFeed?.isEmpty == true) return const CustomEmptyWidget();
              if (state.error != null) return const CustomErrorWidget();

              if (state.dashboardFeed?.isNotEmpty == true) {
                final feed = state.dashboardFeed!;

                return ListView.separated(
                  itemCount: feed.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 10.0),
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, index) => const VerticalSpace(10.0),
                  itemBuilder: (context, index) => DashboardPostCard(
                    type: feed[index].type,
                    dailyStatus: feed[index].dailyStatus,
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
