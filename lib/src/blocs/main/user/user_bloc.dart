import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' hide Response;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/data/services/user_service.dart';
import 'package:kima/src/utils/configs.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/exceptions/api_result_exception.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/failures/failure.dart';
import 'package:kima/src/utils/helpers/image_picker_helper.dart';
import 'package:kima/src/utils/helpers/print_helpers.dart';
import 'package:kima/src/utils/helpers/shared_pref_helpers.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState(status: Status.initial)) {
    on<SetCurrentUserEvent>(_setCurrentUser);
    on<UpdateUserEvent>(_updateUser);
    on<UploadUserPhotoEvent>(_uploadUserPhoto);
    on<GetUserVisitByIdEvent>(_getUserVisitById);
    on<SetUserVisitEvent>(_setUserVisit);
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

  Future<void> _setCurrentUser(SetCurrentUserEvent event, emit) async {
    final user = event.user;

    emit(state.copyWith(user: user));

    /// Download profile avatar and cover photo
    if (user.avatar != null) {
      emit(state.copyWith(status: Status.loading));
      await CacheManagerHelper.downloadImageToCache(path: user.avatarUrl, key: '${user.id}_avatar');
      emit(state.copyWith(status: Status.success));
    }
    if (user.coverPhoto != null) {
      emit(state.copyWith(status: Status.loading));
      await CacheManagerHelper.downloadImageToCache(path: user.coverUrl, key: '${user.id}_cover');
      emit(state.copyWith(status: Status.success));
    }
  }

  Future<void> _updateUser(UpdateUserEvent event, emit) async {
    emit(state.copyWith(status: Status.loading));

    final token = await readStringSharedPref(spProfileJwt);

    try {
      final response = await _chopper.getService<UserService>().update(
            token: token!,
            body: event.data,
          );

      if (!response.isSuccessful) throw ApiResultException(message: json.decode(response.bodyString)['message']);

      final data = response.body['data'];
      final user = UserProfile.fromJson(data);

      emit(state.copyWith(
        status: Status.success,
        user: user,
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

  Future<void> _uploadUserPhoto(UploadUserPhotoEvent event, emit) async {
    final img = event.source == ImageSource.camera
        ? await ImagePickerHelper.getImageFromCamera()
        : await ImagePickerHelper.getImageFromGallery();
    if (img == null) return;

    final token = await readStringSharedPref(spProfileJwt);
    final id = state.user?.id;
    final imageFile = await MultipartFile.fromPath(
      'image',
      img.path,
      contentType: MediaType.parse('image/${img.path.fileType}'),
    );

    try {
      emit(state.copyWith(photoStatus: event.type == 'avatar' ? PhotoStatus.avatarLoading : PhotoStatus.coverLoading));

      Response<dynamic> uploadResponse;
      if (event.type == 'avatar') {
        uploadResponse = await _chopper.getService<UserService>().uploadAvatar(
              token: token!,
              image: imageFile,
            );
      } else {
        uploadResponse = await _chopper.getService<UserService>().uploadCover(
              token: token!,
              image: imageFile,
            );
      }

      if (!uploadResponse.isSuccessful) {
        throw ApiResultException(message: json.decode(uploadResponse.bodyString)['message']);
      }

      /// Get updated user data
      final userResponse = await _chopper.getService<UserService>().getById(token: token, id: id!);

      if (!userResponse.isSuccessful) {
        throw ApiResultException(message: json.decode(userResponse.bodyString)['message']);
      }

      /// Cache uploaded photos
      final user = UserProfile.fromJson(userResponse.body);

      event.type == 'avatar'
          ? await CacheManagerHelper.downloadImageToCache(path: user.avatarUrl, key: '${user.id}_avatar')
          : await CacheManagerHelper.downloadImageToCache(path: user.coverUrl, key: '${user.id}_cover');

      emit(state.copyWith(
        photoStatus: PhotoStatus.success,
        user: user,
      ));
    } on ApiResultException catch (e) {
      final error = e.message;

      emit(
        state.copyWith(
          photoStatus: PhotoStatus.failed,
          error: error != null ? Failure(message: error) : const Failure(),
        ),
      );
    } catch (e, stackTrace) {
      printCatch(e, stackTrace, runtimeType);
      emit(
        state.copyWith(
          photoStatus: PhotoStatus.failed,
          error: const Failure(),
        ),
      );
    }
  }

  Future<void> _getUserVisitById(GetUserVisitByIdEvent event, emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final token = await readStringSharedPref(spProfileJwt);

      final response = await _chopper.getService<UserService>().getById(
            token: token!,
            id: event.id,
          );

      if (!response.isSuccessful) throw ApiResultException(message: json.decode(response.bodyString)['message']);

      final user = UserProfile.fromJson(response.body);

      emit(state.copyWith(
        status: Status.success,
        userVisit: user,
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

  void _setUserVisit(SetUserVisitEvent event, emit) => emit(state.copyWith(userVisit: event.user));
}
