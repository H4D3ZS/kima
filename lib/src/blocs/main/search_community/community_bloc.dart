import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:equatable/equatable.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/data/services/user_service.dart';
import 'package:kima/src/utils/configs.dart';
import 'package:kima/src/utils/exceptions/api_result_exception.dart';
import 'package:kima/src/utils/failures/failure.dart';
import 'package:kima/src/utils/helpers/shared_pref_helpers.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  List<UserProfile> users = [];

  CommunityBloc() : super(const CommunityState()) {
    on<GetAllCommunityEvent>(_onGetSearchCommunity);
  }

  final _chopper = ChopperClient(
    baseUrl: Uri.parse(baseUrlDev),
    converter: const JsonConverter(),
    services: [
      UserService.create(),
    ],
  );

  @override
  Future close() {
    _chopper.dispose();
    return super.close();
  }

  Future<void> _onGetSearchCommunity(GetAllCommunityEvent event, emit) async {
    if (!event.isLoadMore) users = List.empty();

    emit(state.copyWith(
      users: users,
      isLoadingMore: event.isLoadMore,
      isInitialLoading: event.isLoadMore,
    ));

    try {
      final token = await readStringSharedPref(spProfileJwt);
      final page = event.isLoadMore ? event.currentPage + 1 : event.currentPage;

      final response = await _chopper.getService<UserService>().getMembers(
            token: token!,
            page: page,
            perPage: 10,
          );

      if (!response.isSuccessful) throw ApiResultException(message: json.decode(response.bodyString)['message']);

      final data = response.body['data'];
      final userListResult = data.map<UserProfile>((user) => UserProfile.fromJson(user)).toList();

      final pageInfo = response.body['pageInfo'];
      final currentPage = pageInfo['currentPage'];
      final totalPages = pageInfo['totalPages'];

      event.isLoadMore ? users.addAll(userListResult) : users = userListResult;

      emit(state.copyWith(
        users: users,
        currentPage: currentPage,
        totalPages: totalPages,
        isLoadingMore: false,
        isInitialLoading: false,
      ));
    } on ApiResultException catch (e) {
      final error = e.message;

      if (error != null) {
        emit(state.copyWith(error: Failure(message: error)));
      } else {
        emit(state.copyWith(error: const Failure()));
      }
    }
  }
}
