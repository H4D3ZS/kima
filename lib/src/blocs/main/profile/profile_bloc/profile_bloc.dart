import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/data/providers/profile_provider.dart';
import 'package:kima/src/utils/failures/failure.dart';
import 'package:kima/src/utils/exceptions/api_result_exception.dart';
import 'package:kima/src/utils/failures/failure_account_not_exist.dart';
import 'package:kima/src/utils/failures/failure_invalid_credentials.dart';
import 'package:kima/src/utils/helpers/api_helpers.dart';
import 'package:kima/src/utils/helpers/print_helpers.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileStateInitial()) {
    on<ProfileEventSaveChanges>(_onEventSaveChanges);
    on<ProfileEventSaveAvatar>(_onEventSaveAvatar);
  }

  Future<void> _onEventSaveChanges(
    ProfileEventSaveChanges event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileStateLoading());

    try {
      final profile = event.profile;

      final profileProvider = ProfileProvider();
      await profileProvider.editProfileNative(
        profile: profile,
      );

      emit(ProfileStateSuccessEdit(
        userProfile: event.profile,
      ));
    } on ApiResultException catch (e) {
      printDebug(e);

      emit(const ProfileStateFailed(Failure()));
    } catch (e, stackTrace) {
      printCatch(e, stackTrace, runtimeType);
      emit(const ProfileStateFailed(Failure()));
    }
  }

  Future<void> _onEventSaveAvatar(
    ProfileEventSaveAvatar event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileStateLoading());

    try {
      final avatar = event.avatar;

      final profileProvider = ProfileProvider();
      await profileProvider.editAvatarNative(
        avatar: avatar,
      );

      emit(ProfileStateSuccess());
    } on ApiResultException catch (e) {
      final code = e.data['code'];
      printDebug(e);

      if (code == errorAccountNotExist) {
        emit(const ProfileStateFailed(FailureAccountNotExist()));
      } else if (code == errorIncorrectPassword) {
        emit(const ProfileStateFailed(FailureInvalidCredentials()));
      } else {
        emit(const ProfileStateFailed(Failure()));
      }
    } catch (e, stackTrace) {
      printCatch(e, stackTrace, runtimeType);
      emit(const ProfileStateFailed(Failure()));
    }
  }
}
