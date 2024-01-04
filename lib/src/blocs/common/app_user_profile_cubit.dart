// import 'package:bloc/bloc.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:kima/src/data/models/user_profile.dart';
// import 'package:kima/src/utils/configs.dart';
// import 'package:kima/src/utils/helpers/print_helpers.dart';
// import 'package:kima/src/utils/helpers/shared_pref_helpers.dart';
//
// class AppUserProfileCubit extends Cubit<UserProfile?> {
//   AppUserProfileCubit() : super(null);
//
//   void emitUserProfile(UserProfile? userProfile) {
//     emit(userProfile);
//   }
//
//   Future<void> emitProfileJwt() async {
//     final token = await readStringSharedPref(spProfileJwt);
//     final tokenDecoded = JwtDecoder.decode(token!);
//     final userProfile = UserProfile.fromJson(tokenDecoded['account']);
//
//     printDebug(token, title: 'Token');
//     printDebug(userProfile, title: 'UserProfile');
//
//     emit(userProfile);
//   }
// }
