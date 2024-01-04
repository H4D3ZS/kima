import 'package:bloc/bloc.dart';
import 'package:kima/src/utils/enums.dart';

class AppFlavorCubit extends Cubit<AppFlavorsEnum> {
  AppFlavorCubit() : super(AppFlavorsEnum.none);

  void emitFlavor(AppFlavorsEnum flavor) {
    emit(flavor);
  }
}
