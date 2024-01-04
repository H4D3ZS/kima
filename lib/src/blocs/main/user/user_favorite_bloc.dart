import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:equatable/equatable.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/data/services/user_service.dart';
import 'package:kima/src/utils/configs.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/exceptions/api_result_exception.dart';
import 'package:kima/src/utils/failures/failure.dart';
import 'package:kima/src/utils/helpers/shared_pref_helpers.dart';

part 'user_favorite_event.dart';
part 'user_favorite_state.dart';

class UserFavoriteBloc extends Bloc<UserFavoriteEvent, UserFavoriteState> {
  UserFavoriteBloc() : super(const UserFavoriteState(status: Status.initial)) {
    on<GetMyFavoriteUsersEvent>(_getMyFavoriteUsers);
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

  Future<List<String>> getClientSelectedFavorites(String token) async {
    final response = await _chopper.getService<UserService>().getClientSelectedFavorites(token: token);

    if (!response.isSuccessful) {
      throw ApiResultException(message: json.decode(response.bodyString)['message']);
    }

    final data = response.body;
    final favoriteUserIds = data.map<String>((favorite) => favorite['userId']).toList();

    return favoriteUserIds;
  }
  

  Future<void> _getMyFavoriteUsers(GetMyFavoriteUsersEvent event, emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final token = await readStringSharedPref(spProfileJwt);

      final response = await _chopper.getService<UserService>().getMyFavorites(token: token!);

      if (!response.isSuccessful) {
        throw ApiResultException(message: json.decode(response.bodyString)['message']);
      }

      final data = response.body;
      final favoriteUsersList = data.map((favorite) => favorite['favoriteUser']).toList();

      final favoriteUsers = favoriteUsersList.map<UserProfile>((user) => UserProfile.fromJson(user)).toList();

      emit(state.copyWith(
        status: Status.success,
        favoriteUsers: favoriteUsers,
      ));
    } on ApiResultException catch (e) {
      final error = e.message;
      emit(
        state.copyWith(
          status: Status.failed,
          error: error != null ? Failure(message: error) : const Failure(),
        ),
      );
    }
  }
}
