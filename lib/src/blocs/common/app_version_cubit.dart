import 'package:bloc/bloc.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionCubit extends Cubit<String> {
  final AppFlavorsEnum flavor;

  AppVersionCubit({
    required this.flavor,
  }) : super('');

  Future<void> emitVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final version = packageInfo.version;

    switch (flavor) {
      case AppFlavorsEnum.dev:
        emit('v$version - dev');
        break;
      case AppFlavorsEnum.qa:
        emit('v$version - qa');
        break;
      case AppFlavorsEnum.stg:
        emit('v$version - stg');
        break;
      case AppFlavorsEnum.none:
      case AppFlavorsEnum.prod:
      default:
        emit('v$version');
        break;
    }
  }
}
