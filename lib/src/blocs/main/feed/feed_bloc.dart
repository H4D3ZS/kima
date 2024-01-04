import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart' hide Post;
import 'package:equatable/equatable.dart';
import 'package:kima/src/data/models/daily_status.dart';
import 'package:kima/src/data/models/feed_post.dart';
import 'package:kima/src/data/services/user_service.dart';
import 'package:kima/src/utils/configs.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/exceptions/api_result_exception.dart';
import 'package:kima/src/utils/failures/failure.dart';
import 'package:kima/src/utils/helpers/shared_pref_helpers.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc() : super(const FeedState(status: FeedStatus.initial)) {
    on<GetProfileFeedEvent>(_getProfileFeed);
    on<GetDashboardFeedEvent>(_getDashboardFeed);
  }

  final _chopper = ChopperClient(
    baseUrl: Uri.parse(baseUrlDev),
    converter: const JsonConverter(),
    services: [UserService.create()],
  );

  @override
  Future close() {
    _chopper.dispose();
    return super.close();
  }

  Future<List<FeedPost>> _getCurrentUserDailyStatusPosts() async {
    final token = await readStringSharedPref(spProfileJwt);

    final dailyStatusResponse = await _chopper.getService<UserService>().getAllDailyStatusById(token: token!);

    if (!dailyStatusResponse.isSuccessful) {
      throw ApiResultException(message: json.decode(dailyStatusResponse.bodyString)['message']);
    }

    final data = dailyStatusResponse.body['data'];
    final dailyStatusList = data.map<DailyStatus>((status) => DailyStatus.fromJson(status)).toList();

    return List<FeedPost>.from(dailyStatusList.map(
      (status) => FeedPost(
        id: status.id,
        type: Post.status,
        dailyStatus: status,
      ),
    ));
  }

  Future<void> _getProfileFeed(GetProfileFeedEvent event, emit) async {
    emit(state.copyWith(status: FeedStatus.profileLoading));

    try {
      final currentUserDailyStatus = await _getCurrentUserDailyStatusPosts();
      // Get own classified ad posts

      // Merge into one list

      emit(state.copyWith(
        status: FeedStatus.profileSuccess,
        profileFeed: currentUserDailyStatus,
      ));
    } on ApiResultException catch (e) {
      final error = e.message;
      emit(
        state.copyWith(
          status: FeedStatus.profileError,
          error: error != null ? Failure(message: error) : const Failure(),
        ),
      );
    }
  }

  Future<void> _getDashboardFeed(GetDashboardFeedEvent event, emit) async {
    emit(state.copyWith(status: FeedStatus.dashboardLoading));

    try {
      final currentUserDailyStatus = await _getCurrentUserDailyStatusPosts();
      // Get current logged in user classified ad posts

      // Get daily status from users in the favorite list
      // Get classified ad posts from users in the favorite list

      // Merge into one list

      emit(state.copyWith(
        status: FeedStatus.dashboardSuccess,
        dashboardFeed: currentUserDailyStatus,
      ));
    } on ApiResultException catch (e) {
      final error = e.message;
      emit(
        state.copyWith(
          status: FeedStatus.dashboardError,
          error: error != null ? Failure(message: error) : const Failure(),
        ),
      );
    }
  }
}
